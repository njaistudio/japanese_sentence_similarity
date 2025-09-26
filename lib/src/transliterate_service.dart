import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:japanese_sentence_similarity/src/cache_helper.dart';
import 'package:japanese_sentence_similarity/src/string_utils.dart';

class TransliterateToken {
  final String surface;
  final List<String> variants;

  TransliterateToken({
    required this.surface,
    required this.variants,
  });

  factory TransliterateToken.fromJson(List<dynamic> json) {
    return TransliterateToken(
      surface: json[0] as String,
      variants: List<String>.from(json[1]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surface': surface,
      'variants': variants,
    };
  }

  @override
  String toString() {
    return 'TransliterateToken(surface: $surface, variants: $variants)';
  }
}

class TransliterateResult {
  final List<TransliterateToken> tokens;
  final bool keepHiragana;

  TransliterateResult({required this.tokens, this.keepHiragana = false});

  factory TransliterateResult.fromJson(List<dynamic> json, {bool keepHiragana = false}) {
    return TransliterateResult(
      tokens: json.map((e) => TransliterateToken.fromJson(e)).toList(),
      keepHiragana: keepHiragana,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokens': tokens.map((t) => t.toJson()).toList(),
    };
  }

  String get transliteratedText => tokens.map((token) {
    if(token.surface.isHiragana && keepHiragana) {
      return token.surface;
    }
    return JssStringUtils.removeNumberAndSpecial(token.variants).first;
  }).join();

  Future<String> getTransliteratedRomaji() async {
    return await JssStringUtils.getTransliteratedRomaji(transliteratedText);
  }

  @override
  String toString() {
    return 'TransliterateResult(tokens: $tokens)';
  }
}

class GoogleTransliterateService {
  final String baseUrl = "http://www.google.com/transliterate?langpair=ja-Hira|ja&text=";

  Future<String> convertToRomaji(String text, {bool shouldLoadFromCache = false, bool keepHiragana = false}) async {
    if(shouldLoadFromCache) {
      final cacheData = await CacheHelper.getData(text);
      if(cacheData != null) {
        return cacheData;
      }
    }

    final url = Uri.parse(baseUrl + Uri.encodeComponent(text));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final result = TransliterateResult.fromJson(data, keepHiragana: keepHiragana);
      final romaji = await result.getTransliteratedRomaji();
      if(shouldLoadFromCache) await CacheHelper.saveData(text, romaji);
      return romaji;
    } else {
      throw Exception("Failed to fetch transliterate data: ${response.statusCode}");
    }
  }
}