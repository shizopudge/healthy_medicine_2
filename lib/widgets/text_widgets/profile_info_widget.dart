import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/constants.dart';

class ProfileInfoWidget extends StatefulWidget {
  final String title;
  final String text;
  const ProfileInfoWidget({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              widget.title,
              style: AppTheme.dedicatedIndigoTextStyle.copyWith(
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(21),
              color: Colors.grey.shade300,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.text,
                style: AppTheme.dedicatedWhiteTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
