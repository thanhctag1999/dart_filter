import 'package:flutter/material.dart';

class MyImageFilter {
  String myPhoto;
  bool changePosition;
  int? numberFilter;
  bool firstView;

  MyImageFilter(
      {required this.myPhoto,
      required this.changePosition,
      required this.numberFilter,
      required this.firstView});

  String get getMyPhoto => myPhoto;
  set setMyPhoto(String value) {
    myPhoto = value;
  }

  bool get getChangePosition => changePosition;
  set setChangePosition(bool value) {
    changePosition = value;
  }

  int? get getNumberFilter => numberFilter;
  set setNumberFilter(int? value) {
    numberFilter = value;
  }

  bool get getFirstView => firstView;
  set setFirstView(bool value) {
    firstView = value;
  }
}

class AppStateProvider extends ChangeNotifier {
  MyImageFilter myImageFilter = MyImageFilter(
      myPhoto: "", changePosition: false, numberFilter: null, firstView: false);

  void chargeImage(String photo) {
    myImageFilter.setMyPhoto = photo;
    myImageFilter.changePosition = true;
    myImageFilter.firstView = true;
    notifyListeners();
  }

  void secondChange() {
    myImageFilter.setChangePosition = false;
    myImageFilter.setFirstView = false;
    myImageFilter.setNumberFilter = null;

    notifyListeners();
  }

  void tercearyChange(int index) {
    myImageFilter.setNumberFilter = index;
    myImageFilter.setFirstView = false;

    notifyListeners();
  }
}
