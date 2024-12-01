import 'package:flutter/material.dart';

class EventItem {
  String event;
  bool isEditing;
  TextEditingController controller;

  EventItem({
    required this.event,
    required this.isEditing,
    required this.controller,
  });
}
