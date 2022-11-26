import 'dart:convert';

import 'package:flutter/material.dart';

class Filter {
  final Color color;
  final String label;
  bool isSelected;

  Filter({
    required this.color,
    required this.label,
    required this.isSelected,
  });

  Filter copyWith({
    Color? color,
    String? label,
    bool? isSelected,
  }) {
    return Filter(
      color: color ?? this.color,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
      'label': label,
      'isSelected': isSelected,
    };
  }

  factory Filter.fromMap(Map<String, dynamic> map) {
    return Filter(
      color: Color(map['color']),
      label: map['label'] ?? '',
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Filter.fromJson(String source) => Filter.fromMap(json.decode(source));

  @override
  String toString() =>
      'Filter(color: $color, label: $label, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Filter &&
        other.color == color &&
        other.label == label &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => color.hashCode ^ label.hashCode ^ isSelected.hashCode;
}
