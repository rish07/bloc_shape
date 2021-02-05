import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shape_state_manage/bloc/shape_bloc.dart';
import 'package:shape_state_manage/bloc/shape_events.dart';

import 'bloc/shape_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List initialShapeList = [
    'https://www.kidsmathgamesonline.com/images/pictures/shapes/square.jpg',
    "https://dp57v9mrmcue2.cloudfront.net/wp-content/uploads/2019/08/IMG_6679-492x512.jpeg",
    "https://www.kidsmathgamesonline.com/images/pictures/shapes/triangle.jpg",
  ];
  Widget showShapes(List shapeList) {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Image.network(
            shapeList[index],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ShapeBloc>(context).add(
              ShapeChangeRequested(quantity: 2, imageList: initialShapeList));
        },
      ),
      body: Center(child: BlocBuilder<ShapeBloc, ShapeState>(
        builder: (context, state) {
          if (state is ShapeInitialState) {
            return showShapes(initialShapeList);
          }
          if (state is ShapeLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ShapeLoadedState) {
            final List newList = state.imageList;

            initialShapeList = state.imageList;

            return showShapes(newList);
          }
          if (state is ShapeLoadFailure) {
            return Text('Something went Wrong!');
          } else {
            return Container();
          }
        },
      )),
    );
  }
}
