import 'package:flutter/material.dart';
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
          color: Constants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.review.userAvatar == ''
                    ? const CircleAvatar(
                        backgroundImage: AssetImage(Constants.avatarDefault),
                        backgroundColor: Colors.white,
                        radius: 45,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(widget.review.userAvatar),
                        backgroundColor: Colors.white,
                        radius: 45,
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${widget.review.userFirstName} ${widget.review.userLastName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        widget.review.reviewText,
                        overflow: TextOverflow.ellipsis,
                        // locale: const Locale('ru', 'RU'), мб локале нужно делать ХЗ
                        maxLines: isRevealed ? 10 : 5,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${widget.review.createdAt.day}/${widget.review.createdAt.month}/${widget.review.createdAt.year}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.review.rating}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.red,
                    size: 26,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
