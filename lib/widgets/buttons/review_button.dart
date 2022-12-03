import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/screens/add_review_screen.dart';
import 'package:healthy_medicine_2/screens/edit_review_screen.dart';
import 'package:healthy_medicine_2/screens/reviews_screen.dart';
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
  void navigateToAddReview(BuildContext context) {
    Routemaster.of(context).push('/add-review/${widget.doctorId}');
  }

  void navigateToEditReview(BuildContext context) {
    Routemaster.of(context).push('/edit-review/${widget.doctorId}');
  }

  bool isLongPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.isReviewsPage
            ? () => showBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 8,
                      ),
                      child: ReviewsScreen(doctorId: widget.doctorId),
                    );
                  },
                )
            : widget.isEditReview
                ? () => navigateToEditReview(context)
                : widget.isAddReview
                    ? () => navigateToAddReview(context)
                    : null,
        onLongPress: widget.isAddReview
            ? null
            : () {
                isLongPressed = true;
                Future.delayed(const Duration(seconds: 2), () {
                  isLongPressed = false;
                });
              },
        borderRadius: BorderRadius.circular(21),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 60,
          width: isLongPressed ? 150 : 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(32),
            gradient: AppTheme.gradientIndigoToRed,
          ),
          child: isLongPressed
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(widget.image),
                    const Gap(5),
                    Expanded(
                      child: Text(
                        widget.text,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.titleTextStyle,
                      ),
                    ),
                  ],
                )
              : Image.asset(widget.image),
        ),
      ),
    );
  }
}
