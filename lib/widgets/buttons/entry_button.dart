import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => navigateToEntryScreen(context),
        child: Card(
          color: Constants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/calendar.png',
                  height: 50,
                ),
                const Text(
                  'Записаться',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
