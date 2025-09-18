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