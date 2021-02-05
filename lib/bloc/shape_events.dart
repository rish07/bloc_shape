import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ShapeEvent extends Equatable {
  const ShapeEvent();
}

class ShapeChangeRequested extends ShapeEvent {
  final int quantity;
  final List imageList;
  ShapeChangeRequested({@required this.quantity, this.imageList})
      : assert(quantity != null);

  @override
  List<Object> get props => [quantity, imageList];
}
