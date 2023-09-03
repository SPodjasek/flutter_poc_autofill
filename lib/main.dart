import 'package:flutter/material.dart';
import 'package:flutter_poc_autofill/change.dart';
import 'package:flutter_poc_autofill/success.dart';

import 'login.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Autofill PoC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const HomePage(),
        onGenerateRoute: (settings) {
          final Map<String, String>? args =
              settings.arguments as Map<String, String>?;

          switch (settings.name) {
            case 'login':
              return MaterialPageRoute(
                builder: (context) => const LoginPage(),
              );
            case 'login_offstage':
              return MaterialPageRoute(
                builder: (context) => LoginPage(
                  username: args!['username'],
                ),
              );
            case 'register':
              return MaterialPageRoute(
                builder: (context) => const ChangePage(
                  newUser: true,
                ),
              );
            case 'register_offstage':
              return MaterialPageRoute(
                builder: (context) => ChangePage(
                  newUser: true,
                  username: args!['username'],
                ),
              );
            case 'recover':
              return MaterialPageRoute(
                builder: (context) => const ChangePage(),
              );
            case 'recover_offstage':
              return MaterialPageRoute(
                builder: (context) => ChangePage(
                  username: args!['username'],
                ),
              );
            case 'success':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => const SuccessPage(),
              );
          }
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final String randomPart =
        DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    _usernameController.text = 'random.user$randomPart@gmail.com';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Autofill PoC Home Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autofillHints: const [
                  AutofillHints.username,
                  AutofillHints.email,
                ],
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Default username'),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login_offstage', arguments: {
                    'username': _usernameController.text,
                  });
                },
                child: const Text('Login (offstage username)'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register_offstage', arguments: {
                    'username': _usernameController.text,
                  });
                },
                child: const Text('Register (offstage username)'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'recover');
                },
                child: const Text('Change password'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'recover_offstage', arguments: {
                    'username': _usernameController.text,
                  });
                },
                child: const Text('Change password (offstage username)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
