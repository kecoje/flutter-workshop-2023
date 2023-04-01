import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop2023/model/Question.dart';

class StorageProvider extends ChangeNotifier {
  List<Question>? _myQuestions;

  final SharedPreferences _sharedPreferences;

  StorageProvider(SharedPreferences sp) : _sharedPreferences = sp {
    myQuestions = sp
            .getStringList('localQuestions')
            ?.map((String s) => Question.fromString(s))
            .toList() ??
        [];
  }

  List<Question> get myQuestions => _myQuestions ?? [];
  set myQuestions(List<Question>? myQuestions) {
    _myQuestions = myQuestions;
    if (_myQuestions != null) {
      _sharedPreferences.setStringList('localQuestions',
          _myQuestions!.map((Question q) => q.toString()).toList());
    } else {
      _sharedPreferences.remove('localQuestions');
    }
  }
}
