import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/utils.dart';
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

class _DoctorInfoState extends ConsumerState<DoctorsScreenInfo>
    with TickerProviderStateMixin {
  double sum = 0;
  double avg = 0;
  String lastWord = '';
  List<dynamic> rating = [];
  late TextEditingController docIdController;

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

  @override
  void initState() {
    super.initState();
    getAvgRating();
    getLastWord();
    docIdController = TextEditingController(text: widget.doctor.id);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isPicFullScreen = ref.watch(isPicFullScreenProvider);
    final isAdmin = ref.read(userProvider)!.isAdmin;
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
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          reverseDuration: const Duration(seconds: 2),
          transitionBuilder: (child, animation) {
            return Transform.translate(
              offset:
                  isPicFullScreen ? Offset(0, height * .3) : const Offset(0, 0),
              child: child,
            );
          },
          child: GestureDetector(
            onTap: isPicFullScreen
                ? () => ref.read(isPicFullScreenProvider.notifier).state = false
                : () {},
            child: Container(
              key: const ValueKey('second'),
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
                      isAdmin
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade200,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Align(
                                  child: TextFormField(
                                    readOnly: true,
                                    toolbarOptions: const ToolbarOptions(
                                      copy: true,
                                      cut: false,
                                      paste: false,
                                      selectAll: true,
                                    ),
                                    controller: docIdController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixText: 'DocID: ',
                                      prefixStyle:
                                          AppTheme.dedicatedIndigoTextStyle,
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                                text: docIdController.text),
                                          );
                                          showSnackBar(context, 'Скопировано');
                                        },
                                        child: const Icon(
                                          Icons.copy_rounded,
                                          size: 32,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                    ),
                                    style: AppTheme.dedicatedIndigoTextStyle,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
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
                                          style:
                                              AppTheme.titleTextStyle.copyWith(
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
                            child: Text(
                              'Опыт работы: ${widget.doctor.experience} $lastWord',
                              textAlign: TextAlign.center,
                              style: AppTheme.titleTextStyle.copyWith(
                                fontSize: 28,
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
          ),
        ),
      ],
    );
  }
}
