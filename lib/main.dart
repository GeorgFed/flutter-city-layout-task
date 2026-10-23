import 'package:flutter/material.dart';
import 'data.dart';
import 'layout.dart';

// Оболочка и состояние готовы. Работайте в layout.dart.
void main() => runApp(const CityApp());

class CityApp extends StatefulWidget {
  const CityApp({super.key});
  @override
  State<CityApp> createState() => _CityAppState();
}

class _CityAppState extends State<CityApp> {
  String selectedId = cities.first.id;
  bool grid = false;
  bool largeText = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: const Color(0xff426e9b)),
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(largeText ? 1.3 : 1)),
      child: child!,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Города'),
        actions: [
          IconButton(
            key: const ValueKey('large-text'),
            tooltip: largeText ? 'Текст 1×' : 'Текст 1.3×',
            onPressed: () => setState(() => largeText = !largeText),
            icon: Icon(largeText ? Icons.text_decrease : Icons.text_increase),
          ),
        ],
      ),
      body: SafeArea(
        child: CityScreen(
          header: SelectedCity(
            key: const ValueKey('selected-city'),
            city: cities.firstWhere((city) => city.id == selectedId),
          ),
          controls: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  key: const ValueKey('mode-list'),
                  onPressed: () => setState(() => grid = false),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: !grid
                        ? const Color(0xff426e9b)
                        : Colors.white,
                    foregroundColor: !grid
                        ? Colors.white
                        : const Color(0xff426e9b),
                  ),
                  icon: Icon(!grid ? Icons.check : Icons.view_list, size: 18),
                  label: const Text('Список'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  key: const ValueKey('mode-grid'),
                  onPressed: () => setState(() => grid = true),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: grid
                        ? const Color(0xff426e9b)
                        : Colors.white,
                    foregroundColor: grid
                        ? Colors.white
                        : const Color(0xff426e9b),
                  ),
                  icon: Icon(grid ? Icons.check : Icons.grid_view, size: 18),
                  label: const Text('Сетка'),
                ),
              ),
            ],
          ),
          grid: grid,
          itemCount: cities.length,
          itemBuilder: (context, index) {
            final city = cities[index];
            final selected = city.id == selectedId;
            return CityAction(
              cityId: city.id,
              selected: selected,
              onTap: () => setState(() => selectedId = city.id),
              child: grid
                  ? CityGridContent(city: city)
                  : CityListContent(city: city),
            );
          },
        ),
      ),
    ),
  );
}

// Нажатие, видимая отметка выбора и внутренний отступ уже готовы.
class CityAction extends StatelessWidget {
  const CityAction({
    super.key,
    required this.cityId,
    required this.selected,
    required this.onTap,
    required this.child,
  });
  final String cityId;
  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    child: Material(
      color: selected ? const Color(0xffe9f0f7) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected ? const Color(0xff426e9b) : const Color(0xffdce3ec),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: ValueKey('city-$cityId'),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    ),
  );
}
