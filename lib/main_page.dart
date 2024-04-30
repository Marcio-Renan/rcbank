import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcbank/components/common_operations_list.dart';
import 'package:rcbank/components/custom_navigation_bar.dart';
import 'package:rcbank/components/frequently_used_list.dart';
import 'package:rcbank/services/authentication_service.dart';

import 'components/animated_balance_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.user});

  final User user;

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const BalancePage(),
      ProfilePage(user: widget.user),
    ];
    _selectedIndex.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _selectedIndex.value == 1 ? Colors.grey[300] : null,
        extendBody: true,
        appBar: AppBar(
          title: Text(_selectedIndex.value == 0 ? 'Conta' : 'Perfil'),
          leading: IconButton(
            onPressed: () async {
              await _authenticationService.logout();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex.value,
          children: _pages,
        ),
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}

class BalancePage extends StatefulWidget {
  const BalancePage({
    super.key,
  });

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: AnimatedBalanceContainer(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              'Usados com frequência',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 170,
            child: FrequentlyUsedList(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CommonOperationsList(),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final User user;

  static const Map<String, List<String>> configurationsList = {
    'Configurações da conta': ['Mudar e-mail', 'Mudar senha', 'Excluir conta', 'Contas conectadas'],
    'Configurações do aplicativo': ['Mudar tema', 'Relatar problema', 'Desativar notificações'],
    'Pix' : ['Minhas chaves'],
    'Mensagens diretas' : ['Conversas bloqueadas'],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Center(
                          child: Text(
                            user.email![0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 50,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.email!,
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (var key in configurationsList.keys)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  child: Text(key),
                ),
                for (var element in configurationsList[key]!)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.5),
                    child: InkWell(
                      onTap: () {},
                      child: Ink(
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            element,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
