import 'package:jp_transliterate/jp_transliterate.dart';
import 'package:kana_kit/kana_kit.dart';

const kanaKit = KanaKit();

class JssStringUtils {
  static String removeJapanesePunctuation(String text) {
    return text.replaceAll(RegExp(r'[^\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Han}\p{N}\p{L}]', unicode: true), '');
  }

  static List<String> removeNumberAndSpecial(List<String> arr) {
    List<String> clean = arr.map((s) {
      return s.replaceAll(
          RegExp(r'[^\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Han}]', unicode: true),
          ''
      );
    }).where((s) => s.isNotEmpty).toList();
    return clean;
  }

  static Future<String> getTransliteratedRomaji(String kanji) async {
    final transliterated = await JpTransliterate.transliterate(kanji: kanji);
    return transliterated.romaji.replaceAll(" ", "");
  }

  static String removeExceptions(String text) {
    final exceptions = {
      "あの方" : "あのかた",
      "いま、" : "今",
      "何時" : "なんじ",
      "いっかい" : "いちかい",
      "降りそうです" : "ふりそうです",
      "わたしのしゅみ" : "私の趣味",
      "絵を書く" : "絵をかく",
      "絵を描く" : "絵をかく",
      "1" : "一",
      "１" : "一",
      "2" : "二",
      "２" : "二",
      "3" : "三",
      "３" : "三",
      "4" : "四",
      "４" : "四",
      "5" : "五",
      "５" : "五",
      "6" : "六",
      "６" : "六",
      "7" : "七",
      "７" : "七",
      "8" : "八",
      "８" : "八",
      "9" : "九",
      "９" : "九"
    };

    exceptions.forEach((key, value) {
      if(text.contains(key)) {
        text = text.replaceAll(key, value);
      }
    });
    return text;
  }
}

extension JssStringExt on String {
  String get hiragana => kanaKit.toHiragana(this);
  String get romaji => kanaKit.toRomaji(this);
  String get katakana => kanaKit.toKatakana(this);
  bool get isHiragana => kanaKit.isHiragana(this);
  bool get isKana => kanaKit.isKana(this);
  bool get isJapanese => kanaKit.isJapanese(this);
  bool get isKatakana => kanaKit.isKatakana(this);
}