import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePage extends StatefulWidget {
  const ChangePage({super.key, this.username, this.newUser = false});

  final bool newUser;
  final String? username;

  @override
  State<ChangePage> createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _login() {
    TextInput.finishAutofillContext();

    Navigator.pushNamed(context, 'success', arguments: {
      'username': _usernameController.text,
      'password': _passwordController.text,
      'passwordConfirmation': _confirmPasswordController.text,
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
                  autofillHints: [
                    widget.newUser
                        ? AutofillHints.newUsername
                        : AutofillHints.username,
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
                autofillHints: const [AutofillHints.newPassword],
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [AutofillHints.newPassword],
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password confirmation'),
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: Text(widget.newUser ? 'Register' : 'Change password'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
