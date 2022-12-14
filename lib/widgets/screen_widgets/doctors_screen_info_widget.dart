import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/widgets/cards/text_info_card.dart';
import 'package:healthy_medicine_2/widgets/rating_bar.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';

final isPicFullScreenProvider = StateProvider.autoDispose<bool>((ref) => false);

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
  }

  @override
  void initState() {
    super.initState();
    getAvgRating();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final isPicFullScreen = ref.watch(isPicFullScreenProvider);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: () => ref.read(isPicFullScreenProvider.notifier).state =
              !isPicFullScreen,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.doctor.image),
                fit: BoxFit.cover,
                opacity: .55,
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade400,
                  BlendMode.colorBurn,
                ),
              ),
            ),
          ),
        ),
        isPicFullScreen
            ? GestureDetector(
                onTap: () =>
                    ref.read(isPicFullScreenProvider.notifier).state = false,
                child: Container(
                  width: double.infinity,
                  height: height * .1,
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    color: Colors.grey.shade200,
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: height * .5,
                padding: const EdgeInsets.only(
                  top: 12,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextInfoCard(
                          text:
                              'Д-р. ${widget.doctor.firstName} ${widget.doctor.lastName}',
                        ),
                        TextInfoCard(
                          text: widget.doctor.spec,
                        ),
                        rating.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RatingBar(
                                      rating: avg,
                                      ratingCount: rating.length,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (var i = 0; i < 5; i++)
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Colors.grey,
                                            size: 50,
                                          ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            '(0)',
                                            style: AppTheme.titleTextStyle
                                                .copyWith(
                                              fontSize: 28,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Опыт работы: ${widget.doctor.experience} ',
                                    style: AppTheme.titleTextStyle.copyWith(
                                      fontSize: 28,
                                    ),
                                  ),
                                  // защита слабого типа))) лучше бы поменять
                                  widget.doctor.experience > 1 &&
                                          widget.doctor.experience < 5
                                      ? Text(
                                          'года',
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              AppTheme.titleTextStyle.copyWith(
                                            fontSize: 21,
                                          ),
                                        )
                                      : widget.doctor.experience == 1
                                          ? Expanded(
                                              child: Text(
                                                'год',
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTheme.titleTextStyle
                                                    .copyWith(
                                                  fontSize: 21,
                                                ),
                                              ),
                                            )
                                          : Expanded(
                                              child: Text(
                                                'лет',
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTheme.titleTextStyle
                                                    .copyWith(
                                                  fontSize: 21,
                                                ),
                                              ),
                                            ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Маленький текст с информацией о докторе.',
                                textAlign: TextAlign.center,
                                style: AppTheme.titleTextStyle.copyWith(
                                  fontSize: 21,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${widget.doctor.serviceCost} руб.',
                                style: AppTheme.titleTextStyle.copyWith(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
