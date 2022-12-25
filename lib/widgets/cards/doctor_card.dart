import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/widgets/rating_bar.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
import 'package:routemaster/routemaster.dart';

import '../../core/utils.dart';

class DoctorsCard extends ConsumerStatefulWidget {
  final Doctor doctor;

  const DoctorsCard({
    super.key,
    required this.doctor,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorsCardState();
}

class _DoctorsCardState extends ConsumerState<DoctorsCard> {
  double sum = 0;
  double avg = 0;
  String lastWord = '';
  List<dynamic> rating = [];

  getAvgRating() {
    for (var element in widget.doctor.rating) {
      sum = element + sum;
    }
    rating = widget.doctor.rating.toList();
    rating.removeAt(0);
    rating.isNotEmpty ? avg = sum / rating.length : null;
  }

  getLastWord() {
    int n = (widget.doctor.experience % 10).floor();
    if (widget.doctor.experience >= 11 && widget.doctor.experience <= 14) {
      lastWord = 'лет';
    } else if (n > 1 && n < 5) {
      lastWord = 'года';
    } else if (n == 1 &&
        !(widget.doctor.experience >= 11 && widget.doctor.experience <= 14)) {
      lastWord = 'год';
    } else {
      lastWord = 'лет';
    }
  }

  void deleteDoctor(Doctor doctor) {
    ref.read(doctorControllerProvider.notifier).deleteDoctor(doctor, context);
  }

  @override
  void initState() {
    super.initState();
    getAvgRating();
    getLastWord();
  }

  void navigateToDoctorScreen(BuildContext context) {
    Routemaster.of(context).push('/doctor/${widget.doctor.id}');
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.read(userProvider)!.isAdmin;
    if (isAdmin) {
      return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => deleteDoctor(widget.doctor),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(21),
              label: 'Удалить',
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Clipboard.setData(
                  ClipboardData(text: widget.doctor.id),
                );
                showSnackBar(context, 'Скопировано');
              },
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              icon: Icons.copy_rounded,
              borderRadius: BorderRadius.circular(12),
              label: 'Скопировать DocID',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: InkWell(
            onTap: () => navigateToDoctorScreen(context),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21),
              ),
              color: AppTheme.secondColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.doctor.image),
                            backgroundColor: Colors.white,
                            radius: 55,
                          ),
                          const Gap(5),
                          Text(
                            widget.doctor.spec,
                            style: AppTheme.dedicatedWhiteTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Опыт: ${widget.doctor.experience} $lastWord',
                                style: AppTheme.dedicatedWhiteTextStyle,
                              ),
                            ],
                          ),
                          rating.isNotEmpty
                              ? RatingBar(
                                  rating: avg,
                                  ratingCount: rating.length,
                                  size: 25,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (var i = 0; i < 5; i++)
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.grey,
                                        size: 21,
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        '0',
                                        style: AppTheme.dedicatedWhiteTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.doctor.lastName,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.dedicatedWhiteTextStyle
                                .copyWith(fontSize: 24),
                          ),
                          const Gap(2.5),
                          Text(
                            widget.doctor.firstName,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.dedicatedWhiteTextStyle
                                .copyWith(fontSize: 24),
                          ),
                          const Gap(2.5),
                          Text(
                            widget.doctor.patronymic,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.dedicatedWhiteTextStyle
                                .copyWith(fontSize: 24),
                          ),
                          const Gap(15),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${widget.doctor.serviceCost} руб.',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.comment,
                                color: Colors.white,
                                size: 26,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  widget.doctor.comments.length.toString(),
                                  style: AppTheme.dedicatedWhiteTextStyle
                                      .copyWith(fontSize: 21),
                                ),
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
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: InkWell(
          onTap: () => navigateToDoctorScreen(context),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21),
            ),
            color: AppTheme.secondColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.doctor.image),
                          backgroundColor: Colors.white,
                          radius: 55,
                        ),
                        const Gap(5),
                        Text(
                          widget.doctor.spec,
                          style: AppTheme.dedicatedWhiteTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Опыт: ${widget.doctor.experience} $lastWord',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                          ],
                        ),
                        rating.isNotEmpty
                            ? RatingBar(
                                rating: avg,
                                ratingCount: rating.length,
                                size: 25,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Colors.grey,
                                      size: 21,
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      '0',
                                      style: AppTheme.dedicatedWhiteTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.doctor.lastName,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.dedicatedWhiteTextStyle
                              .copyWith(fontSize: 24),
                        ),
                        const Gap(2.5),
                        Text(
                          widget.doctor.firstName,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.dedicatedWhiteTextStyle
                              .copyWith(fontSize: 24),
                        ),
                        const Gap(2.5),
                        Text(
                          widget.doctor.patronymic,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.dedicatedWhiteTextStyle
                              .copyWith(fontSize: 24),
                        ),
                        const Gap(15),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${widget.doctor.serviceCost} руб.',
                            style: AppTheme.dedicatedWhiteTextStyle,
                          ),
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.comment,
                              color: Colors.white,
                              size: 26,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                widget.doctor.comments.length.toString(),
                                style: AppTheme.dedicatedWhiteTextStyle
                                    .copyWith(fontSize: 21),
                              ),
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
        ),
      );
    }
  }
}
