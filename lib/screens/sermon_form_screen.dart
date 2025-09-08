// ignore_for_file: avoid_print

import 'package:aetheria/utils/app_theme.dart';
import 'package:flutter/material.dart';

class SermonFormScreen extends StatelessWidget {
  SermonFormScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _feelingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.skyBlue,

        title: Text('Sermon Form'),
      ),

      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _feelingController,
                maxLines: 10,
                maxLength: 1000,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 16.0),

                decoration: InputDecoration(
                  labelText: 'Tell us what you are feeling',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: AppTheme.skyBlue, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                    print(_feelingController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.skyBlue,
                ),
                child: const Text(
                  'Generate Sermon',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
