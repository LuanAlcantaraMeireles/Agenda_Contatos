import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Agenda(),
    );
  }
}

class Contato {
  final String nome;
  final String telefone;
  final String email;

  Contato({required this.nome, required this.telefone, required this.email});
}

class Agenda extends StatefulWidget {
  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  final List<Contato> contatos = [];
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          Contato contato = contatos[index];
          return GestureDetector(
            onTap: () {
              _criarEditarContato(context, contato: contato);
            },
            child: ListTile(
              title: Text(contato.nome),
              subtitle: Text('${contato.telefone} | ${contato.email}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _criarEditarContato(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _criarEditarContato(BuildContext context, {Contato? contato}) {
    nomeController.text = contato?.nome ?? '';
    telefoneController.text = contato?.telefone ?? '';
    emailController.text = contato?.email ?? '';


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${contato != null ? 'Editar' : 'Criar'} Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String nome = nomeController.text;
                String telefone = telefoneController.text;
                String email = emailController.text;

                if (nome.isNotEmpty && telefone.isNotEmpty && email.isNotEmpty) {
                  setState(() {
                    if (contato != null) {
                      int index = contatos.indexOf(contato);
                      contatos[index] = Contato(nome: nome, telefone: telefone, email: email);
                    } else {
                      contatos.add(Contato(nome: nome, telefone: telefone, email: email));
                    }
                  });
                  Navigator.pop(context);
                } else {
                  // Mostrar mensagem de erro
                }
              },
              child: Text('${contato != null ? 'Salvar' : 'Criar'}'),
            ),
          ],
        );
      },
    );
  }
}