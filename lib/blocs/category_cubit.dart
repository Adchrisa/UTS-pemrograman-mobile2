import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<String?> {
  CategoryCubit() : super(null);

  void selectCategory(String category) => emit(category);

  void clear() => emit(null);
}
