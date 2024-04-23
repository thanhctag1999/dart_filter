import 'dart:io';

import 'package:dart_filter/provider/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/filters.dart';

class PhotoWithFilters extends StatelessWidget {
  const PhotoWithFilters({super.key});

  @override
  Widget build(BuildContext context) {
    AppStateProvider currentStateImage = Provider.of<AppStateProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              currentStateImage.tercearyChange(index);
            },
            child: SizedBox(
              height: 130,
              width: 130,
              child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(filters[index]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                    child: Image.file(
                      File(currentStateImage.myImageFilter.getMyPhoto),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
      ),
    );
  }
}
