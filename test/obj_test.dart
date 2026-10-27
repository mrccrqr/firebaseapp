import 'package:flutter_test/flutter_test.dart';

abstract class Pessoa {
  late int _id;
  String nome;
  Pessoa(this.nome);
  int get id => _id;
  set id(int id) {
    if (id > 0) {
      _id = id;
    } else {
      throw ArgumentError('Identificador deve ser não negativo.');
    }
  }
}

mixin Ano {
  late int _ano;
  int get ano => _ano;
  set ano(int ano) {
    if (ano > 0) {
      _ano = ano;
    } else {
      throw ArgumentError('Ano deve ser não negativo.');
    }
  }
}

class Aluno extends Pessoa with Ano {
  Aluno(super.nome, int ano) {
    this.ano = ano;
  }
}

class Disciplina {
  String nome;
  Disciplina(this.nome);
}

// ===== Exercício parte 1: classe Professor =====
class Professor extends Pessoa {
  Professor(super.nome);
}

class Turma with Ano {
  Disciplina disciplina;
  Professor professor; // <-- atributo novo (exercício)
  final List<Aluno> _alunos = [];
  Turma(this.disciplina, this.professor, int ano) {
    this.ano = ano;
  }
  void matricular(Aluno aluno) {
    if (aluno.ano == ano) {
      _alunos.add(aluno);
    } else {
      throw ArgumentError('Ano deve ser mesmo.');
    }
  }
}

class Historico extends Turma {
  Map<Aluno, List<double>> notas = {};
  Historico(super.disciplina, super.professor, super.ano);

  @override
  void matricular(Aluno aluno) {
    super.matricular(aluno);
    notas[aluno] = [];
  }

  double media(Aluno aluno) {
    final notasAluno = notas[aluno]!;
    if (notasAluno.isEmpty) return 0; // evita divisão por zero
    double soma = 0;
    for (double nota in notasAluno) {
      soma += nota;
    }
    return soma / notasAluno.length;
  }

  // Exercício parte 2: verificar aprovação ===
  bool isAprovado(Aluno aluno) {
    return media(aluno) > 6;
  }
}

void main() {
  test('Testar matrícula de alunos', () {
    Disciplina disciplina1 = Disciplina('Flutter');
    Professor professor1 = Professor('Edilson');
    professor1.id = 1;
    Historico historico1 = Historico(disciplina1, professor1, 2023);

    // Primeiro aluno sem erros
    Aluno aluno1 = Aluno('Maria', 2023);
    aluno1.id = 1;
    historico1.matricular(aluno1);
    expect(historico1.media(aluno1), 0.0);
    expect(historico1.isAprovado(aluno1), false); // média 0 -> reprovado

    // Segundo aluno com erros (id 0 e ano diferente)
    Aluno aluno2 = Aluno('Paula', 2022);
    try {
      aluno2.id = 0;
    } catch (error) {
      expect(error, isA<ArgumentError>());
    }
    try {
      historico1.matricular(aluno2);
    } catch (error) {
      expect(error, isA<ArgumentError>());
    }
  });

  // ===== Exercício parte 3: teste da aprovação =====
  test('Testar aprovação com notas', () {
    Disciplina disciplina = Disciplina('Dart');
    Professor professor = Professor('Edilson');
    professor.id = 2;
    Historico historico = Historico(disciplina, professor, 2023);

    Aluno aluno = Aluno('Joao', 2023);
    aluno.id = 3;
    historico.matricular(aluno);
    historico.notas[aluno]!.addAll([8, 9, 7]); // média 8 -> aprovado
    expect(historico.media(aluno), 8.0);
    expect(historico.isAprovado(aluno), true);
  });
}