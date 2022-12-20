import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/widgets/buttons/admin_add_entry_button.dart';
import 'package:healthy_medicine_2/widgets/buttons/admin_edit_doctor_buttond.dart';
import 'package:healthy_medicine_2/widgets/buttons/entry_button.dart';
import 'package:healthy_medicine_2/widgets/buttons/review_button.dart';
import 'package:routemaster/routemaster.dart';

class DoctorsAppBar extends ConsumerStatefulWidget {
  final String doctorId;
  const DoctorsAppBar({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorsAppBarState();
}

class _DoctorsAppBarState extends ConsumerState<DoctorsAppBar> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Routemaster.of(context).pop(),
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 24,
                  ),
                ),
              ),
              Row(
                children: [
                  user.isAdmin
                      ? AdminAddEntryButton(
                          doctorId: widget.doctorId,
                        )
                      : const SizedBox(),
                  EntryButton(doctorId: widget.doctorId),
                  ReviewButton(
                      doctorId: widget.doctorId,
                      image: 'assets/images/reviews.png',
                      isAddReview: false,
                      isEditReview: false,
                      isReviewsPage: true,
                      text: 'Отзывы'),
                ],
              ),
            ],
          ),
          user.isAdmin
              ? AdminEditDoctorButton(
                  doctorId: widget.doctorId,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
