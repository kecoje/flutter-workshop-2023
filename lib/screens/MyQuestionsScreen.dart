import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:workshop2023/providers/StorageProvider.dart';

import '../model/Question.dart';
import '../style/MainInputDecoration.dart';
import '../widgets/MySnackBar.dart';

class MyQuestionsScreen extends StatefulWidget {
  const MyQuestionsScreen({super.key});

  @override
  State<MyQuestionsScreen> createState() => _MyQuestionsScreenState();
}

class _MyQuestionsScreenState extends State<MyQuestionsScreen> {
  final TextEditingController _textController = TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: Text('My Questions'),
            // onTap: () {
            //   Provider.of<PrefsProvider>(context, listen: false).myQuestions =
            //       null;
            // },
          ),
        ),
        body: Center(
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.blueAccent),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text(
                    "Add a new question",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  _buildTextInput(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      submitQuestion();
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: const Text(
                          "Submit",
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                        )),
                  ),
                ]),
              )),
        ));
  }

  Widget _buildTextInput() {
    return TextFormField(
      validator: (value) {
        if ((value ?? "").isEmpty) {
          return "Please enter the question text";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      controller: _textController,
      cursorColor: Colors.black,
      decoration: MainInputDecoration().copyWith(
          hintText: "Question text", prefixIcon: Icon(Icons.question_mark)),
    );
  }

  bool submitQuestion() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    Provider.of<StorageProvider>(context, listen: false).myQuestions = [
      Question(text: _textController.text),
      ...Provider.of<StorageProvider>(context, listen: false).myQuestions,
    ];

    ScaffoldMessenger.of(context)
        .showSnackBar(MySnackBar(text: 'Sucessfully added a new question!'));

    _textController.clear();

    return true;
  }
}
