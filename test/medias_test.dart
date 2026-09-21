import 'package:flutter_test/flutter_test.dart';

Map<String, List<double>> alunos = {
  'Maria': [8, 9],
  'Bruna': [7, 7],
  'Carla': [10, 9],
};

void main() {
  test('calcular medias das notas dos alunos', () {
    Map<String, double> medias = {};

    alunos.forEach((nome, notas) {
      double soma = 0;
      for (double nota in notas) {
        soma += nota;
      }
      medias[nome] = soma / notas.length;
    });

    print(medias); // {Maria: 8.5, Bruna: 7.0, Carla: 9.5}

    expect(medias['Maria'], 8.5);
  });
}