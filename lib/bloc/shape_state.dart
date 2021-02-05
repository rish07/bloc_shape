import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ShapeState extends Equatable {
  const ShapeState();
  @override
  List<Object> get props => [];
}

class ShapeInitialState extends ShapeState {}

class ShapeLoadingState extends ShapeState {}

class ShapeLoadedState extends ShapeState {
  final List imageList;

  ShapeLoadedState({@required this.imageList}) : assert(imageList != null);

  @override
  List<Object> get props => [imageList];
}

class ShapeLoadFailure extends ShapeState {}
