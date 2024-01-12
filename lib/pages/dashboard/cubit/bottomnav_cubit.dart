import 'package:bloc/bloc.dart';

class HomePageCubit extends Cubit<int> {
  HomePageCubit() : super(0);

  void onPageChange(index) => emit(index);
}
