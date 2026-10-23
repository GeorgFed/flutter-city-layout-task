import 'package:flutter/material.dart';

// Готовые данные: их не нужно загружать или изменять.
class City {
  const City(this.id, this.name, this.degrees, this.description, this.icon);
  final String id;
  final String name;
  final int degrees;
  final String description;
  final IconData icon;
}

const cities = [
  City('moscow', 'Москва', 18, 'Облачно', Icons.cloud_outlined),
  City('paris', 'Париж', 21, 'Ясно', Icons.wb_sunny_outlined),
  City('london', 'Лондон', 14, 'Небольшой дождь', Icons.grain),
  City(
    'spb',
    'Санкт-Петербург',
    12,
    'Ветер и переменная облачность',
    Icons.air,
  ),
  City('tokyo', 'Токио', 24, 'Ясно', Icons.wb_sunny_outlined),
  City(
    'kamchatka',
    'Петропавловск-Камчатский',
    7,
    'Пасмурно, временами небольшой дождь и сильные порывы ветра',
    Icons.cloud_outlined,
  ),
];
