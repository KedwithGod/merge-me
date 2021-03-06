import 'package:flutter/material.dart';
import 'package:mergeme/Model/constants/drawer.dart';
import 'package:mergeme/ViewModel/LearningPageViewModel.dart';
import 'package:mergeme/Views/History/LearningActiveTab.dart';
import 'package:mergeme/Views/History/LearningCompletedTab.dart';
import 'package:mergeme/Views/History/shared_header.dart';
import 'package:mergeme/Views/Uielements/Shared.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

import 'LearningClosedTab.dart';
import 'TabBar.dart';

class LearningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveSize dynamicSize =ResponsiveSize(context);
    // custom width
    double width(value) {
      return dynamicSize.width(value / 375);
    }

    // custom height
    double height(value) {
      return dynamicSize.height(value / 667);
    }
    return ViewModelProvider<LearningPageViewModel>.withConsumer(
      onModelReady: (model){model.getNotificationFromDataBase(context);
      model.getNotificationValue(context);},
      viewModelBuilder: ()=>LearningPageViewModel(),
      disposeViewModel: false,
      builder: (context, model, child)=> DefaultTabController(length: 3,
        child: Scaffold(
          drawer: CustomDrawer(),
          body: SafeArea(
            child: Stack(
                children:[
                  SharedHeader('Learning'),
                  // finally i got a way to display a tab and tabView seperately
                  // within the same widget tree, BRAVO!
                  Positioned(left: width(14),
                      right: 0,
                      bottom: 0,
                      top: height(69),
                      child: Column(
                        children: <Widget>[
                          Tabs(),
                        ],
                      )),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    left: width(14),
                    top: height(133),
                    child: TabBarView(
                        children: [
                          LearningActiveTab(),
                          LearningCompletedTab(),
                          LearningClosedTab(),
                        ]),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
