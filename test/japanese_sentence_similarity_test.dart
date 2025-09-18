import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:japanese_sentence_similarity/japanese_sentence_similarity.dart';

void main() {
  test('compare', () async {
    WidgetsFlutterBinding.ensureInitialized();
    final similarity = await KanjiCompareService.compare("会議室は3階です", "かいぎしつは三階です");
    print(similarity);
    expect(similarity, 1);
  });
}
