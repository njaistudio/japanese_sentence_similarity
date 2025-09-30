import 'package:japanese_sentence_similarity/src/string_utils.dart';
import  'package:string_similarity/string_similarity.dart';

class SentenceComparer {
  static Future<double> compare(String question, String answer, {List<String> requiredTexts = const []}) async {
    final questionRomaji = await JssStringUtils.getTransliteratedRomaji(
      JssStringUtils.removeJapanesePunctuation(
        JssStringUtils.removeExceptions(question),
      ),
    );
    final answerRomaji = await JssStringUtils.getTransliteratedRomaji(
      JssStringUtils.removeJapanesePunctuation(
        JssStringUtils.removeExceptions(answer),
      ),
    );

    final requiredRomajis = [];
    for (var requiredText in requiredTexts) {
      final requiredRomaji = await JssStringUtils.getTransliteratedRomaji(JssStringUtils.removeExceptions(requiredText));
      requiredRomajis.add(requiredRomaji);
    }

    print("questionRomaji: $question - $questionRomaji");
    print("answerRomaji: $answer - $answerRomaji");
    print("requiredRomaji: $requiredTexts - $requiredRomajis");
    print("compare Romaji: ${questionRomaji.similarityTo(answerRomaji)}");
    if(requiredRomajis.isNotEmpty) {
      for (var requiredRomaji in requiredRomajis) {
        if(!answerRomaji.contains(requiredRomaji)) return 0;
      }
    }
    return questionRomaji.similarityTo(answerRomaji);
  }
}