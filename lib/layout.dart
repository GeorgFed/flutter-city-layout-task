import 'package:flutter/material.dart';
import 'data.dart';

// Меняйте только четыре метода build с TODO ниже.
// Не меняйте конструкторы: main.dart уже передаёт данные и callbacks.
class CityScreen extends StatelessWidget {
  const CityScreen({
    super.key,
    required this.header,
    required this.controls,
    required this.grid,
    required this.itemCount,
    required this.itemBuilder,
  });
  final Widget header; // Готовый экземпляр SelectedCity.
  final Widget controls; // Готовые кнопки: достаточно вставить их в дерево.
  final bool grid;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder; // Создаёт нажимаемый элемент.

  @override
  Widget build(BuildContext context) {
    // TODO 1: header, controls, затем список ИЛИ сетка.
    // Передайте itemCount и itemBuilder в ListView/GridView.builder.
    // Верхняя часть остаётся видна, область городов прокручивается.
    return const Center(child: Text('Начните с TODO 1 в layout.dart'));
  }
}

class SelectedCity extends StatelessWidget {
  const SelectedCity({super.key, required this.city});
  final City city;

  @override
  Widget build(BuildContext context) {
    // TODO 2: подпись «Выбран город», полное city.name и температура.
    // Длинное название должно переноситься, а не обрезаться.
    return const SizedBox();
  }
}

class CityListContent extends StatelessWidget {
  const CityListContent({super.key, required this.city});
  final City city;

  @override
  Widget build(BuildContext context) {
    // TODO 3: city.icon, название/описание и температура справа.
    // CityAction уже добавляет рамку, фон, нажатие и padding 12.
    return const SizedBox(height: 72);
  }
}

class CityGridContent extends StatelessWidget {
  const CityGridContent({super.key, required this.city});
  final City city;

  @override
  Widget build(BuildContext context) {
    // TODO 4: иконка, название до двух строк, температура.
    // Описание здесь не нужно. Помните о тестовом тексте 1.3×.
    return const SizedBox();
  }
}
