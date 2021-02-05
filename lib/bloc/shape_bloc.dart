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
      List<Object> rotate(List<Object> list, int v) {
        if (list == null || list.isEmpty) return list;
        var i = v % list.length;
        return list.sublist(i)..addAll(list.sublist(0, i));
      }

      try {
        print('this');
        List imageList = rotate(event.imageList, event.quantity);
        print(imageList);
        yield ShapeLoadedState(imageList: imageList);
      } catch (_) {
        yield ShapeLoadFailure();
      }
    }
  }
}
