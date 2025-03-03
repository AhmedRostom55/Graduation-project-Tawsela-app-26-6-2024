import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/bloc_models/imageCubit/image_cubit.dart';

class TestpicsPage extends StatelessWidget {
  static String id = 'testPicsPage';

  const TestpicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageState = context.watch<ImageCubit>().state;

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              height: 200,
              child: Image(image: imageState.avatarImg.image),
            ),
            CircleAvatar(
              backgroundImage: imageState.avatarImg.image,
              radius: 70,
            ),
            const SizedBox(height: 16),
            CircleAvatar(
              backgroundImage: imageState.idImg.image,
              radius: 70,
            ),
            const SizedBox(height: 16),
            CircleAvatar(
              backgroundImage: imageState.licenseImg.image,
              radius: 70,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}