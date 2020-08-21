import 'package:flutter/material.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/colors.dart';

class SocialButton extends StatefulWidget {
  final Organization organization;
  SocialButton({@required this.organization});

  @override
  _SocialButtonState createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    AssetImage socialLogo;
    Color backgroundColor;
    double logoHeight;

    // *if you want to add more buttons with different styles, implement in new case below
    switch (widget.organization) {
      case Organization.Google:
        socialLogo = AssetImage('assets/social_media/google_logo.png');
        backgroundColor = Colors.white;
        logoHeight = 27.0;
        break;
      case Organization.Facebook:
        socialLogo = AssetImage('assets/social_media/facebook_logo.png');
        backgroundColor = ColorStyle.facebook;
        logoHeight = 32.0;
        break;
      default:
        socialLogo = AssetImage('assets/social_media/facebook_logo.png');
        backgroundColor = ColorStyle.facebook;
        logoHeight = 32.0;
        break;
    }

    return AnimatedContainer(
        padding: EdgeInsets.only(
            top: (select) ? BaseStyles.offsetTop : BaseStyles.insetVerticle,
            bottom:
                (select) ? BaseStyles.offsetBottom : BaseStyles.insetVerticle),
        child: GestureDetector(
          child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: (select)
                      ? BaseStyles.boxShadowPress
                      : BaseStyles.boxShadow),
              child: Center(
                child: Image(
                  image: socialLogo,
                  height: logoHeight,
                ),
              )),
          onTapDown: (details) {
            setState(() {
              select = !select;
            });
          },
          onTapUp: (details) {
            setState(() {
              select = !select;
            });
          },
          onTap: () {
            print('Social Media Login');
          },
        ),
        duration: Duration(milliseconds: 25));
  }
}

enum Organization { Facebook, Google }
