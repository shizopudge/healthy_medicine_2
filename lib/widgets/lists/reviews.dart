import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/cards/review_card.dart';
import 'package:healthy_medicine_2/core/reviews/reviews_controller.dart';

class Reviews extends ConsumerWidget {
  final String doctorId;
  const Reviews({
    super.key,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getDoctorsReviewsProvider(doctorId)).when(
          data: (reviews) {
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (BuildContext context, int index) {
                final review = reviews[index];
                return ReviewCard(review: review);
              },
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
