import 'package:japanese_sentence_similarity/src/string_utils.dart';
import 'package:japanese_sentence_similarity/src/transliterate_service.dart';
import  'package:string_similarity/string_similarity.dart';

class KanjiCompareService {
  static Future<double> compare(String text1, String text2) async {
    final service = GoogleTransliterateService();
    final romaji1 = await service.convertToRomaji(StringUtils.removeJapanesePunctuation(text1));
    final romaji2 = await service.convertToRomaji(StringUtils.removeJapanesePunctuation(text2));
    return romaji1.similarityTo(romaji2);
  }
}