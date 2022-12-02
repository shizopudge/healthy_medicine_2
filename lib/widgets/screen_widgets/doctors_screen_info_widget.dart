import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/widgets/rating_bar.dart';
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.doctor.image),
          fit: BoxFit.cover,
          opacity: .55,
          colorFilter: ColorFilter.mode(
            Colors.grey.shade300,
            BlendMode.colorBurn,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Text(
              'Д-р. ${widget.doctor.firstName} ${widget.doctor.lastName}',
              textAlign: TextAlign.center,
              style: AppTheme.titleTextStyle.copyWith(
                fontSize: 28,
              ),
            ),
          ),
          const Gap(10),
          Text(
            widget.doctor.spec,
            style: AppTheme.titleTextStyle.copyWith(
              fontSize: 28,
            ),
          ),
          rating.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar(
                    rating: avg,
                    ratingCount: rating.length,
                    size: 50,
                  ),
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
                          size: 50,
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '(0)',
                          style: AppTheme.titleTextStyle.copyWith(
                            fontSize: 28,
                          ),
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
                style: AppTheme.titleTextStyle.copyWith(
                  fontSize: 28,
                ),
              ),
              // защита слабого типа))) лучше бы поменять
              widget.doctor.experience > 1 && widget.doctor.experience < 5
                  ? Text(
                      'года',
                      style: AppTheme.titleTextStyle.copyWith(
                        fontSize: 28,
                      ),
                    )
                  : widget.doctor.experience == 1
                      ? Text(
                          'год',
                          style: AppTheme.titleTextStyle.copyWith(
                            fontSize: 28,
                          ),
                        )
                      : Text(
                          'лет',
                          style: AppTheme.titleTextStyle.copyWith(
                            fontSize: 28,
                          ),
                        ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Маленький текст с информацией о докторе.',
              textAlign: TextAlign.center,
              style: AppTheme.titleTextStyle.copyWith(
                fontSize: 21,
                color: Colors.indigoAccent.shade200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
