import 'package:flutter/material.dart';

class DropdownMenu extends StatefulWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final List<String> items;

  const DropdownMenu({
    Key? key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    this.items = const ['Kondisi', 'Merek'],
  }) : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> with SingleTickerProviderStateMixin {
  bool isOpen = false;

  void _toggleDropdown() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.selectedCategory,
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.black),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: isOpen
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white60.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: widget.items.map((String item) {
                      return GestureDetector(
                        onTap: () {
                          widget.onCategoryChanged(item);
                          _toggleDropdown();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          child: Text(
                            item,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
