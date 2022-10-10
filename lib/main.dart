import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final mailController = TextEditingController();
  final passController = TextEditingController();

  bool isDisplay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_title.png'),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text('ログインメールアドレス'),
                            ],
                          ),
                          TextFormField(
                            controller: mailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: const [
                              Text('パスワード'),
                            ],
                          ),
                          TextFormField(
                            obscureText: isDisplay,
                            controller: passController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // 対象 ? true : false
                                  isDisplay
                                      ? Icons.remove_red_eye
                                      : Icons.elderly,
                                ),
                                onPressed: () {
                                  // アイコンを押した時にアイコンの表示を変更

                                  setState(() {
                                    isDisplay = !isDisplay;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () async {
                                  final auth = FirebaseAuth.instance;
                                  await auth.createUserWithEmailAndPassword(
                                    email: mailController.text,
                                    password: passController.text,
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffFF9800)),
                                ),
                                child: const Text('ログイン')),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: const Color(0xffFF9800),
                              ),
                              children: [
                                TextSpan(
                                  text: 'パスワードを忘れた方はこちら ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('ボタンを押しました');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
