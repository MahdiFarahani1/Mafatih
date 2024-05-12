import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/aboutus_repository.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';

class Btn {
  static Widget btnSocial(
      {required IconData iconData,
      required VoidCallback onPress,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 0.3,
              color: Colors.black,
            )),
        alignment: Alignment.center,
        child: Icon(
          color: Colors.white,
          iconData,
          size: 22,
        ),
      ),
    );
  }

  static Widget btncircle(
      {required IconData iconData,
      required double size,
      required VoidCallback onTap,
      required BuildContext context}) {
    return GFIconButton(
      size: size,
      iconSize: size,
      onPressed: onTap,
      shape: GFIconButtonShape.square,
      alignment: Alignment.center,
      icon: Icon(
        iconData,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      borderShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  static List<Widget> allbtn(BuildContext context) {
    return [
      Btn.btnSocial(
        context: context,
        iconData: FontAwesomeIcons.earthAmericas,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlSite);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        context: context,
        iconData: FontAwesomeIcons.instagram,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlInstagram);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        context: context,
        iconData: FontAwesomeIcons.telegram,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlTelegram);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        context: context,
        iconData: FontAwesomeIcons.youtube,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlYoutube);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        context: context,
        iconData: FontAwesomeIcons.facebook,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlFacebook);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        context: context,
        iconData: FontAwesomeIcons.whatsapp,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlWhatsapp);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        context: context,
        iconData: FontAwesomeIcons.xTwitter,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlTwitter);
        },
      ),
    ];
  }
}
