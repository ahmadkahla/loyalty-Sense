import 'package:flutter_bloc/flutter_bloc.dart';

import '../HomeDataRepo.dart';
import 'sliders_state.dart';

class SlidersCubit extends Cubit<SlidersState> {
  final HomeDataRepo _repo;

  SlidersCubit({HomeDataRepo? repo})
    : _repo = repo ?? HomeDataRepo(),
      super(const SlidersState()) {
    _loadSliders();
  }

  Future<void> refresh() async {
    emit(const SlidersState());
    await _loadSliders();
  }

  Future<void> _loadSliders() async {
    final result = await _repo.fetchSliders();
    if (!isClosed) {
      emit(state.copyWith(sliders: result));
    }
  }
}
