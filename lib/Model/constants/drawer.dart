import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mergeme/Model/Service/Auth_service.dart';
import 'package:mergeme/Model/Service/localStorage_service.dart';
import 'package:mergeme/Model/Service/locator_setup.dart';
import 'package:mergeme/Model/UserModel/userModel.dart';
import 'package:mergeme/ViewModel/Drawer_model.dart';
import 'package:mergeme/Views/Uielements/AdaptivePostionedWidget.dart';
import 'package:mergeme/Views/Uielements/Generalicondisplay.dart';
import 'package:mergeme/Views/Uielements/Generaltextdisplay.dart';
import 'package:mergeme/Views/Uielements/Shared.dart';
import 'package:provider/provider.dart';



class CustomDrawer extends StatelessWidget {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final LocalStorageService storageService = locator<LocalStorageService>();

// drawer item widget
  Widget drawerItems(double iconTop, icon, iconKeyString, double textTop, text,
      textSemantics) {
    return Stack(
      children: <Widget>[
        AdaptivePositioned(
          left: 22,
          top: iconTop,
          child: GeneralIconDisplay(icon, Color.fromRGBO(238, 83, 79, 1.0),
              Key(iconKeyString), 20 / 667),
        ),
        AdaptivePositioned(
          left: 78,
          top: textTop,
          child: GeneralTextDisplay(
              text, Colors.black, 1, 17, FontWeight.w400, textSemantics),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final userLocation = Provider.of<UserLocation>(context);

    ResponsiveSize dynamicSize = ResponsiveSize(context);
    return ChangeNotifierProvider(
        create: (context) => DrawerModel(),
        child: Consumer<DrawerModel>(
          builder: (context, model, child) => Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    // Overall container for the drawer
                    child: Container(
                      width: dynamicSize.width(335 / 375),
                      height: dynamicSize.height(667 / 667),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Stack(
                        children: <Widget>[
                          AdaptivePositioned(
                            left: 0,
                            top: 0,

                            // underLaying container for the upper part of the drawer
                            child: Container(
                              width: dynamicSize.width(335 / 375),
                              height: dynamicSize.height(181 / 667),
                              color: Color.fromRGBO(238, 83, 79, 1.0),
                              child: Stack(
                                children: <Widget>[
                                  AdaptivePositioned(
                                    left: 47,
                                    top: 96,
                                    child: Hero(
                                      tag: 'location',
                                      child: GeneralIconDisplay(
                                          Icons.location_on,
                                          Colors.white,
                                          Key('drawer icon location'),
                                          20 / 667),
                                    ),
                                  ),
                                  AdaptivePositioned(
                                      left: 32,
                                      top: 128,
                                      child: userLocation==null?Text('loading..') :GeneralTextDisplay(
                                          userLocation.locality == null
                                              ? ''
                                              : userLocation.locality,
                                          Colors.white,
                                          1,
                                          14,
                                          FontWeight.bold,
                                          'drawer location subtitle')),
                                  AdaptivePositioned(
                                    left: 107,
                                    top: 101,
                                    child: Container(
                                      width: dynamicSize.width(2 / 375),
                                      height: dynamicSize.height(52 / 667),
                                      color: Colors.white,
                                    ),
                                  ),
                                  AdaptivePositioned(
                                    left: 150,
                                    top: 96,
                                    child: GeneralIconDisplay(
                                        Icons.settings_input_composite,
                                        Colors.white,
                                        Key('project/job drawer icon'),
                                        20 / 667),
                                  ),
                                  AdaptivePositioned(
                                    left: 121,
                                    top: 128,
                                    child: GeneralTextDisplay(
                                        '17 Projects',
                                        Colors.white,
                                        1,
                                        14,
                                        FontWeight.bold,
                                        'drawer projects/job subtitle'),
                                  ),
                                  AdaptivePositioned(
                                      left: 141,
                                      top: 148,
                                      child: GeneralTextDisplay(
                                          '3 Jobs',
                                          Colors.white,
                                          1,
                                          14,
                                          FontWeight.bold,
                                          'drawer projects/job third line')),
                                  AdaptivePositioned(
                                    left: 224,
                                    top: 101,
                                    child: Container(
                                      width: dynamicSize.width(2 / 375),
                                      height: dynamicSize.height(52 / 667),
                                      color: Colors.white,
                                    ),
                                  ),
                                  AdaptivePositioned(
                                    left: 256,
                                    top: 97,
                                    child: GeneralIconDisplay(
                                        Icons.credit_card,
                                        Colors.white,
                                        Key('credit Card icon_drawer'),
                                        20 / 667),
                                  ),
                                  AdaptivePositioned(
                                    left: 236,
                                    top: 128,
                                    child: GeneralTextDisplay(
                                        '01235869',
                                        Colors.white,
                                        1,
                                        14,
                                        FontWeight.bold,
                                        'credit card subtitle'),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // overlaying container for the upper part of the drawer
                          AdaptivePositioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: dynamicSize.width(335 / 375),
                              height: dynamicSize.height(72 / 667),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(217, 0, 27, 1.0)),
                              child: Stack(
                                children: <Widget>[
                                  AdaptivePositioned(
                                    left: 17,
                                    top: 10,
                                    child: Container(
                                      width: dynamicSize.height(55 / 667),
                                      height: dynamicSize.height(55 / 667),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/office.jpg'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  AdaptivePositioned(
                                    left: 64,
                                    top: 25,
                                    child: _authenticationService.currentUser ==
                                            null
                                        ? Container()
                                        : StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('DataBase')
                                                .document(_authenticationService
                                                            .currentUser ==
                                                        null
                                                    ? ''
                                                    : _authenticationService
                                                        .currentUser.id)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData)
                                                return Container();
                                              if (snapshot.hasData)
                                                return Container(
                                                  width: dynamicSize
                                                      .width(212 / 357),
                                                  height: dynamicSize
                                                      .height(24 / 667),
                                                  alignment: Alignment.center,
                                                  child: GeneralTextDisplay(
                                                      '${snapshot.data['name'] == null ? '' : snapshot.data['name']}',
                                                      Colors.white,
                                                      1,
                                                      15,
                                                      FontWeight.bold,
                                                      'drawer name'),
                                                );
                                              return Container();
                                            }),
                                  ),
                                  AdaptivePositioned(
                                    left: 277,
                                    top: 24,
                                    child: GeneralIconDisplay(
                                        Icons.settings,
                                        Colors.white,
                                        Key('drawer icon settings'),
                                        25 / 667),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              model.landingPage();
                            },
                            child: drawerItems(198, Icons.home, 'Home_icon',
                                196, 'Home', 'home_subtitle'),
                          ),
                          drawerItems(237, Icons.account_balance_wallet,
                              'wallet_icon', 235, 'Wallet', 'Wallet_subtitle'),
                          drawerItems(276, Icons.person, 'person_icon', 273,
                              'Profile', 'profile_subtitle'),
                          GestureDetector(
                            onTap: () {
                              model.projectPage();
                            },
                            child: drawerItems(315, Icons.group_work, 'project_icon',
                                315, 'Projects', 'Projects_subtitle'),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.jobPage();
                            },
                            child: drawerItems(357, Icons.work, 'Job_icon', 354, 'Job',
                                'Job_subtitle'),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.learningPage();
                            },
                            child: drawerItems(397, Icons.book, 'learning_icon', 396,
                                'Learning page', 'Learning_subtitle'),
                          ),
                          drawerItems(439, Icons.phonelink_setup, "Job_icon",
                              436, 'Job updates', 'job_subtitle'),
                          drawerItems(481, Icons.feedback, 'feedback_icon', 478,
                              'Feedback', 'Feedback_subttitle in drawer'),
                          GestureDetector(
                            onTap: () {
                              model.signOut();
                            },
                            child: drawerItems(
                              523,
                              Icons.transfer_within_a_station,
                              "SignOut_icon",
                              520,
                              'Sign out',
                              'Signout_subtitle',
                            ),
                          ),

                          // drawer item lists
                          /*,*/

                          // The merge me logo underneath every thing

                          AdaptivePositioned(
                            left: 22,
                            top: 600,
                            child: Hero(
                              tag: 'Merge me',
                              child: Container(
                                width: dynamicSize.width(30 / 375),
                                height: dynamicSize.height(30 / 667),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/Merge.PNG'),
                                        fit: BoxFit.contain)),
                              ),
                            ),
                          ),
                          AdaptivePositioned(
                            left: 54,
                            top: 611,
                            child: GeneralTextDisplay(
                                'erge me',
                                Color.fromRGBO(85, 85, 85, 1.0),
                                1,
                                14,
                                FontWeight.w400,
                                'logo_subtitle'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}
