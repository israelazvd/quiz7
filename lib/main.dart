import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Cristiano'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/12.png', 
              width: 750, 
              height: 500,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Bem-vindo ao Quiz do Cristiano Ronaldo ⚽!',
              style: TextStyle(fontSize: 24, color: Colors.deepPurple),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Começar Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}


class Question {
  final String questionText;
  final List<String> answers;
  final String correctAnswer;
  final String imagePath; 

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswer,
    required this.imagePath,
  });
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question(
      questionText: '1-Em qual país Cristiano Ronaldo nasceu?',
      answers: ['Espanha', 'Portugal', 'Brasil', 'Bahia'],
      correctAnswer: 'Portugal',
      imagePath:'lib/assets/01.png'

    ),
    Question(
      questionText: '2-Qual é o nome completo de Cristiano Ronaldo?',
      answers: ['Cristiano Ronaldo dos Santos Aveiro','Cristiano Ronaldo de Almeida Santos','Cristiano Ronaldo Vieira','Cristiano Ronaldo da Silva Santos'],
      correctAnswer: 'Cristiano Ronaldo dos Santos Aveiro',
      imagePath: 'lib/assets/02.jpg',
    ),
    Question(
      questionText: '3-Qual é a data de nascimento de Cristiano Ronaldo?',
      answers: ['5 de fevereiro de 1983', '5 de fevereiro de 1985', '5 de fevereiro de 1987 ', ' 5 de fevereiro de 1988'],
      correctAnswer: '5 de fevereiro de 1985',
      imagePath: 'lib/assets/03.jpg',
    ),
    Question(
      questionText: '4-Em qual time português Cristiano Ronaldo começou sua carreira profissional?',
      answers: ['Benfica', 'Porto', 'Sporting CP', 'Marítimo'],
      correctAnswer: 'Sporting CP',
      imagePath: 'lib/assets/04.jpg',
    ),
    Question(
      questionText: '5-Qual foi o primeiro clube internacional de Cristiano Ronaldo?',
      answers: ['Real Madrid', 'Juventus', 'Manchester United', 'Florença'],
      correctAnswer: 'Manchester United',
      imagePath: 'lib/assets/05.png',
    ),
     Question(
      questionText: '6-Quantas vezes Cristiano Ronaldo ganhou a Liga dos Campeões da UEFA até 2023?',
      answers: ['4', '5', '6', '7'],
      correctAnswer: '5',
      imagePath: 'lib/assets/06.png',
    ),
    Question(
      questionText:'7-Quando Cristiano Ronaldo venceu sua primeira Bola de Ouro em que ano?',
      answers: ['2005', '2007', '2009', '2008'],
      correctAnswer: '2008',
      imagePath: 'lib/assets/07.png',
    ),
    Question(
      questionText:'8-Qual time Cristiano Ronaldo escolheu após deixar o Real Madrid em 2018?',
      answers: ['Paris Saint-Germain', 'Manchester City', 'Juventus', 'Sporting CP'],
      correctAnswer: 'Juventus',
      imagePath: 'lib/assets/08.png',
    ),
    Question(
      questionText:'9-Em qual dos seguintes países Cristiano Ronaldo NÃO jogou profissionalmente?',
      answers: ['Inglaterra', 'Italia', 'França', 'Espanha'],
      correctAnswer: 'França',
      imagePath: 'lib/assets/09.png',
    ),
    Question(
      questionText:'10-Cristiano Ronaldo é o maior artilheiro de todos os tempos da Liga dos Campeões da UEFA. Quantos gols ele marcou para obter essa marca (até 2023)?',
      answers: ['120', '129', '140', '150'],
      correctAnswer: '140',
      imagePath: 'lib/assets/10.png',
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  String message = '';
  Color messageColor = Colors.black;
  bool answerSelected = false;
  late Timer timer;
  int timeLeft = 10;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

   void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          nextQuestion();
        }
      });
    });
  }

  void checkAnswer(String answer) {
    if (!answerSelected) {
      timer.cancel(); 
      setState(() {
        if (answer == questions[currentQuestionIndex].correctAnswer) {
          score += 5;
          message = 'Resposta correta!';
          messageColor = Colors.green;
        } else {
          message = 'Resposta errada!';
          messageColor = Colors.red;
        }
        answerSelected = true;
      });

      Future.delayed(Duration(seconds: 2), nextQuestion);
    }
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        answerSelected = false;
        message = '';
        messageColor = Colors.black;
        timeLeft = 10;
        startTimer();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScorePage(score: score, onRestart: resetQuiz),
          ),
        );
      }
    });
  }

 void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      answerSelected = false;
      message = '';
      messageColor = Colors.black;
      timeLeft = 10;
    });
    Navigator.popUntil(context, (route) => route.isFirst);
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel(); 
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              questions[currentQuestionIndex].imagePath,
              fit: BoxFit.contain,
              width: 800,
              height: 400,
            ),
            SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 60, 16, 163)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: timeLeft / 10,
                  valueColor: AlwaysStoppedAnimation(
                    timeLeft > 5 ? Colors.green : Colors.red,
                  ),
                  strokeWidth: 8,
                ),
                Text(
                  '$timeLeft',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: timeLeft > 5 ? Colors.black : Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ...(questions[currentQuestionIndex].answers).map((answer) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(answer),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(answer),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(fontSize: 20, color: messageColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ScorePage extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  ScorePage({required this.score, required this.onRestart});

  String getPerformance(int score) {
    if (score >= 40) {
      return 'Excelente!';
    } else if (score >= 30) {
      return 'Muito bom!';
    } else if (score >= 20) {
      return 'Bom!';
    } else {
      return 'Você não foi bem, Tente mais uma vez!';
    }
  }

  @override
  Widget build(BuildContext context) {
    String performance = getPerformance(score);

    // Condicional para exibir uma imagem específica conforme a pontuação
    String imagePath;
    if (score < 20) {
      imagePath = 'lib/assets/13.png'; // imagem para pontuação abaixo de 20
    } else {
      imagePath = 'lib/assets/14.png'; // imagem para outras pontuações
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pontuação Final'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 600,
              height: 600,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              'Quiz finalizado!\nSua pontuação: $score pontos',
              style: TextStyle(fontSize: 24, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Seu desempenho: $performance',
              style: TextStyle(fontSize: 22, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: onRestart,
              child: Text('Refazer Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}