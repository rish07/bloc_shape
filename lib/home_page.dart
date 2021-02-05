import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shape_state_manage/bloc/shape_bloc.dart';

import 'bloc/shape_events.dart';
import 'bloc/shape_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List options = [1, 2, 3];
  List order = ["tri", "cir", "sq"];
  List initialShapeList = [
    "https://www.kidsmathgamesonline.com/images/pictures/shapes/triangle.jpg",
    "https://dp57v9mrmcue2.cloudfront.net/wp-content/uploads/2019/08/IMG_6679-492x512.jpeg",
    'https://www.kidsmathgamesonline.com/images/pictures/shapes/square.jpg',
  ];

  Widget showShapes(List shapeList, List options, List order) {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Enter a value"),
                      content: DropdownButtonFormField(
                        hint: Text(
                          'Select Value',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                        ),
                        items: options.map((location) {
                          return DropdownMenuItem(
                            child: Text(
                              location.toString(),
                              maxLines: 1,
                              style: TextStyle(color: Colors.black),
                            ),
                            value: location,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            order.removeAt(value - 1);
                            order.insert(
                                value - 1,
                                index == 0
                                    ? 'tri'
                                    : (index == 1)
                                        ? 'cir'
                                        : 'sq');

                            print(order);
                          });

                          Navigator.pop(context);
                        },
                      ),
                    );
                  });
            },
            child: Container(
              child: Image.network(
                shapeList[index],
                height: 200,
                width: 200,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print(order);

            BlocProvider.of<ShapeBloc>(context)
                .add(ShapeChangeRequested(newOrder: order));
          },
          label: Text('Submit')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(child: BlocBuilder<ShapeBloc, ShapeState>(
        builder: (context, state) {
          if (state is ShapeInitialState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child:
                                  showShapes(initialShapeList, options, order),
                              height: MediaQuery.of(context).size.height * 0.8,
                            )
                          ]),
                    );
                  }),
            );
          }
          if (state is ShapeLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ShapeLoadedState) {
            final List newList = state.imageList;

            initialShapeList = state.imageList;

            return showShapes(newList, options, order);
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
