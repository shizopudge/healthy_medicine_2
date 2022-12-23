import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/widgets/buttons/admin_add_entry_button.dart';
import 'package:healthy_medicine_2/widgets/buttons/admin_edit_doctor_buttond.dart';
import 'package:healthy_medicine_2/widgets/buttons/entry_button.dart';
import 'package:healthy_medicine_2/widgets/buttons/review_button.dart';

class DoctorDoctorsAppBar extends ConsumerStatefulWidget {
  final String doctorId;
  const DoctorDoctorsAppBar({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorDoctorsAppBarState();
}

class _DoctorDoctorsAppBarState extends ConsumerState<DoctorDoctorsAppBar> {
  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            AdminAddEntryButton(
              doctorId: widget.doctorId,
            ),
            EntryButton(doctorId: widget.doctorId),
            ReviewButton(
                doctorId: widget.doctorId,
                image: 'assets/images/reviews.png',
                isAddReview: false,
                isEditReview: false,
                isReviewsPage: true,
                text: 'Отзывы'),
            AdminEditDoctorButton(
              doctorId: widget.doctorId,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => displayEndDrawer(context),
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(32),
                    gradient: AppTheme.gradientIndigoToRed,
                  ),
                  child: const Icon(
                    Icons.menu,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
