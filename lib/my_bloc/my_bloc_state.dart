part of 'my_bloc_bloc.dart';

@immutable
sealed class MyBlocState {}

final class MyBlocInitial extends MyBlocState {}

final class LoadingState extends MyBlocState {}

final class SuccessState extends MyBlocState {
  final List<ProductModel> productList;
  SuccessState(this.productList);
}

final class ErrorState extends MyBlocState {
  final String errorMessage;
  ErrorState(this.errorMessage);
}
