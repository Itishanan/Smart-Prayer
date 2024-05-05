import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartprayer/src/data/repository/authentication_repository.dart';

class footer_login extends StatelessWidget {
  const footer_login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              signInWithGoogle()
                  .then((value) => AuthenticationRepository().screenRedirect());
            },
            icon: FaIcon(FontAwesomeIcons.google)),
        /* IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.facebook))*/
      ],
    );
  }
}
