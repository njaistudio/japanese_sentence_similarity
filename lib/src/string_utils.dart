import 'package:kana_kit/kana_kit.dart';

const kanaKit = KanaKit();

class StringUtils {
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
}

extension StringExt on String {
  String get hiragana => kanaKit.toHiragana(this);
  String get romaji => kanaKit.toRomaji(this);
  String get katakana => kanaKit.toKatakana(this);
  bool get isHiragana => kanaKit.isHiragana(this);
  bool get isKana => kanaKit.isKana(this);
  bool get isJapanese => kanaKit.isJapanese(this);
  bool get isKatakana => kanaKit.isKatakana(this);
}