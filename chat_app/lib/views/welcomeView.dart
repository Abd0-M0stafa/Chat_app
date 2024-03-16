import 'package:chat_app/views/loginView.dart';
import 'package:chat_app/views/registerView.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            stops: [
              .02,
              .75,
            ],
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 28, 228, 167),
              Color.fromARGB(255, 23, 22, 22),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Center(
              child: SizedBox(
                height: 250,
                child: Image.asset('images/chatting.png'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, bottom: 210),
              child: Text(
                'Discover and Strengthen\n your relationships here',
                style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1, 2),
                        blurRadius: 1,
                      )
                    ],
                    color: Color.fromARGB(255, 28, 228, 167),
                    fontSize: 25,
                    fontFamily: 'BebasNeue'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: SizedBox(
                    width: 105,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 28, 228, 167),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const LoginView(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const RegisterView(),
                      ),
                    );
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Color.fromARGB(255, 28, 228, 167),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
