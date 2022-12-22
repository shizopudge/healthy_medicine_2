import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/models/review_model.dart';

class ReviewCard extends StatefulWidget {
  final ReviewModel review;
  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isRevealed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isRevealed = !isRevealed;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Card(
          color: AppTheme.secondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            widget.review.userAvatar == ''
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage(Constants.avatarDefault),
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(widget.review.userAvatar),
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                  ),
                            const Gap(5),
                            Text(
                              '${widget.review.userFirstName} ${widget.review.userLastName}',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          widget.review.reviewText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: isRevealed ? 10 : 5,
                          style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.review.createdAt.day}/${widget.review.createdAt.month}/${widget.review.createdAt.year}',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.review.rating}',
                                  style: AppTheme.dedicatedWhiteTextStyle,
                                ),
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.indigo,
                                  size: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
