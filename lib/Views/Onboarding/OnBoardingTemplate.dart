import 'package:flutter/material.dart';
import 'file:///C:/Users/user/Documents/Flutter_projects/merge_me/lib/Views/Uielements/AdaptivePostionedWidget.dart';
import 'file:///C:/Users/user/Documents/Flutter_projects/merge_me/lib/Views/Uielements/Generalbuttondisplay.dart';
import 'file:///C:/Users/user/Documents/Flutter_projects/merge_me/lib/Views/Uielements/Generaltextdisplay.dart';

class OnBoardingTemplate extends StatefulWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final bool useBackButton;
  final bool useNextButton;
  final Function backButtonPress;
  final Function nextButtonPress;
  final Function getStartedPress;

  OnBoardingTemplate(
      this.subtitle,
      this.backButtonPress,
      this.nextButtonPress,
      this.getStartedPress,
      this.imageAsset,
      this.title,
      this.useBackButton,
      this.useNextButton);

  @override
  _OnBoardingTemplateState createState() => _OnBoardingTemplateState();
}

class _OnBoardingTemplateState extends State<OnBoardingTemplate> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body:  Stack(
          children: <Widget>[
            Positioned(
              left: 0.0,
              top: 15.0,
              child: AnimatedContainer(
                height: orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height * (296 / 667)
                    : MediaQuery.of(context).size.width * (296 / 667),
                width: orientation == Orientation.landscape
                    ? MediaQuery.of(context).size.height * (375 / 375)
                    : MediaQuery.of(context).size.width * (375 / 375),
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: Image.asset(
                  widget.imageAsset,
                  fit: BoxFit.cover,
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * (296 / 667)
                      : MediaQuery.of(context).size.width * (296 / 667),
                  width: orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height * (375 / 375)
                      : MediaQuery.of(context).size.width * (375 / 375),
                ),
              ),
            ),
            AdaptivePositioned(
                left: 0.0,
                top: 307,
                child: Container(
                  color: Colors.black,
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * (3 / 667)
                      : MediaQuery.of(context).size.width * (3 / 667),
                  width: orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height * (375 / 375)
                      : MediaQuery.of(context).size.width * (375 / 375),
                )),
            AdaptivePositioned(
                left: 25.0,
                top: 338,
                child: GeneralTextDisplay(widget.title, Colors.black, 1, 25,
                    FontWeight.w900, '${widget.title} onboarding text')),
            AdaptivePositioned(
                left: 22.0,
                top: 392,
                child: GeneralTextDisplay(
                    widget.subtitle,
                    Color.fromRGBO(85, 85, 85, 1.0),
                    8,
                    14,
                    FontWeight.w200,
                    '${widget.title} onboarding subtitle')),
            AdaptivePositioned(
                top: 570,
                left: 16,
                child: GeneralButton(
                    "",
                    1,
                    '${widget.title} Get started semantics',
                    'Get Started',
                    Colors.white,
                    13,
                    FontWeight.w400,
                    40,
                    140,
                    widget.getStartedPress,
                    11,
                    11,
                    11,
                    11,
                    Color.fromRGBO(238, 83, 79, 1.0),
                    Colors.white,
                    4.0)),
            widget.useNextButton == false
                ? Container()
                : AdaptivePositioned(
                    top: 570,
                    left: 260,
                    child: GeneralButton(
                        "Flat",
                        1,
                        '${widget.title} Next button semantics',
                        'Next',
                        Color.fromRGBO(238, 83, 79, 1.0),
                        13,
                        FontWeight.w400,
                        19,
                        32,
                        widget.nextButtonPress,
                        2,
                        2,
                        2,
                        2,
                        Colors.transparent,
                        Colors.white,
                        0.0)),
            widget.useBackButton == false
                ? Container()
                : AdaptivePositioned(
                    top: 644,
                    left: widget.useNextButton == false ? 280 : 208,
                    child: GeneralButton(
                        "Flat",
                        1,
                        '${widget.title} Back button semantics',
                        'Back',
                        widget.useNextButton == false
                            ? Color.fromRGBO(238, 83, 79, 1.0)
                            : Color.fromRGBO(127, 127, 127, 1.0),
                        13,
                        FontWeight.w400,
                        19,
                        32,
                        widget.backButtonPress,
                        2,
                        2,
                        2,
                        2,
                        Colors.transparent,
                        Colors.white,
                        0.0))
          ],
        ),

    );
  }
}

/*
Positioned(
left:32,
top:600,
child: GeneralButton(
'',
1,
'Get started sematics',
'Get Started',
Colors.white,
13,
FontWeight.w400,
40 ,
140,
(){},
11,
11,
11,
11,
Color.fromRGBO(238, 83, 79, 1.0),
Colors.white,
4.0),
)*/