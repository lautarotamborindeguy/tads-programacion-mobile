import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/cursando_dao.dart';
import 'dao/disciplina_dao.dart';
import 'dao/estudante_dao.dart';
import 'models/cursando.dart';
import 'models/disciplina.dart';
import 'models/estudante.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro Academico',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro Academico'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Estudantes', icon: Icon(Icons.person)),
              Tab(text: 'Disciplinas', icon: Icon(Icons.menu_book)),
              Tab(text: 'Cursando', icon: Icon(Icons.school)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EstudantesPage(),
            DisciplinasPage(),
            CursandoPage(),
          ],
        ),
      ),
    );
  }
}

class EstudantesPage extends StatefulWidget {
  const EstudantesPage({super.key});

  @override
  State<EstudantesPage> createState() => _EstudantesPageState();
}

class _EstudantesPageState extends State<EstudantesPage> {
  final _nomeController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _dao = EstudanteDao();

  List<Estudante> _estudantes = [];
  Estudante? _estudanteAtual;

  @override
  void initState() {
    super.initState();
    _carregarEstudantes();
  }

  Future<void> _carregarEstudantes() async {
    final estudantes = await _dao.getEstudantes();
    setState(() => _estudantes = estudantes);
  }

  Future<void> _guardar() async {
    final nome = _nomeController.text.trim();
    final matricula = _matriculaController.text.trim();
    if (nome.isEmpty || matricula.isEmpty) return;

    if (_estudanteAtual == null) {
      await _dao.addEstudante(Estudante(nome: nome, matricula: matricula));
    } else {
      _estudanteAtual!
        ..nome = nome
        ..matricula = matricula;
      await _dao.updateEstudante(_estudanteAtual!);
    }

    _limparFormulario();
    await _carregarEstudantes();
  }

  void _editar(Estudante estudante) {
    setState(() {
      _estudanteAtual = estudante;
      _nomeController.text = estudante.nome;
      _matriculaController.text = estudante.matricula;
    });
  }

  Future<void> _eliminar(Estudante estudante) async {
    await _dao.deleteEstudante(estudante);
    if (_estudanteAtual?.id == estudante.id) {
      _limparFormulario();
    }
    await _carregarEstudantes();
  }

  void _limparFormulario() {
    setState(() {
      _estudanteAtual = null;
      _nomeController.clear();
      _matriculaController.clear();
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _matriculaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CrudPageLayout(
      form: Column(
        children: [
          TextField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _matriculaController,
            decoration: const InputDecoration(
              labelText: 'Matricula',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FormButtons(
            isEditing: _estudanteAtual != null,
            onSave: _guardar,
            onCancel: _limparFormulario,
          ),
        ],
      ),
      emptyText: 'Nenhum estudante cadastrado',
      list: ListView.builder(
        itemCount: _estudantes.length,
        itemBuilder: (context, index) {
          final estudante = _estudantes[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(estudante.nome),
            subtitle: Text('Matricula: ${estudante.matricula}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editar(estudante),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _eliminar(estudante),
                ),
              ],
            ),
          );
        },
      ),
      isEmpty: _estudantes.isEmpty,
    );
  }
}

class DisciplinasPage extends StatefulWidget {
  const DisciplinasPage({super.key});

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  final _nomeController = TextEditingController();
  final _professorController = TextEditingController();
  final _dao = DisciplinaDao();

  List<Disciplina> _disciplinas = [];
  Disciplina? _disciplinaAtual;

  @override
  void initState() {
    super.initState();
    _carregarDisciplinas();
  }

  Future<void> _carregarDisciplinas() async {
    final disciplinas = await _dao.getDisciplinas();
    setState(() => _disciplinas = disciplinas);
  }

  Future<void> _guardar() async {
    final nome = _nomeController.text.trim();
    final professor = _professorController.text.trim();
    if (nome.isEmpty || professor.isEmpty) return;

    if (_disciplinaAtual == null) {
      await _dao.addDisciplina(Disciplina(nome: nome, professor: professor));
    } else {
      _disciplinaAtual!
        ..nome = nome
        ..professor = professor;
      await _dao.updateDisciplina(_disciplinaAtual!);
    }

    _limparFormulario();
    await _carregarDisciplinas();
  }

  void _editar(Disciplina disciplina) {
    setState(() {
      _disciplinaAtual = disciplina;
      _nomeController.text = disciplina.nome;
      _professorController.text = disciplina.professor;
    });
  }

  Future<void> _eliminar(Disciplina disciplina) async {
    await _dao.deleteDisciplina(disciplina);
    if (_disciplinaAtual?.id == disciplina.id) {
      _limparFormulario();
    }
    await _carregarDisciplinas();
  }

  void _limparFormulario() {
    setState(() {
      _disciplinaAtual = null;
      _nomeController.clear();
      _professorController.clear();
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _professorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CrudPageLayout(
      form: Column(
        children: [
          TextField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _professorController,
            decoration: const InputDecoration(
              labelText: 'Professor',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FormButtons(
            isEditing: _disciplinaAtual != null,
            onSave: _guardar,
            onCancel: _limparFormulario,
          ),
        ],
      ),
      emptyText: 'Nenhuma disciplina cadastrada',
      list: ListView.builder(
        itemCount: _disciplinas.length,
        itemBuilder: (context, index) {
          final disciplina = _disciplinas[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.menu_book)),
            title: Text(disciplina.nome),
            subtitle: Text('Professor: ${disciplina.professor}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editar(disciplina),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _eliminar(disciplina),
                ),
              ],
            ),
          );
        },
      ),
      isEmpty: _disciplinas.isEmpty,
    );
  }
}

class CursandoPage extends StatefulWidget {
  const CursandoPage({super.key});

