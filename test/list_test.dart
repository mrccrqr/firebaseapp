import 'package:flutter_test/flutter_test.dart';

List<int> numeros = [1, 2, 3];

void main() {
  test('adicionar um elemento', () {
    numeros.add(4);
    expect(numeros.contains(4), true);
  });

  test('adicionar outra lista', () {
    numeros.addAll([5, 6]);
    expect(numeros.contains(5), true);
    expect(numeros.contains(6), true);
  });

  test('inserir em uma posicao', () {
    numeros.insert(0, 0);
    expect(numeros.indexOf(0), 0);
  });

  test('remover por valor', () {
    numeros.remove(2);
    expect(numeros.contains(2), false);
  });

  test('remover por posicao', () {
    numeros.removeAt(0);
    expect(numeros.contains(0), false);
  });

  test('testar tamanho', () {
    expect(numeros.length, 5);
  });

  test('lista nao esta vazia', () {
    expect(numeros.isEmpty, false);
    expect(numeros.isNotEmpty, true);
  });

  test('inverter a lista', () {
    numeros = numeros.reversed.toList();
    expect(numeros.first, 6);
  });

  test('ordenar a lista', () {
    numeros.sort();
    expect(numeros.first, 1);
  });

  test('percorrer com for-in e somar', () {
    int soma = 0;
    for (int numero in numeros) {
      soma += numero;
    }
    expect(soma, 19);
  });

  test('map: multiplicar cada numero por 2', () {
    numeros = numeros.map((numero) => numero * 2).toList();
    expect(numeros.contains(12), true);
  });

  test('where: filtrar divisiveis por 3', () {
    var divisiveis = numeros.where((numero) => numero % 3 == 0).toList();
    expect(divisiveis, [6, 12]);
  });
}