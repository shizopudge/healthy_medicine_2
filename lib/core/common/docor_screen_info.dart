import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/core/common/rating_bar.dart';
import 'package:healthy_medicine_2/models/doctor_model.dart';

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

  getAvgRating() {
    for (var element in widget.doctor.rating) {
      sum = element + sum;
    }
    avg = sum / widget.doctor.rating.length;
    print(avg);
  }

  @override
  void initState() {
    super.initState();
    getAvgRating();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              RatingBar(rating: avg, ratingCount: widget.doctor.rating.length),
        ),
        Text(
          'Маленький текст с информацией о докторе.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
