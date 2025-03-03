import 'package:flutter/material.dart';
import 'package:tawsela_app/models/timers/trip_request_timer.dart';
import 'package:tawsela_app/view/screens/driver_map_page/driver_buttom_sheet.dart';
import 'package:tawsela_app/view/widgets/handle.dart';

class DriverDraggableSheet extends StatelessWidget {
  TripRequestTimer timer;
  DriverDraggableSheet({required this.timer, super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.25,
        minChildSize: 0.07,
        maxChildSize: 1,
        snapSizes: const [0.25, 0.5, 0.75, 1],
        snap: true,
        builder: (context, scrollableController) {
          return Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              controller: scrollableController,
              children: [
                const Column(
                  children: [BottomSheetHandle()],
                ),
                const SizedBox(
                  height: 10,
                ),
                DriverButtomSheet(timer: timer),
              ],
            ),
          );
        });
  }
}