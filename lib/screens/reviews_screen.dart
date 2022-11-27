import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/buttons/review_button.dart';
import 'package:healthy_medicine_2/widgets/cards/review_card.dart';
import 'package:healthy_medicine_2/widgets/lists/reviews.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/reviews/reviews_controller.dart';
import 'package:routemaster/routemaster.dart';

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
      backgroundColor: Constants.bg,
      appBar: AppBar(
        backgroundColor: Constants.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Routemaster.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.textColor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ref.watch(getDoctorByIdProvider(widget.doctorId)).when(
          data: (doctor) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  doctor.comments.contains(user.uid)
                      ? Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Ваш отзыв',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
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
                            ReviewButton(
                              doctorId: doctor.id,
                              image: 'assets/images/add_review.png',
                              isAddReview: false,
                              isEditReview: true,
                              isReviewsPage: false,
                              text: 'Изменить отзыв',
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            ReviewButton(
                              doctorId: doctor.id,
                              image: 'assets/images/add_review.png',
                              isAddReview: true,
                              isEditReview: false,
                              isReviewsPage: false,
                              text: 'Оставить отзыв',
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/reviews.png',
                          height: 50,
                        ),
                        const Text(
                          'Отзывы',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 305,
                    child: Reviews(
                      doctorId: doctor.id,
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
