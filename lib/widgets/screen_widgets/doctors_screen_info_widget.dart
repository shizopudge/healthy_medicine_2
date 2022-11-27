import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/widgets/buttons/admin_add_entry_button.dart';
import 'package:healthy_medicine_2/widgets/buttons/entry_button.dart';
import 'package:healthy_medicine_2/widgets/rating_bar.dart';
import 'package:healthy_medicine_2/widgets/buttons/review_button.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';

class DoctorsScreenInfo extends ConsumerStatefulWidget {
  final Doctor doctor;
  const DoctorsScreenInfo({
    super.key,
    required this.doctor,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends ConsumerState<DoctorsScreenInfo> {
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
          ReviewButton(
            doctorId: widget.doctor.id,
            image: 'assets/images/reviews.png',
            isAddReview: false,
            isEditReview: false,
            isReviewsPage: true,
            text: 'Отзывы',
          ),
          user.isAdmin
              ? AdminAddEntryButton(
                  doctorId: widget.doctor.id,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
