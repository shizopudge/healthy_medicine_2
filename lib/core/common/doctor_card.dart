import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/core/common/rating_bar.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/models/doctor_model.dart';
import 'package:routemaster/routemaster.dart';

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
  @override
  void initState() {
    super.initState();
    for (var element in widget.doctor.rating) {
      sum = element + sum;
    }
    avg = sum / widget.doctor.rating.length;
  }

  void navigateToDoctorScreen(BuildContext context) {
    Routemaster.of(context).push('/doctor/${widget.doctor.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => navigateToDoctorScreen(context),
        child: Card(
          color: Constants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.doctor.image),
                          backgroundColor: Colors.white,
                          radius: 60,
                        ),
                        const Gap(5),
                        Text(
                          widget.doctor.spec,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '????????: ${widget.doctor.experience} ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            // ???????????? ?????????????? ????????))) ?????????? ???? ????????????????
                            widget.doctor.experience > 1 &&
                                    widget.doctor.experience < 5
                                ? const Text(
                                    '????????',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                : widget.doctor.experience == 1
                                    ? const Text(
                                        '??????',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      )
                                    : const Text(
                                        '??????',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                          ],
                        ),
                        const Gap(5),
                        RatingBar(
                            rating: avg,
                            ratingCount: widget.doctor.rating.length),
                      ],
                    ),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctor.lastName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            const Gap(2.5),
                            Text(
                              widget.doctor.firstName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            const Gap(2.5),
                            Text(
                              widget.doctor.patronymic,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            '${widget.doctor.serviceCost} ??????.',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Icon(
                              Icons.comment,
                              color: Colors.white,
                              size: 22,
                            ),
                            Text(
                              widget.doctor.reviewsCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
