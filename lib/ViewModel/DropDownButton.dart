import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mergeme/Model/Service/Bloc_settings.dart';
import 'package:flutter/material.dart';
import 'package:mergeme/Model/Service/Navigator_service.dart';
import 'package:mergeme/Model/Service/localStorage_service.dart';
import 'package:mergeme/Model/Service/locator_setup.dart';
import 'package:mergeme/Model/constants/route_path.dart' as route;
import 'package:mergeme/ViewModel/BaseModel.dart';
import 'package:mergeme/Views/Uielements/Generaldropdowndisplay.dart';
import 'package:quiver/async.dart';

class MainBloc extends BloCSetting {

  final NavigatorService _navigationService = locator<NavigatorService>();
  final LocalStorageService storageService = locator<LocalStorageService>();
  final BaseModel _baseModel=BaseModel();
  var specificTradeVal;
  var tutorOption;
  var noOfUser;

  // no of user retrieval
  update(){
    updateNoOfUser();
  }
  updateNoOfUser() async {

    Firestore.instance.collection("Merge me").document('Users').get().then((value){
      noOfUser=(value.data['No of Users']);
    });
    await rebuildWidgets(ids: [route.NoOfUser]);
  }

  // local storage data retrieval
  updateValue() async {
    await storageService.getData(tradeCategory).then((onValue){
      specificTradeVal=onValue;
    });
    await storageService.getData(route.tutorOption).then((onValue){
      tutorOption=onValue;

    });

    await rebuildWidgets(ids: ['Sign in']);
  }

// route navigation
  Future navigate(routeName){
    return _navigationService.nextPage(routeName);
  }

  int s = 0;
  var tradeName;
  var tradeCategory;
  Function onTapHandler;
  bool toggleView = false;
  int indexValue = 0;

  // Dropdown selections

  Widget tradeSelection() {
    if (tradeCategory == 'Learn a trade') {
      return
        GeneralDropDownDisplay(
            '',
            ['',
              'Local Trade',
              'Tech Jobs',
              'Artisans',
              'Repairs'
            ],
            route.tradeCategory,
            'Choose a Trade',
            'Trade Category');
    }
    if (tradeCategory == 'Search for work') {
      return _baseModel.getTradeCategoryFromDataBase(
          GeneralDropDownDisplay(
        '',
        _baseModel.tradeCategory==[]?['loading..']:_baseModel.tradeCategory,
        route.tradeCategory,
        'Choose a Trade',
        'Trade Category',));
    }


    if (tradeCategory == '' || tradeCategory == 'Give a work') {
      return Container(

      );
    }

    return Container(
    );
  }


  Widget tradeValue() {

    if (tradeName == route.localTrade && tradeCategory != 'Give a work') {
      return _baseModel.getTradeFromDataBase('Local Trade',
          GeneralDropDownDisplay(
              '',
              _baseModel.tradeList,
              route.localTrade,
              'Select a trade',
              'Local trade'));
    }
    else if (tradeName == 'TechJob' && tradeName != '' &&
        tradeCategory != 'Give a work') {
     return _baseModel.getTradeFromDataBase('TechJob',
         GeneralDropDownDisplay(
             '',
             _baseModel.tradeList,
             route.techJobs,
             'Select a trade',
             'Tech jobs'));

    }
    else if (tradeName == route.artisans && tradeName != '' &&
        tradeCategory != 'Give a work') {
      return _baseModel.getTradeFromDataBase('Artisans',
          GeneralDropDownDisplay(
              '',
              _baseModel.tradeList,
              route.artisans,
              'Select a trade',
              'Artisans'));

    }
    else if (tradeName == route.repairs && tradeName != '' &&
        tradeCategory != 'Give a work') {
      return _baseModel.getTradeFromDataBase('Repairs',
          GeneralDropDownDisplay(
              '',
              _baseModel.tradeList,
              route.artisans,
              'Select a trade',
              'Repairs'));

    }

    else {
      return Container(
      );
    }
  }

  Widget onTap() {
    return Container(
        child: tradeName != '' ? Text('Select $tradeName 1 times more') : Text(
            'rebuild $s'),
        color: Colors.white,
        height: 80);
  }


  onChanged(String userKey, String userValue) async {
    onTapHandler =
        () async {
      if (tradeName != null) {
        toggleView = !toggleView;
        print(" ontap: $toggleView");
      }
    };

    if (userKey == route.trade) {
      tradeCategory = userValue;
    }
    else if (userKey == route.tradeCategory) {
      tradeName = userValue;

    }
    if (userKey==route.localTrade){
      specificTradeVal=userValue;
    }
    else if (userKey==route.artisans){
      specificTradeVal=userValue;
    }
    else if (userKey==route.repairs){
      specificTradeVal=userValue;
    }
    if (userKey==route.techJobs){
      specificTradeVal=userValue;
    }

    else if (userKey== route.tutorOption){
      tutorOption=userValue;
    }

    await rebuildWidgets(ids: ['dropdown', 'TradeSelection','Sign in']);
  }


  // index stack selection handler

  onSwipeRight() async{
    indexValue > 0 ? indexValue-- : indexValue = 0;
    print(indexValue);
    await rebuildWidgets(ids: ['swipeDetector','indexStack']);
  }

  onSwipeLeft() async {
    indexValue < 2 ? indexValue++ : indexValue = 2;
    await rebuildWidgets(ids: ['swipeDetector','indexStack',]);
    print(indexValue);
  }

  indexChange(int index) async {
    indexValue = index;
    await rebuildWidgets(ids: ['indexStack','swipeDetector']);
  }

  nullField(){
    return null;
  }
 int _elapsed=0;
  int get elapsed=>_elapsed*6==90?_elapsed=0:_elapsed=_elapsed;




 loadingWidget(){
   try{
     final cd = CountdownTimer(Duration(seconds: 15), Duration(seconds: 1));
     cd.listen((data) async{
       _elapsed = cd.elapsed.inSeconds;
       await rebuildWidgets(ids: ['timer']);
     }, onDone: () {
       cd.cancel();
     }, onError: (e){
       print(e.toString());
     });
   }catch(e){
     print(e.toString());
   }
  }

  Timer _timer;
  int _start = 0;
  int get start=>_start;

  startTimer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
            (Timer timer)  {
          if (_start ==15) {
            timer.cancel();
            _start=0;
          } else {
            _start = _start +1;
             rebuildWidgets(ids: ['timer']);
          }
        }

    );
    print('start: $_start');

  }



  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
MainBloc mainBloc;


