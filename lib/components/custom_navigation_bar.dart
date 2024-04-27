import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  final ValueNotifier selectedIndex;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  List<IconData> icons = [
    Icons.attach_money_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: MediaQuery.of(context).size.width / 2 - 52),
      decoration: BoxDecoration(
          color: Colors.black54.withOpacity(0.9),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withAlpha(125),
              offset: const Offset(0, 5),
              blurRadius: 2,
            ),
          ]),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastEaseInToSlowEaseOut,
            height: 40,
            width: 40,
            margin: EdgeInsets.only(left: widget.selectedIndex.value * 40.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[800],
            ),
          ),
          Row(
            children: List.generate(icons.length, (int index) {
              return GestureDetector(
                  onTap: () => setState(() => widget.selectedIndex.value = index),
                  child: Icon(
                    icons[index],
                    size: 40,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ));
            }),
          ),
        ],
      ),
    );
  }
}
