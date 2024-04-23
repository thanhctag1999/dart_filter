import 'dart:io';

import "package:dart_filter/provider/app_state.dart";
import 'package:dart_filter/ui/widgets/load_photo.dart';
import "package:dart_filter/ui/widgets/other_buttons.dart";
import "package:dart_filter/ui/widgets/photo_with_filters.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../helpers/filters.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AppStateProvider currentStateImage = Provider.of<AppStateProvider>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: currentStateImage.myImageFilter.changePosition
                ? const AssetImage("assets/background2.jpg")
                : const AssetImage(
                    "assets/background.jpg"), // Change the path to your image file
            fit: BoxFit.cover, // Adjust the image fit as needed
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (currentStateImage.myImageFilter.changePosition)
            OthersButtons(
              myGlobalKey: globalKey,
            ),
          const SizedBox(
            height: 20,
          ),
          if (currentStateImage.myImageFilter.getFirstView &&
              currentStateImage.myImageFilter.getMyPhoto != "")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints:
                    BoxConstraints(maxWidth: size.width, maxHeight: size.width),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                        File(currentStateImage.myImageFilter.getMyPhoto))),
              ),
            ),
          if (currentStateImage.myImageFilter.getNumberFilter != null)
            RepaintBoundary(
              key: globalKey,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: size.width,
                  maxHeight: size.width,
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(filters[
                      currentStateImage.myImageFilter.getNumberFilter as int]),
                  child: Image.file(
                    File(currentStateImage.myImageFilter.getMyPhoto),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          SizedBox(
            height: size.height * 0.03,
          ),
          if (!currentStateImage.myImageFilter.changePosition)
            const LoadPhoto(),
          SizedBox(
            height: size.height * 0.04,
          ),
          currentStateImage.myImageFilter.getChangePosition &&
                  currentStateImage.myImageFilter.getMyPhoto != ""
              ? const PhotoWithFilters()
              : Container()
        ]),
      ),
    );
  }
}
