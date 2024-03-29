import 'package:flutter/material.dart';
import 'package:flutter_final/themes/default_theme.dart';

List<String> generos = <String> ["-","Acción", "Aventura", "Animación", "Comedia", "Crimen", "Documental", "Suspenso", "Terror","Ciencia ficción"];


class GenerosDropdownButton extends StatefulWidget {
  final Function(String) onGeneroChanged;
  const GenerosDropdownButton({super.key, required this.onGeneroChanged});

  @override
  State<GenerosDropdownButton> createState() => _GenerosDropdownButtonState();
}


class _GenerosDropdownButtonState extends State<GenerosDropdownButton> {
  String dropdownValue = generos.first;

  void _handleGeneroChanged(String newGenero) {
  setState(() {
    dropdownValue = newGenero;
  });

  widget.onGeneroChanged(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      focusColor: Colors.transparent,
      dropdownColor: AppThemes.darkTheme().primaryColor,
      iconEnabledColor: AppThemes.darkTheme().indicatorColor,
      elevation: 16,
      style: AppThemes.simpleTextColor(),
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(10),
      underline: Container(
        height: 2,
        color: const Color.fromARGB(0, 255, 255, 255),
      ),
      onChanged: (String? value) {
        _handleGeneroChanged(value!);
      },
      items: generos.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList()
      );
      }
  }

