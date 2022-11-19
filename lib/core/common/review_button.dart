import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class ReviewButton extends StatefulWidget {
  final String doctorId;
  const ReviewButton({
    super.key,
    required this.doctorId,
  });

  @override
  State<ReviewButton> createState() => _EntryButtonState();
}

class _EntryButtonState extends State<ReviewButton> {
  void navigateToEntryScreen(BuildContext context) {
    Routemaster.of(context).push('/add-review/${widget.doctorId}');
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
                  'assets/images/add_review.png',
                  height: 50,
                ),
                const Text(
                  'Оставить отзыв',
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
