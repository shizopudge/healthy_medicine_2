import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:routemaster/routemaster.dart';

class AdminEntryAppBar extends StatelessWidget {
  final String title;

  const AdminEntryAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        right: 5,
        left: 5,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () => Routemaster.of(context).pop(),
              borderRadius: BorderRadius.circular(21),
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.grey.shade200,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 24,
                ),
              ),
            ),
          ),
          Text(
            title,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: AppTheme.headerTextStyle,
          ),
        ],
      ),
    );
  }
}
