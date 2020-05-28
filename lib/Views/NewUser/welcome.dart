import 'package:flutter/material.dart';
import 'package:mergeme/Model/Service/Auth_service.dart';
import 'package:mergeme/Model/Service/locator_setup.dart';
import 'package:mergeme/Model/constants/loading.dart';
import 'package:mergeme/ViewModel/LoginModel.dart';
import 'package:mergeme/Views/Uielements/AdaptivePostionedWidget.dart';
import 'package:mergeme/Views/Uielements/Generalbuttondisplay.dart';
import 'package:mergeme/Views/Uielements/Generaltextdisplay.dart';
import 'package:mergeme/Views/Uielements/Shared.dart';
import 'package:mergeme/Model/constants/route_path.dart' as route;
import 'package:provider/provider.dart';

class WelcomeBack extends StatelessWidget {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final bool loading=false;

  @override
  Widget build(BuildContext context) {
    ResponsiveSize dynamicSize = ResponsiveSize(context);
   var result=_authenticationService.welcomeBack();
    return ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) =>
          _authenticationService.currentUser==null ? Loading() : Scaffold(
              body: Stack(children: <Widget>[
            AdaptivePositioned(
              left: 334,
              top: 10,
              child: Container(
                height: dynamicSize.height(30 / 667),
                width: dynamicSize.width(30 / 375),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Merge.PNG'),
                        fit: BoxFit.contain)),
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
              left: 117,
              top: 124,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/office.jpg'),
                maxRadius: dynamicSize.width(80 / 375),
              ),
            ),
            AdaptivePositioned(
              left: 110,
              top: 322,
              child: GeneralTextDisplay(
                  'Hi ${_authenticationService.currentUser.fullName==null? 'User':
                  _authenticationService.currentUser.fullName}',
                  Colors.black,
                  1,
                  20,
                  FontWeight.bold,
                  'Welcome back ${route.Name}'),
            ),
            AdaptivePositioned(
              left: 70,
              top: 359,
              child: GeneralTextDisplay(
                  'Welcome back to Merge me',
                  Color.fromRGBO(85, 85, 85, 1.0),
                  1,
                  15,
                  FontWeight.w600,
                  'Welcome back to Merge me ${route.Name}'),
            ),
            AdaptivePositioned(
              left: 80,
              top: 391,
              child: GeneralTextDisplay(
                  'we have been waiting for you.',
                  Colors.black45,
                  1,
                  13,
                  FontWeight.w400,
                  'we have been waiting for you. ${route.Name}'),
            ),
            AdaptivePositioned(
              left: 106,
              top: 459,
              child: GeneralButton('', 1, 'Lets go', 'Let\'s go', Colors.white,
                  16, FontWeight.w200, 40, 140, () {
                model.landingPage();
              }, 11, 11, 11, 11, Color.fromRGBO(220, 42, 53, 1.0), Colors.white,
                  2.0),
            )
          ])),
        ));
  }
}
