import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ShapeEvent extends Equatable {
  const ShapeEvent();
}

class ShapeChangeRequested extends ShapeEvent {
  final List newOrder;
  ShapeChangeRequested({@required this.newOrder}) : assert(newOrder != null);

  @override
  List<Object> get props => [newOrder];
}
