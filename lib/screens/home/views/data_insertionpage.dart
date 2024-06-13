import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';


class DataInsertionPage extends StatelessWidget {
  final _formKeys = List.generate(4, (_) => GlobalKey<FormState>());
  final _controllers = List.generate(4, (_) => List.generate(5, (_) => TextEditingController()));

  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inserção de Dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Form(
              key: _formKeys[index],
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coleção ${index + 1}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ...List.generate(5, (fieldIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: _controllers[index][fieldIndex],
                            decoration: InputDecoration(
                              labelText: 'Campo ${fieldIndex + 1}',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              return null;
                            },
                          ),
                        );
                      }),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKeys[index].currentState?.validate() ?? false) {
                            // Monta os dados a partir dos TextEditingControllers
                            Map<String, dynamic> data = {
                              'campo1': _controllers[index][0].text,
                              'campo2': _controllers[index][1].text,
                              'campo3': _controllers[index][2].text,
                              'campo4': _controllers[index][3].text,
                              'campo5': _controllers[index][4].text,
                            };
                            userRepo.inserirDados('colecao${index + 1}', data);
                          }
                        },
                        child: Text('Inserir Dados'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
