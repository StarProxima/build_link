import 'package:flutter/material.dart';

class FiltersInherit extends InheritedWidget {
  final FiltersModel? filterValues;
  const FiltersInherit({Key? key, required super.child, required this.filterValues}) : super(key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static FiltersInherit? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FiltersInherit>();
  }
}

class FiltersModel extends ChangeNotifier {
  Range? square;
  Range? rooms;
  Range? cost;
  Range? height;

  void initValue({Range? square, Range? rooms, Range? height, Range? cost}) {
    this.square = square ?? this.square;
    this.rooms = rooms ?? this.rooms;
    this.cost = cost ?? this.cost;
    this.height = height ?? this.height;

    notifyListeners();
  }
}

class Range {
  double from;
  double to;
  Range(this.from, this.to);
}
