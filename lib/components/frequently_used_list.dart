import 'package:flutter/material.dart';

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