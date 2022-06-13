import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GredientButton extends StatelessWidget {
  final double? radius;
  final Color? splashColor;
  final Color? textColor;
  final Color? buttonColor;
  final String title;
  final Function onPressed;
  final List<Color> colors;
  final SvgPicture? svgPicture;

  const GredientButton(
      {Key? key,
      this.radius,
      this.svgPicture,
      this.splashColor,
      this.textColor,
      this.buttonColor,
      required this.title,
      required this.onPressed,
      required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 15),
      onTap: onPressed as void Function()?,
      splashColor: splashColor ?? Colors.blue,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15),
          gradient: LinearGradient(colors: colors),
          color: buttonColor ?? Colors.blue,
          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08))],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontSize: 19, color: textColor ?? Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                svgPicture != null ? svgPicture! : Text('')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