  @override
  State<CursandoPage> createState() => _CursandoPageState();
}

class _CursandoPageState extends State<CursandoPage> {
  final _estudanteDao = EstudanteDao();
  final _disciplinaDao = DisciplinaDao();
  final _cursandoDao = CursandoDao();

  List<Estudante> _estudantes = [];
  List<Disciplina> _disciplinas = [];
  List<CursandoJoin> _cursando = [];
  Cursando? _cursandoAtual;
  int? _estudanteIdSelecionado;
  int? _disciplinaIdSelecionada;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final estudantes = await _estudanteDao.getEstudantes();
    final disciplinas = await _disciplinaDao.getDisciplinas();
    final cursando = await _cursandoDao.getCursandoComJoin();
    setState(() {
      _estudantes = estudantes;
      _disciplinas = disciplinas;
      _cursando = cursando;
      _estudanteIdSelecionado = _idValido(_estudanteIdSelecionado, estudantes);
      _disciplinaIdSelecionada = _idValido(
        _disciplinaIdSelecionada,
        disciplinas,
      );
    });
  }

  int? _idValido<T>(int? id, List<T> itens) {
    if (id == null) return null;
    final existe = itens.any((item) {
      if (item is Estudante) return item.id == id;
      if (item is Disciplina) return item.id == id;
      return false;
    });
    return existe ? id : null;
  }

  Future<void> _guardar() async {
    if (_estudanteIdSelecionado == null || _disciplinaIdSelecionada == null) {
      _mostrarMensagem('Cadastre e selecione estudante e disciplina.');
      return;
    }

    final cursando = Cursando(
      id: _cursandoAtual?.id,
      estudanteId: _estudanteIdSelecionado!,
      disciplinaId: _disciplinaIdSelecionada!,
    );

    try {
      if (_cursandoAtual == null) {
        await _cursandoDao.addCursando(cursando);
      } else {
        await _cursandoDao.updateCursando(cursando);
      }
      _limparFormulario();
      await _carregarDados();
    } on DatabaseException {
      _mostrarMensagem('Este estudante ja esta cursando esta disciplina.');
    }
  }

  void _editar(CursandoJoin cursando) {
    setState(() {
      _cursandoAtual = Cursando(
        id: cursando.id,
        estudanteId: cursando.estudanteId,
        disciplinaId: cursando.disciplinaId,
      );
      _estudanteIdSelecionado = cursando.estudanteId;
      _disciplinaIdSelecionada = cursando.disciplinaId;
    });
  }

  Future<void> _eliminar(CursandoJoin cursando) async {
    await _cursandoDao.deleteCursando(
      Cursando(
        id: cursando.id,
        estudanteId: cursando.estudanteId,
        disciplinaId: cursando.disciplinaId,
      ),
    );
    if (_cursandoAtual?.id == cursando.id) {
      _limparFormulario();
    }
    await _carregarDados();
  }

  void _limparFormulario() {
    setState(() {
      _cursandoAtual = null;
      _estudanteIdSelecionado = null;
      _disciplinaIdSelecionada = null;
    });
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CrudPageLayout(
      form: Column(
        children: [
          DropdownButtonFormField<int>(
            value: _estudanteIdSelecionado,
            decoration: const InputDecoration(
              labelText: 'Estudante',
              border: OutlineInputBorder(),
            ),
            items: _estudantes
                .map(
                  (estudante) => DropdownMenuItem(
                    value: estudante.id,
                    child: Text('${estudante.nome} (${estudante.matricula})'),
                  ),
                )
                .toList(),
            onChanged: (id) => setState(() => _estudanteIdSelecionado = id),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            value: _disciplinaIdSelecionada,
            decoration: const InputDecoration(
              labelText: 'Disciplina',
              border: OutlineInputBorder(),
            ),
            items: _disciplinas
                .map(
                  (disciplina) => DropdownMenuItem(
                    value: disciplina.id,
                    child: Text('${disciplina.nome} - ${disciplina.professor}'),
                  ),
                )
                .toList(),
            onChanged: (id) => setState(() => _disciplinaIdSelecionada = id),
          ),
          const SizedBox(height: 12),
          FormButtons(
            isEditing: _cursandoAtual != null,
            onSave: _guardar,
            onCancel: _limparFormulario,
          ),
        ],
      ),
      emptyText: 'Nenhum relacionamento cadastrado',
      list: ListView.builder(
        itemCount: _cursando.length,
        itemBuilder: (context, index) {
          final item = _cursando[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.school)),
            title: Text('${item.estudanteNome} cursa ${item.disciplinaNome}'),
            subtitle: Text(
              'Matricula: ${item.estudanteMatricula} | Professor: ${item.professor}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editar(item),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _eliminar(item),
                ),
              ],
            ),
          );
        },
      ),
      isEmpty: _cursando.isEmpty,
    );
  }
}

class CrudPageLayout extends StatelessWidget {
  final Widget form;
  final Widget list;
  final bool isEmpty;
  final String emptyText;

  const CrudPageLayout({
    super.key,
    required this.form,
    required this.list,
    required this.isEmpty,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          form,
          const SizedBox(height: 16),
          const Divider(),
          Expanded(
            child: isEmpty ? Center(child: Text(emptyText)) : list,
          ),
        ],
      ),
    );
  }
}

class FormButtons extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const FormButtons({
    super.key,
    required this.isEditing,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSave,
            icon: Icon(isEditing ? Icons.check : Icons.save),
            label: Text(isEditing ? 'Atualizar' : 'Salvar'),
          ),
        ),
        if (isEditing) ...[
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: onCancel,
            icon: const Icon(Icons.close),
            label: const Text('Cancelar'),
          ),
        ],
      ],
    );
  }
}
