import 'package:flutter/material.dart';
import 'package:rcbank/services/authentication_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          leadingWidth: 75,
          leading: TextButton(
            onPressed: () async {
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
        body: const SingleChildScrollView(
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
                height: 180,
                child: FrequentlyUsedList(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: CommonOperationsList(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(),
      ),
    );
  }
}

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;

  List<IconData> icons = [
      Icons.attach_money_outlined, Icons.person_outline,
    ];

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: MediaQuery.of(context).size.width/2 - 52),
      decoration: BoxDecoration(
        color: Colors.black54.withOpacity(0.9),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.4),
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ]
      ),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastEaseInToSlowEaseOut,
            height: 40,
            width: 40,
            margin: EdgeInsets.only(left: selectedIndex * 40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[700],
            ),
          ),
          Row(
            children: List.generate(
              icons.length, (int index){
                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Icon(
                    icons[index],
                    size: 40,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class CommonOperationsList extends StatelessWidget {
  const CommonOperationsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<CommonOperation> commonOperations = [
      CommonOperation(
        icon: Icons.transform,
        text: 'Empréstimos',
      ),
      CommonOperation(
        icon: Icons.bar_chart_outlined,
        text: 'Investir',
      ),
      CommonOperation(
        icon: Icons.shield_outlined,
        text: 'Segurança',
      ),
      CommonOperation(
        icon: Icons.balance_outlined,
        text: 'Multas e IPVA',
      ),
    ];

    return Column(
      children: [
        for (var element in commonOperations)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Ink(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        element.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        element.icon,
                        size: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CommonOperation {
  CommonOperation({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;
}

class FrequentlyUsedList extends StatelessWidget {
  const FrequentlyUsedList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<FreqUsed> freqUsedList = [
      FreqUsed(
        icon: Icons.attach_money,
        text: 'Pix',
        color: Theme.of(context).colorScheme.primary,
        iconColor: Theme.of(context).colorScheme.onPrimary,
      ),
      FreqUsed(
        color: Colors.grey[200]!,
        icon: Icons.document_scanner_outlined,
        text: 'Pagar\nboleto',
        iconColor: Colors.black,
      ),
      FreqUsed(
        color: Colors.grey[200]!,
        icon: Icons.send_to_mobile_outlined,
        text: 'Pagar\npessoa',
        iconColor: Colors.black,
      ),
      FreqUsed(
        color: Colors.grey[200]!,
        icon: Icons.phone_android_outlined,
        text: 'Recarregar\ncelular',
        iconColor: Colors.black,
      ),
      FreqUsed(
        color: Colors.grey[200]!,
        icon: Icons.add,
        text: 'Mais',
        iconColor: Colors.black,
      ),
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: freqUsedList.length,
      itemBuilder: (context, index) {
        var element = freqUsedList[index];

        return Padding(
          padding: index == freqUsedList.length - 1
              ? const EdgeInsets.symmetric(horizontal: 20.0)
              : const EdgeInsets.only(left: 20.0),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Ink(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: element.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    element.icon,
                    color: element.iconColor,
                    size: 35,
                  ),
                ),
              ),
              Text(
                element.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FreqUsed {
  FreqUsed(
      {required this.color,
      required this.icon,
      required this.text,
      required this.iconColor});

  final Color color;
  final IconData icon;
  final String text;
  final Color iconColor;
}

class AnimatedBalanceContainer extends StatefulWidget {
  const AnimatedBalanceContainer({
    super.key,
  });

  @override
  State<AnimatedBalanceContainer> createState() =>
      _AnimatedBalanceContainerState();
}

class _AnimatedBalanceContainerState extends State<AnimatedBalanceContainer> {
  bool startAnimation = false;
  bool? contentVisible;

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0),
        () => setState(() => startAnimation = true));
  }

  onEnd() {
    setState(() {
      contentVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
      onEnd: onEnd,
      width: startAnimation ? MediaQuery.of(context).size.width : 0,
      height: startAnimation ? 300 : 0,
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(
          vertical: startAnimation ? 10 : 170,
          horizontal:
              startAnimation ? 0 : MediaQuery.of(context).size.width - 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
      ),
      child: (contentVisible ?? false)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Conta',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Saldo na conta',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Text(
                      'R\$ 0,00',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Adicionar Cartão',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
