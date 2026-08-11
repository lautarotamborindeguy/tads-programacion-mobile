import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: 
      Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child:  Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Label',
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: telefonoController,
                  decoration: const InputDecoration(
                    labelText: 'Label',
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: direccionController,
                  decoration: const InputDecoration(
                    labelText: 'Label',
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: const Text('Nombre $nombre'),
                  ),
                )
              ],
            )
          )
        ),
      )
    );
  }
}

