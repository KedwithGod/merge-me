import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mergeme/Model/constants/loading.dart';
import 'package:mergeme/Model/constants/route_path.dart' as route;
import 'package:mergeme/ViewModel/WelcomeViewmodel.dart';
import 'package:mergeme/Views/Uielements/AdaptivePostionedWidget.dart';
import 'package:mergeme/Views/Uielements/Generalbuttondisplay.dart';
import 'package:mergeme/Views/Uielements/Generaltextdisplay.dart';
import 'package:mergeme/Views/Uielements/Shared.dart';
import 'package:mergeme/Views/Uielements/sizedBox.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class WelcomeBack extends StatelessWidget {

  final bool loading = false;

  @override
  Widget build(BuildContext context) {
    ResponsiveSize dynamicSize = ResponsiveSize(context);
    double width(value) {
      return dynamicSize.width(value / 375);
    }

    // custom height
    double height(value) {
      return dynamicSize.height(value / 667);
    }



    return ViewModelProvider<WelcomeViewModel>.withConsumer(
      onModelReady: (model){model.userLocation(context,);
      model.networkConnection();
      model.getNotificationFromDataBase(context);
      model.getNotificationValue(context);
      model.updateUser();
      print('notification from welcomepage${model.notificationValue}');
      },
        viewModelBuilder: ()=>WelcomeViewModel(),
          builder: (context, model, child) => model.netStat==false?
          SafeArea(
            child:  Scaffold(
              body: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/network.gif'),
                      AdaptiveSizedBox(
                        height: 20/667,
                      ),
                      GeneralTextDisplay('Kindly switch on your data', Colors.black87, 2,
                          15, FontWeight.w600, 'data connection')
                    ],
                ),
              ),
            ),

          ):Scaffold(
              body: SafeArea(
            child: Stack(children: <Widget>[
              AdaptivePositioned(
                left: 334,
                top: 10,
                child: Hero(
                  tag: 'Merge me',
                  child: Container(
                    height: dynamicSize.height(30 / 667),
                    width: dynamicSize.width(30 / 375),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Merge.PNG'),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
                AdaptivePositioned(
                    left: 60,
                    top: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(238, 83, 79, 1.0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            dynamicSize.width(100 / 375),
                          ),
                          bottomRight:
                              Radius.circular(dynamicSize.width(100 / 375)),
                        ),
                      ),
                      height: dynamicSize.height(190 / 667),
                      width: dynamicSize.width(220 / 375),
                    )),

              AdaptivePositioned(
                  left: 100,
                  top: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 42, 53, 1.0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          dynamicSize.width(100 / 375),
                        ),
                        bottomRight:
                            Radius.circular(dynamicSize.width(100 / 375)),
                      ),
                    ),
                    height: dynamicSize.height(170 / 667),
                    width: dynamicSize.width(200 / 375),
                  )),
              AdaptivePositioned(
                left: 120,
                top: 134,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/office.jpg'),
                  maxRadius: dynamicSize.width(80 / 375),
                ),
              ),
               AdaptivePositioned(
                  left: 0,
                  top: 290,
                  child: StreamBuilder(
                          stream: Firestore.instance
                              .collection('DataBase')
                              .document(model.currentUser.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState==ConnectionState.waiting) return Loading();
                            if (snapshot.hasData)
                              return Container(
                                width: dynamicSize.width(375 / 375),
                                height: dynamicSize.height(110 / 667),
                                alignment: Alignment.center,
                                child: GeneralTextDisplay(
                                    '${model.greet}, ${snapshot.data['name'] == null ? '' : snapshot.data['name']}!',
                                    Colors.black,
                                    1,
                                    20,
                                    FontWeight.bold,
                                    'Welcome back ${route.Name}'),
                              );
                            return Container();
                          }),
                ),

              AdaptivePositioned(
                left: 0,
                top: 359,
                child: Container(
                  width: dynamicSize.width(375 / 375),
                  height: dynamicSize.height(60 / 667),
                  alignment: Alignment.center,
                  child: GeneralTextDisplay(
                      'Welcome back to Merge me',
                      Color.fromRGBO(85, 85, 85, 1.0),
                      1,
                      15,
                      FontWeight.w600,
                      'Welcome back to Merge me ${route.Name}'),
                ),
              ),
              AdaptivePositioned(
                left: 0,
                top: 391,
                child: Container(
                  width: dynamicSize.width(375 / 375),
                  height: dynamicSize.height(40 / 667),
                  alignment: Alignment.center,
                  child: GeneralTextDisplay(
                      'we have been waiting for you.',
                      Colors.black45,
                      1,
                      13,
                      FontWeight.w400,
                      'we have been waiting for you. ${route.Name}'),
                ),
              ),
              AdaptivePositioned(
                left: 106,
                top: 459,
                child: GeneralButton('', 1, 'Lets go', 'Let\'s go',
                    Colors.white, 16, FontWeight.w200, 40, 140, () {
                  model.landingPage();
                }, 11, 11, 11, 11, Color.fromRGBO(220, 42, 53, 1.0),
                    Colors.white, 2.0),
              )
            ]),
          )),
        );
  }
}
