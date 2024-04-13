import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  
  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>{
  String? cpf;
  String? password;
  bool _visibility = true;

  toggleVisibility(){
    setState((){
      _visibility = !_visibility;
    });
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insira seu CPF',
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: TextField(
                    obscureText: _visibility,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: toggleVisibility,
                        icon: Icon(
                          _visibility 
                          ? Icons.visibility 
                          : Icons.visibility_off,
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
                  child: Text('Registrar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onPrimary)),
                  onPressed: (){

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}