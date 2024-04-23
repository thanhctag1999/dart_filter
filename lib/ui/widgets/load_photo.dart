import 'package:dart_filter/helpers/my_images_pickers.dart';
import 'package:dart_filter/ui/widgets/custom_button.dart';
import 'package:dart_filter/ui/widgets/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_state.dart';

class LoadPhoto extends StatelessWidget {
  const LoadPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    AppStateProvider imageStateRef = Provider.of<AppStateProvider>(context);

    return Center(
      child: CustomButtom(
          myColors: const [Color(0xFFFA7DC2), Color(0XFFEB42D0)],
          doSomething: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              builder: (context) {
                return CustomModal(
                  children: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: IconButton(
                                  onPressed: () async {
                                    String? photoCopy =
                                        await MyImagePicker.takePhoto(context);
                                    (photoCopy != null)
                                        ? imageStateRef.chargeImage(photoCopy)
                                        : imageStateRef.secondChange();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 70,
                                  )),
                            ),
                            const Text(
                              "Camera",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: IconButton(
                                  onPressed: () async {
                                    String? photoCopy =
                                        await MyImagePicker.pickGallery();
                                    (photoCopy != null)
                                        ? imageStateRef.chargeImage(photoCopy)
                                        : imageStateRef.secondChange();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.photo_album_rounded,
                                    color: Colors.white,
                                    size: 70,
                                  )),
                            ),
                            const Text(
                              "Galary",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            )
                          ],
                        )
                      ]),
                );
              },
            );
          },
          children: const Text(
            "Select Image",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "CustomFont",
                letterSpacing: 2),
          )),
    );
  }
}
