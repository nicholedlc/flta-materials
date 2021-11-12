// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  // A callback that lets you know when a new item is created
  final Function(GroceryItem) onCreate;
  // A callback that returns the updated grocery item
  final Function(GroceryItem) onUpdate;
  // The grocery item that the user clicked
  final GroceryItem? originalItem;
  // Determines whether the user is creating or editing an item
  final bool isUpdating;

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  // `nameController` listens for text changes. It controls the value displayed in a text field.
  final _nameController = TextEditingController();
  // `_GroceryItemScreenState` manages 6 different values:
  // (1) _name, (2) _importance, (3) _dueDate, (4) _timeOfDay,
  // (5) _currentColor, (6) _currentSliderValue
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  // Before a widget builds, `initState()` intiializes its properties before use.
  @override
  void initState() {
    // When the `originalItem` is not null, the user is editing an existing item.
    // In this case, you must configure the widget to show the item's values.
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    // Add listener to listen for text field changes, which then sets the name.
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });

      super.initState();
    });
  }

  // This will dispose your TextEditingController when you no longer need it.
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // `Scaffold` defines the main layout and structure of the entire screen
    return Scaffold(
      // Includes an app bar with one action button. The user will tap this button when they've finished creating an item.
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO 24: Add callback handler
            },
          ),
        ],
        // Removes the shadow under the app bar.
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      // Shows a `ListView`, padded by 16px on every side, within the body of the scaffold.
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // TODO 13: Add name TextField
            // TODO 14: Add Importance selection
            // TODO 15: Add date picker
            // TODO 16: Add time picker
            // TODO 17: Add color picker
            // TODO 18: Add slider
            // TODO: 19: Add Grocery Tile
          ],
        ),
      ),
    );
  }

  // TODO: Add buildNameField()

  // TODO: Add buildImportanceField()

  // TODO: ADD buildDateField()

  // TODO: Add buildTimeField()

  // TODO: Add buildColorPicker()

  // TODO: Add buildQuantityField()
}
