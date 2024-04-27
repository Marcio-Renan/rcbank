import 'package:flutter/material.dart';

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