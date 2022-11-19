import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/common/entry_button.dart';
import 'package:healthy_medicine_2/core/common/error_text.dart';
import 'package:healthy_medicine_2/core/common/loader.dart';
import 'package:healthy_medicine_2/core/common/rating_bar.dart';
import 'package:healthy_medicine_2/core/common/review_button.dart';
import 'package:healthy_medicine_2/core/common/review_card.dart';
import 'package:healthy_medicine_2/core/common/reviews.dart';
import 'package:healthy_medicine_2/models/doctor_model.dart';
import 'package:healthy_medicine_2/reviews/reviews_controller.dart';
import 'package:routemaster/routemaster.dart';

class DoctorInfo extends ConsumerStatefulWidget {
  final Doctor doctor;
  const DoctorInfo({
    super.key,
    required this.doctor,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends ConsumerState<DoctorInfo> {
  double sum = 0;
  double avg = 0;
  List<dynamic> rating = [];

  getAvgRating() {
    for (var element in widget.doctor.rating) {
      sum = element + sum;
    }
    rating = widget.doctor.rating.toList();
    rating.removeAt(0);
    rating.isNotEmpty ? avg = sum / rating.length : null;
    print(avg);
  }

  @override
  void initState() {
    super.initState();
    getAvgRating();
  }

  void navigateToEditCommentScreen(BuildContext context) {
    Routemaster.of(context).push('/edit-review/${widget.doctor.id}');
  }

  bool isDatePicked = false;
  String cellId = '';
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.doctor.image),
              radius: 90,
              backgroundColor: Colors.white,
            ),
          ),
          Text(
            '${widget.doctor.firstName} ${widget.doctor.lastName}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/surgeon_v2.png',
                height: 40,
              ),
              const Gap(5),
              Text(
                widget.doctor.spec,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          rating.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar(rating: avg, ratingCount: rating.length),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < 5; i++)
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.grey,
                          size: 26,
                        ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          '0',
                          style: TextStyle(fontSize: 21, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Опыт работы: ${widget.doctor.experience} ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              // защита слабого типа))) лучше бы поменять
              widget.doctor.experience > 1 && widget.doctor.experience < 5
                  ? const Text(
                      'года',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  : widget.doctor.experience == 1
                      ? const Text(
                          'год',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                      : const Text(
                          'лет',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Маленький текст с информацией о докторе.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 20,
              ),
            ),
          ),
          EntryButton(
            doctorId: widget.doctor.id,
          ),
          widget.doctor.comments.contains(user.uid)
              ? const SizedBox()
              : ReviewButton(
                  doctorId: widget.doctor.id,
                ),
          const Divider(
            thickness: 1,
            color: Colors.white,
          ),
          widget.doctor.comments.contains(user.uid)
              ? Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Мой отзыв',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ref
                        .watch(getReviewByUserIdProvider(MyParameter(
                            uid: user.uid, doctorId: widget.doctor.id)))
                        .when(
                          data: (review) {
                            return InkWell(
                              onTap: () => navigateToEditCommentScreen(context),
                              child: ReviewCard(
                                review: review,
                              ),
                            );
                          },
                          error: (error, stackTrace) => ErrorText(
                            error: error.toString(),
                          ),
                          loading: () => const Loader(),
                        ),
                  ],
                )
              : const SizedBox(),
          const Divider(
            thickness: 1,
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Отзывы',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: Reviews(
              doctorId: widget.doctor.id,
            ),
          ),
        ],
      ),
    );
  }
}
