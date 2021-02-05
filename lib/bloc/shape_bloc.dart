import 'package:bloc/bloc.dart';
import 'package:shape_state_manage/bloc/shape_events.dart';
import 'package:shape_state_manage/bloc/shape_state.dart';

class ShapeBloc extends Bloc<ShapeEvent, ShapeState> {
  ShapeBloc() : super(ShapeInitialState());

  @override
  Stream<ShapeState> mapEventToState(ShapeEvent event) async* {
    if (event is ShapeChangeRequested) {
      yield ShapeLoadingState();
      //TODO change list

      try {
        print('this');
        List imageList = [];
        event.newOrder.forEach((element) {
          if (element == 'tri') {
            imageList.add(
              "https://www.kidsmathgamesonline.com/images/pictures/shapes/triangle.jpg",
            );
          } else if (element == "cir") {
            imageList.add(
              "https://dp57v9mrmcue2.cloudfront.net/wp-content/uploads/2019/08/IMG_6679-492x512.jpeg",
            );
          } else if (element == 'sq') {
            imageList.add(
                'https://www.kidsmathgamesonline.com/images/pictures/shapes/square.jpg');
          }
        });
        print(imageList);
        yield ShapeLoadedState(imageList: imageList);
      } catch (_) {
        yield ShapeLoadFailure();
      }
    }
  }
}
