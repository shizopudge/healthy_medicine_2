import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/reviews/reviews_controller.dart';
import 'package:healthy_medicine_2/widgets/buttons/review_button.dart';
import 'package:healthy_medicine_2/widgets/cards/review_card.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/lists/reviews.dart';

class ReviewsScreen extends ConsumerStatefulWidget {
  final String doctorId;
  const ReviewsScreen({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends ConsumerState<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: SafeArea(
        child: ref.watch(getDoctorByIdProvider(widget.doctorId)).when(
            data: (doctor) {
              return Column(
                children: [
                  doctor.comments.contains(user.uid)
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ваш отзыв',
                                    style: AppTheme.headerTextStyle,
                                  ),
                                  ReviewButton(
                                    doctorId: doctor.id,
                                    image: 'assets/images/edit_review.png',
                                    isAddReview: false,
                                    isEditReview: true,
                                    isReviewsPage: false,
                                    text: 'Изменить отзыв',
                                  ),
                                ],
                              ),
                            ),
                            ref
                                .watch(getReviewByUserIdProvider(MyParameter(
                                    uid: user.uid, doctorId: doctor.id)))
                                .when(
                                  data: (review) {
                                    return ReviewCard(
                                      review: review,
                                    );
                                  },
                                  error: (error, stackTrace) => ErrorText(
                                    error: error.toString(),
                                  ),
                                  loading: () => const Loader(),
                                ),
                            const Divider(
                              thickness: 1.5,
                              color: AppTheme.indigoColor,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Хотите оставить отзыв?',
                                  style: AppTheme.titleTextStyle,
                                ),
                                ReviewButton(
                                  doctorId: doctor.id,
                                  image: 'assets/images/add_review.png',
                                  isAddReview: true,
                                  isEditReview: false,
                                  isReviewsPage: false,
                                  text: 'Оставить отзыв',
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.5,
                              color: AppTheme.indigoColor,
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Отзывы',
                          style: AppTheme.headerTextStyle,
                        ),
                        const Gap(5),
                        Image.asset(
                          'assets/images/reviews.png',
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Reviews(
                      doctorId: doctor.id,
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader()),
      ),
    );
  }
}
