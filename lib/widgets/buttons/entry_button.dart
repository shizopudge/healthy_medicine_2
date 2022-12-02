import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:routemaster/routemaster.dart';

class EntryButton extends StatefulWidget {
  final String doctorId;
  const EntryButton({
    super.key,
    required this.doctorId,
  });

  @override
  State<EntryButton> createState() => _EntryButtonState();
}

class _EntryButtonState extends State<EntryButton> {
  void navigateToEntryScreen(BuildContext context) {
    Routemaster.of(context).push('/entry/${widget.doctorId}');
  }

  bool isLongPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => navigateToEntryScreen(context),
        onLongPress: () {
          isLongPressed = true;
          Future.delayed(const Duration(seconds: 2), () {
            isLongPressed = false;
          });
        },
        borderRadius: BorderRadius.circular(21),
        child: Container(
            padding: const EdgeInsets.all(12),
            height: 60,
            width: isLongPressed ? 180 : 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(32),
              gradient: AppTheme.gradientIndigoToRed,
            ),
            child: isLongPressed
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/calendar.png'),
                      const Gap(5),
                      Expanded(
                        child: Text(
                          'Записаться',
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.titleTextStyle,
                        ),
                      ),
                    ],
                  )
                : Image.asset('assets/images/calendar.png')),
      ),
    );
  }
}
