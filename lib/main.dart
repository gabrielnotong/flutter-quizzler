import 'package:flutter/material.dart';
import 'package:quizzler/question_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionModel qm = QuestionModel();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void displayScore(bool userAnswer, bool correctAnswer) {
    if (userAnswer == correctAnswer) {
      scoreKeeper.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      scoreKeeper.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  void checkScore(bool userAnswer) {
    bool correctAnswer = qm.getQuestionAnswer();

    if (qm.canContinue()) {
      displayScore(userAnswer, correctAnswer);
    } else {
      displayScore(userAnswer, correctAnswer);

      Alert(
        closeIcon: Icon(
          Icons.close,
          color: Colors.red,
        ),
        title: 'Info!',
        type: AlertType.info,
        desc: 'All questions answered',
        buttons: [
          DialogButton(
            child: Text('Restart'),
            onPressed: () {
              setState(() {
                qm.reset();
                scoreKeeper = [];
              });
            },
          ),
        ],
        context: context,
      ).show();
    }

    setState(() {
      qm.next();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    qm.getQuestionText(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text(
                    'True',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    checkScore(true);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text(
                    'False',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    checkScore(true);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                ),
              ),
            ),
            Row(
              children: scoreKeeper,
            )
          ],
        ),
      ),
    );
  }
}
