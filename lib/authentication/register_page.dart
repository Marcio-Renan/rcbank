import 'package:flutter/material.dart';
import 'package:rcbank/common/dialog_manager.dart';
import 'package:rcbank/common/success_dialog.dart';
import 'package:rcbank/common/loading_dialog.dart';
import 'package:rcbank/services/authentication_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final DialogManager _dialogManager = DialogManager();
  final TextEditingController _passwordController = TextEditingController();

  final AuthenticationService _authenticationService = AuthenticationService();

  bool _visibility = true;

  toggleVisibility() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  register() async {
    _dialogManager.buildDialog(context, const LoadingDialog());

    String email = _emailController.text;
    String password = _passwordController.text;
    
    String? error =
        await _authenticationService.register(email: email, password: password);
    if (error == null) {
      _dialogManager.changeDialog(const SuccessDialog(
          message: "Conta cadastrada com sucesso.", success: true));
    } else {
      _dialogManager
          .changeDialog(SuccessDialog(message: error, success: false));
      await Future.delayed(const Duration(seconds: 2));
      _dialogManager.dismissDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registre-se'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insira seu e-mail',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _visibility,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: toggleVisibility,
                        icon: Icon(
                          _visibility ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      hintText: 'Insira sua senha',
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: register,
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
