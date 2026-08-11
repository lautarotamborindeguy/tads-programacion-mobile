import 'package:flutter/material.dart';
import 'package:prueba/pages/lista_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool passwordVisible = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();

  void loguearse() {
    final password = passwordController.text;
    final user = usuarioController.text;
  
    if (password == "1234" && user == "usuario") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ListaPage()),
      );
    } else {
      mostrarAlerta('El usuario o la contraseña son incorrectos', 'Ingresa datos validos');
    } 
  }

 void mostrarAlerta(String titulo, String mensaje) {
   showDialog(
     context: context,
     builder: (context) {
       return AlertDialog(
         title: Text(titulo),
         content: Text(mensaje),
         actions: [
           TextButton(
             onPressed: () {
               Navigator.pop(context);
             },
             child: const Text('Aceptar'),
           ),
         ],
       );
     },
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: usuarioController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      loguearse();
                    },
                    child: const Text('Loguearse'),
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
