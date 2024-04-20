import 'package:flutter/material.dart';
import 'package:rcbank/services/authentication_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        leading: TextButton(
          onPressed: () async{
            await _authenticationService.logout();
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sair'),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                constraints: BoxConstraints.expand(
                    width: MediaQuery.of(context).size.width - 50, height: 200),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text('a'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}