import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tawsela_app/app_logger.dart';

part 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  AvatarCubit() : super(AvatarInitial());

  final ImagePicker _imagePicker = ImagePicker();
  Future<void> imagePick(ImageSource source) async {
    try {
      final pickedImage=await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        emit(AvatarChangedState(imgPath: pickedImage.path));
      }
    } catch(e){
          AppLogger.log(e.toString());
    }
  }
}