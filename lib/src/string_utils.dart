class StringUtils {
  static String removeJapanesePunctuation(String text) {
    return text.replaceAll(RegExp(r'[^\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Han}\p{N}\p{L}]', unicode: true), '');
  }
}