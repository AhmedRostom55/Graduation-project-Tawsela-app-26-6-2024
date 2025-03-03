import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit()
      : super(ImageState(
          avatarImg: Image.asset('assets/images/avatar.png'),
          licenseImg: Image.asset('assets/images/avatar.png'),
          idImg: Image.asset('assets/images/avatar.png'),
        ));

  void setAvatarImg(Image image) {
    emit(state.copyWith(avatarImg: image));
  }

  void setLicenseImg(Image image) {
    emit(state.copyWith(licenseImg: image));
  }

  void setIdImg(Image image) {
    emit(state.copyWith(idImg: image));
  }
}

class ImageState {
  final Image avatarImg;
  final Image licenseImg;
  final Image idImg;

  ImageState({
    required this.avatarImg,
    required this.licenseImg,
    required this.idImg,
  });

  ImageState copyWith({
    Image? avatarImg,
    Image? licenseImg,
    Image? idImg,
  }) {
    return ImageState(
      avatarImg: avatarImg ?? this.avatarImg,
      licenseImg: licenseImg ?? this.licenseImg,
      idImg: idImg ?? this.idImg,
    );
  }
}