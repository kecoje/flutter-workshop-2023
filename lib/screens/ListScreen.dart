import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:workshop2023/model/Question.dart';
import 'package:workshop2023/providers/StorageProvider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>
    with SingleTickerProviderStateMixin {
  List<Question> questions = [];
  int questionCounter = 0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<Offset> _offsetFrontAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.5),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutSine,
  ));
  late final Animation<Offset> _offsetRearAnimation = Tween<Offset>(
    begin: const Offset(1.5, -0.5),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutSine,
  ));

  asyncLoadQuestions(StorageProvider storageProvider) async {
    final String allTxt = await loadAsset();
    final List<String> texts = allTxt.split('\n');

    setState(() {
      questions = [
        ...storageProvider.myQuestions,
        ...texts.map((String text) => Question(text: text)).toList()
      ];
    });
  }

  @override
  void initState() {
    final storageProvider =
        Provider.of<StorageProvider>(context, listen: false);

    asyncLoadQuestions(storageProvider);

    super.initState();
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/Questions.txt');
  }

  void incrementCounter() async {
    await _controller.forward();
    setState(() {
      questionCounter += 1;
      questionCounter %= questions.length;
    });
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play'),
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SlideTransition(
              position: _offsetFrontAnimation,
              child: GestureDetector(
                onTap: incrementCounter,
                child: _buildFront(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SlideTransition(
              position: _offsetRearAnimation,
              child: GestureDetector(
                onTap: incrementCounter,
                child: _buildRear(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(String text, [Color color = Colors.blueAccent]) {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: color),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget _buildFront() {
    return _buildCard(questionCounter < questions.length
        ? questions[questionCounter].text
        : '');
  }

  Widget _buildRear() {
    return _buildCard(questions.length > 1
        ? questions[(questionCounter + 1) % questions.length].text
        : '');
  }
}
