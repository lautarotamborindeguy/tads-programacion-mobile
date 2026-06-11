# CRUD Estudante, Disciplina e Cursando

Aplicativo Flutter basico com SQLite (`sqflite`) para realizar CRUD nas tabelas:

- `estudantes`: id, nome, matricula
- `disciplinas`: id, nome, professor
- `cursando`: id, estudante_id, disciplina_id

A aba `Cursando` usa `INNER JOIN` para exibir o nome do estudante, a matricula, o nome da disciplina e o professor.

Estrutura principal:

- `lib/database_helper.dart`: cria o banco e as tabelas.
- `lib/models`: modelos das tabelas.
- `lib/dao`: operacoes de insert, select, update, delete e join.
- `lib/main.dart`: telas com abas para Estudantes, Disciplinas e Cursando.

Para executar:

```bash
flutter pub get
flutter run
```
