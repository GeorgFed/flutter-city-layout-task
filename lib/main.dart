import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: CitiesPage()),
);

class City {
  const City(this.name, this.degrees);
  final String name;
  final int degrees;
}

// Уже готово: без сети, всегда успешно, результат через 500 мс.
Future<List<City>> loadCities() async {
  await Future<void>.delayed(const Duration(milliseconds: 500));
  return const [
    City('Москва', 18),
    City('Париж', 21),
    City('Лондон', 14),
    City('Санкт-Петербург', 12),
    City('Токио', 24),
    City('Петропавловск-Камчатский', 7),
  ];
}

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});
  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  // TODO 1: состояние режима и Future; первая загрузка и «Обновить».
  // Future создаётся у владельца State, а не внутри build.
  @override
  Widget build(BuildContext context) {
    // TODO 2: кнопки «Список», «Сетка», «Обновить» и FutureBuilder.
    // Пока waiting — CircularProgressIndicator; после — список/сетка.
    return const Scaffold(body: Center(child: Text('Начните с TODO 1')));
  }
}

class CityListCard extends StatelessWidget {
  const CityListCard({super.key, required this.city});
  final City city;
  @override
  Widget build(BuildContext context) {
    // TODO 3: простая Card, название слева, температура справа.
    return const SizedBox();
  }
}

class CityGridCard extends StatelessWidget {
  const CityGridCard({super.key, required this.city});
  final City city;
  @override
  Widget build(BuildContext context) {
    // TODO 4: простая Card, название сверху, температура снизу.
    return const SizedBox();
  }
}
