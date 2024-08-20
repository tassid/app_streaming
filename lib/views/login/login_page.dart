import 'package:app_streaming/views/login/password_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_streaming/services/api_service.dart'; // Importe o ApiService

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiService _apiService = ApiService(); // Instancie o ApiService

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um e-mail válido';
    }
    return null;
  }

  Future<void> _loginWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Fazendo login com Firebase Auth
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Obter o usuário autenticado
        User? user = FirebaseAuth.instance.currentUser;
        String? email = user?.email;

        // Verificar ou criar perfil no backend Flask em segundo plano
        if (email != null) {
          _apiService
              .verifyOrCreateUserProfile(email); // Executa em segundo plano
        }

        // Navegar para a próxima página imediatamente
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/whoswatching", (route) => false);
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'Usuário não encontrado.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Senha incorreta.';
        } else {
          errorMessage = 'Erro: ${e.message}';
        }
        _showErrorDialog(errorMessage);
      } catch (e) {
        _showErrorDialog('Erro desconhecido. Tente novamente mais tarde.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose(); // Dispose the password controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131313),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SvgPicture.asset(
          'assets/netflix_logo.svg',
          height: 22,
        ),
        actions: [
          TextButton(
            onPressed: () {
              launchUrlString('https://help.netflix.com/pt');
            },
            child: const Text(
              "Ajuda",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Entrar na Netflix',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'E-mail',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),
                PasswordTextFieldWidget(
                  controller: _passwordController,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    launchUrlString('https://www.netflix.com/password');
                  },
                  child: const Text(
                    'Recuperar Senha?',
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loginWithEmailAndPassword,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 16),
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    launchUrlString('https://www.netflix.com/');
                  },
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
