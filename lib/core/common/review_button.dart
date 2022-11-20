import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class ReviewButton extends StatefulWidget {
  final String doctorId;
  final String image;
  final String text;
  final bool isAddReview;
  final bool isEditReview;
  final bool isReviewsPage;
  const ReviewButton({
    super.key,
    required this.doctorId,
    required this.image,
    required this.isAddReview,
    required this.isEditReview,
    required this.isReviewsPage,
    required this.text,
  });

  @override
  State<ReviewButton> createState() => _EntryButtonState();
}

class _EntryButtonState extends State<ReviewButton> {
  void navigateToReviewsScreen(BuildContext context) {
    Routemaster.of(context).push('/reviews/${widget.doctorId}');
  }

  void navigateToEditCommentScreen(BuildContext context) {
    Routemaster.of(context).push('/edit-review/${widget.doctorId}');
  }

  void navigateToAddCommentScreen(BuildContext context) {
    Routemaster.of(context).push('/add-review/${widget.doctorId}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.isReviewsPage
            ? () => navigateToReviewsScreen(context)
            : widget.isEditReview
                ? () => navigateToEditCommentScreen(context)
                : widget.isAddReview
                    ? () => navigateToAddCommentScreen(context)
                    : null,
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
                  widget.image,
                  height: 50,
                ),
                Text(
                  widget.text,
                  style: const TextStyle(
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
