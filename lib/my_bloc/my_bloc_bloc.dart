import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_repository/model/model.dart';
import 'package:my_repository/repository/repository.dart';

part 'my_bloc_event.dart';
part 'my_bloc_state.dart';

class MyBlocBloc extends Bloc<MyBlocEvent, MyBlocState> {
  MyRepo myRepo;
  MyBlocBloc(this.myRepo) : super(MyBlocInitial()) {
    on<LoadEvent>(myAction);
  }

  myAction(event, emit) async {
    emit(LoadingState());
    try {
      var products = await myRepo.getData();
      emit(SuccessState(products));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
