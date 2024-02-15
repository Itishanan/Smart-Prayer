import 'package:flutter/material.dart';

class login_divider extends StatelessWidget {
   const login_divider( {super.key, required this.dividerText});
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(dividerText),
        const Flexible(
          child: Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
