import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, 
    required this.onPressed, 
    this.backgroundColor = Colors.blue, 
    this.textColor = Colors.white, required this.text,
  });

  final void Function()? onPressed;
  final Color backgroundColor, textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: backgroundColor,
        shape: StadiumBorder()
      ),
      onPressed: onPressed, 
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(text, style: TextStyle(color: textColor, fontSize: 17))
        ),
      )
    );
  }
}