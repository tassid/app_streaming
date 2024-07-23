import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({super.key});

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    return null;
  }

  @override
  void dispose() {
    _passwordController.dispose(); //limpar o controlador
    super.dispose(); //limpar a memória
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      style: const TextStyle(color: Colors.white),
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        hintText: 'Senha',
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: _validatePassword,
    );
  }
}
