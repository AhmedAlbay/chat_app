import 'package:flutter/material.dart';

class button extends StatelessWidget {
  button({ this.onTap, required this.tittle});
  VoidCallback? onTap;
  String tittle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            tittle,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
