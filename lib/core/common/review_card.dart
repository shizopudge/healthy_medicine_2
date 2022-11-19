import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/models/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;
  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: review.userAvatar == ''
                ? const CircleAvatar(
                    backgroundImage: AssetImage(Constants.avatarDefault),
                    backgroundColor: Colors.white,
                    radius: 45,
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(review.userAvatar),
                    backgroundColor: Colors.white,
                    radius: 45,
                  ),
          ),
          Column(
            children: [
              Text(
                '${review.createdAt.year}-${review.createdAt.month}-${review.createdAt.day}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
