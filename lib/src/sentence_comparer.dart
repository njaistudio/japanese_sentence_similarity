import 'package:japanese_sentence_similarity/src/string_utils.dart';
import 'package:japanese_sentence_similarity/src/transliterate_service.dart';
import  'package:string_similarity/string_similarity.dart';

class SentenceComparer {
  static Future<double> compare(String question, String answer, {List<String> requiredTexts = const [], bool keepHiragana = false}) async {
    final service = GoogleTransliterateService();
    final questionRomaji = await service.convertToRomaji(JssStringUtils.removeJapanesePunctuation(question), shouldLoadFromCache: true, keepHiragana: keepHiragana);
    final answerRomaji = await service.convertToRomaji(JssStringUtils.removeJapanesePunctuation(answer), keepHiragana: keepHiragana);
    if(requiredTexts.isNotEmpty) {
      for (var requiredText in requiredTexts) {
        if(!answerRomaji.contains(requiredText.romaji)) return 0;
      }
    }
    return questionRomaji.similarityTo(answerRomaji);
  }
}