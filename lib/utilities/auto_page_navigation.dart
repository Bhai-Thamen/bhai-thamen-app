import 'package:flutter/material.dart';

class AutoHomePageMapSelect extends ChangeNotifier {

  AutoHomePageMapSelect(this._gotoMap);

  bool _gotoMap = false;

  bool get shouldGoMap => _gotoMap;

  set homePageMapSet (bool val){
    _gotoMap = val;
    notifyListeners();
  }

  setHomePageMap(bool val)async{
    _gotoMap = val;
    notifyListeners();
  }

}

class AutoHomePageAskSelect extends ChangeNotifier {

  AutoHomePageAskSelect(this._gotoAsk);

  bool _gotoAsk = false;

  bool get shouldGoAsk => _gotoAsk;

  set goToAsk (bool val){
    _gotoAsk = val;
    notifyListeners();
  }

  setHomePageAsk(bool val)async{
    _gotoAsk = val;
    notifyListeners();
  }

}

class PinRequired extends ChangeNotifier {

  PinRequired(this._gotoChange);

  bool _gotoChange = false;

  bool get getPinRequired => _gotoChange;

  set goToChange (bool val){
    _gotoChange = val;
    notifyListeners();
  }

  setPinRequired(bool val)async{
    _gotoChange = val;
    notifyListeners();
  }

}

class SafePageIndex extends ChangeNotifier {

  SafePageIndex(this._safeIndex);

  int _safeIndex = 0;

  int get getSafeIndex => _safeIndex;

  set setSafeIndex (int val){
    _safeIndex = val;
    notifyListeners();
  }
  setSafePageIndex(int val)async{
    _safeIndex = val;
    notifyListeners();
  }


}