import 'package:flutter/material.dart';

class AnimatedBalanceContainer extends StatefulWidget {
  const AnimatedBalanceContainer({
    super.key,
  });

  @override
  State<AnimatedBalanceContainer> createState() =>
      _AnimatedBalanceContainerState();
}

class _AnimatedBalanceContainerState extends State<AnimatedBalanceContainer>{
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
          vertical: startAnimation ? 10 : 160,
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
