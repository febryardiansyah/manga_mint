import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';

Color mangaTypeColor(type) {
  switch (type) {
    case 'Manga':
      return BaseColor.red;
    case 'Manhua':
      return BaseColor.green;
    case 'Manhwa':
      return BaseColor.orange;
    default:
      return BaseColor.grey1;
  }
}