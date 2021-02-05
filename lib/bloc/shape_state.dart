import 'dart:io';

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
  final File image;

  ShapeLoadedState({@required this.image}) : assert(image != null);

  @override
  List<Object> get props => [image];
}

class ShapeLoadFailure extends ShapeState {}
