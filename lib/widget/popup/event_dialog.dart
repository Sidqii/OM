import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_popup.dart';
import 'package:pusdatin_end/widget/popup/event_animations.dart';
import 'package:pusdatin_end/widget/popup/event_item.dart';

class EventDialog extends StatefulWidget {
  final DateTime selectedDay;
  final List<String> events;
  final bool isAdmin;

  const EventDialog({
    Key? key,
    required this.selectedDay,
    required this.events,
    this.isAdmin = false,
  }) : super(key: key);

  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;
  late Animation<double> _opacityAnimation;

  late List<EventItem> _eventItems;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _blurAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.forward();

    _eventItems = widget.events.map((event) => EventItem(event: event, isEditing: false, controller: TextEditingController(text: event))).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var item in _eventItems) {
      item.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        EventDialogAnimations(
          scaleAnimation: _scaleAnimation,
          blurAnimation: _blurAnimation,
          opacityAnimation: _opacityAnimation,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.8),
                    border: Border.all(color: Colors.grey.withOpacity(0.8), width: 0.7),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Kegiatan pada ${widget.selectedDay.toLocal().toString().split(' ')[0]}',
                              style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), shape: BoxShape.circle),
                              child: const Center(
                                child: Icon(Icons.close, size: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      widget.events.isNotEmpty
                          ? Column(
                              children: List.generate(_eventItems.length, (index) {
                                return EventItemWidget(
                                  eventItem: _eventItems[index],
                                  isAdmin: widget.isAdmin,
                                  onEdit: () => _toggleEdit(index),
                                  onSave: () => _saveEdit(index),
                                  onCancel: () => _cancelEdit(index),
                                );
                              }),
                            )
                          : Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Tidak ada kegiatan pada tanggal ini.',
                                style: TextStyle(color: Colors.white70, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _toggleEdit(int index) {
    setState(() {
      _eventItems[index].isEditing = !_eventItems[index].isEditing;
    });
  }

  void _saveEdit(int index) {
    setState(() {
      widget.events[index] = _eventItems[index].controller.text;
      _eventItems[index].isEditing = false;
    });
  }

  void _cancelEdit(int index) {
    setState(() {
      _eventItems[index].controller.text = widget.events[index];
      _eventItems[index].isEditing = false;
    });
  }
}
