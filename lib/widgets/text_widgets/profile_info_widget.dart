import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

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
        vertical: 6,
      ),
      child: Column(
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
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade300,
            ),
            padding: const EdgeInsets.all(12),
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.dedicatedIndigoTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
