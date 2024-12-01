import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_popup.dart';

class EventItemWidget extends StatelessWidget {
  final EventItem eventItem;
  final bool isAdmin;
  final Function onEdit;
  final Function onSave;
  final Function onCancel;

  const EventItemWidget({
    Key? key,
    required this.eventItem,
    required this.isAdmin,
    required this.onEdit,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.event_note, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 40,
              child: eventItem.isEditing
                  ? _buildTextField()
                  : _buildTextDisplay(),
            ),
          ),
          if (isAdmin) _buildEditSaveCancelButtons(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: eventItem.controller,
      onChanged: (value) {
        eventItem.event = value;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        hintText: 'Edit Event',
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTextDisplay() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        eventItem.event,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildEditSaveCancelButtons() {
    return IconButton(
      icon: Icon(
        eventItem.isEditing ? Icons.check : Icons.edit,
        color: Colors.white,
      ),
      onPressed: () {
        if (eventItem.isEditing) {
          onSave();
        } else {
          onEdit();
        }
      },
    );
  }
}
