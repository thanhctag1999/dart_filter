import 'package:dart_filter/helpers/my_images_pickers.dart';
import 'package:dart_filter/provider/app_state.dart';
import 'package:dart_filter/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OthersButtons extends StatelessWidget {
  final GlobalKey myGlobalKey;

  const OthersButtons({
    Key? key,
    required this.myGlobalKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStateProvider currentStateImage = Provider.of<AppStateProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                currentStateImage.secondChange();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
                size: 25,
              )),
          IconButton(
              onPressed: () async {
                bool? status = await MyImagePicker.capturePng(myGlobalKey);
                if (status != null) {
                  const snackBar = SnackBar(
                    backgroundColor: Color.fromARGB(255, 13, 184, 101),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Download successfull',
                      style: TextStyle(color: Colors.white),
                    ),
                    // action: SnackBarAction(
                    //   label: 'Undo',
                    //   onPressed: () {
                    //     currentStateImage.secondChange();
                    //   },
                    // ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              icon: const Icon(
                Icons.save_alt_rounded,
                size: 25,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
