import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rcbank/components/common_operations_list.dart';
import 'package:rcbank/components/custom_navigation_bar.dart';
import 'package:rcbank/components/frequently_used_list.dart';
import 'package:rcbank/services/authentication_service.dart';

import 'components/animated_balance_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthenticationService _authenticationService = AuthenticationService();
  late PageController _pageController;
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final List<Widget> _pages = const [
    BalancePage(),
    Text('a'),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedIndex.addListener(() => setState((){}));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
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
