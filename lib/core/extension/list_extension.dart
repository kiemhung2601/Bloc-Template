import 'package:flutter/widgets.dart';

extension ListExtension<T> on List<T> {
  void addOrRemove(T data) {
    contains(data) ? remove(data) : add(data);
  }

  void addIfNotContains(T data) {
    if (!contains(data)) {
      add(data);
    }
  }

  void addAllIfNotContains(Iterable<T> data) {
    for (final T x in data) {
      if (!contains(x)) {
        add(x);
      }
    }
  }

  void removeAllIfContains(Iterable<T> data) {
    for (final T x in data) {
      if (contains(x)) {
        remove(x);
      }
    }
  }

  /// Maps each element and its index to a new value.
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
    for (var index = 0; index < length; index++) {
      yield convert(index, this[index]);
    }
  }

  List<T> appendOrExceptElement(T item) {
    return contains(item) ? exceptElement(item).toList(growable: false) : appendElement(item).toList(growable: false);
  }

  List<T> plus(T element) {
    return appendElement(element).toList(growable: false);
  }

  List<T> minus(T element) {
    return exceptElement(element).toList(growable: false);
  }

  List<T> plusAll(List<T> elements) {
    return append(elements).toList(growable: false);
  }

  List<T> minusAll(List<T> elements) {
    return except(elements).toList(growable: false);
  }
}

extension ListDividerExtension on List<Widget> {
  List<Widget> applySeparator(Widget separator) {
    return mapIndexed((int index, Widget item) => <Widget>[
          if (index != 0) separator,
          item,
        ]).expand((List<Widget> element) => element).toList();
  }
}

extension IterableExt<T> on Iterable<T> {
  /// Returns a new lazy [Iterable] containing the given [element] and then all
  /// elements of this collection.
  Iterable<T> appendElement(T element) sync* {
    yield* this;
    yield element;
  }

  /// Returns a new lazy [Iterable] containing all elements of the given
  /// [elements] collection and then all elements of this collection.
  Iterable<T> append(Iterable<T> elements) sync* {
    yield* this;
    yield* elements;
  }

  /// Returns a new lazy [Iterable] containing all elements of this collection
  /// except the given [element].
  Iterable<T> exceptElement(T element) sync* {
    for (final current in this) {
      if (element != current) yield current;
    }
  }

  /// Returns a new lazy [Iterable] containing all elements of this collection
  /// except the elements contained in the given [elements] collection.
  Iterable<T> except(Iterable<T> elements) sync* {
    for (final current in this) {
      if (!elements.contains(current)) yield current;
    }
  }
}
