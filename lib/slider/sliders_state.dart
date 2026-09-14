import '../app_all/ApiResul.dart';
import 'app_slide_model.dart';

class SlidersState {
  final ApiResult<List<AppSlide>>? sliders;

  const SlidersState({this.sliders});

  SlidersState copyWith({final ApiResult<List<AppSlide>>? sliders}) {
    return SlidersState(sliders: sliders ?? this.sliders);
  }
}
