import 'quiz.dart';
import 'package:flutter/material.dart';

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
              'lib/assets/12.jpg', 
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