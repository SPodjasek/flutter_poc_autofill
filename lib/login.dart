import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.username});

  final String? username;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.username != null) {
      _usernameController.text = widget.username!;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _login() {
    TextInput.finishAutofillContext();

    Navigator.pushNamed(context, 'success', arguments: {
      'username': _usernameController.text,
      'password': _passwordController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Offstage(
                offstage: widget.username != null,
                child: TextField(
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Username'),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              if (widget.username != null)
                Text(
                  'Username in offstage text field: ${widget.username}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [AutofillHints.password],
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
