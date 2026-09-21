import 'package:flutter_test/flutter_test.dart';

Map<String, List<double>> alunos = {
  'Maria': [8, 9],
  'Bruna': [7, 7],
  'Carla': [10, 9],
};

void main() {
  test('adicionar elemento se nao existir', () {
    alunos.putIfAbsent('Helena', () => [9, 8]);
    expect(alunos.containsKey('Helena'), true);
  });

  test('acessar valor pela chave', () {
    expect(alunos['Helena'], [9, 8]);
  });

  test('adicionar varios (addAll)', () {
    alunos.addAll({'Luisa': [10, 10]});
    expect(alunos.containsKey('Luisa'), true);
  });

  test('remover uma chave', () {
    alunos.remove('Bruna');
    expect(alunos.containsKey('Bruna'), false);
  });

  test('atualizar um valor', () {
    alunos['Maria'] = [10, 10];
    expect(alunos['Maria'], [10, 10]);
  });

  test('chaves e valores', () {
    expect(alunos.keys.isNotEmpty, true);
    expect(alunos.values.isNotEmpty, true);
  });

  test('percorrer o Map somando todas as notas', () {
    double soma = 0;
    alunos.forEach((nome, notas) {
      for (double nota in notas) {
        soma += nota;
      }
    });
    expect(soma > 0, true);
  });
}