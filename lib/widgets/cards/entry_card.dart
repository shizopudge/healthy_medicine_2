import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/models/entry_model.dart';
import 'package:routemaster/routemaster.dart';

class EntryCard extends ConsumerWidget {
  final EntryModel entry;
  const EntryCard({
    super.key,
    required this.entry,
  });

  void navigateToDoctorScreen(BuildContext context) {
    Routemaster.of(context).push('/doctor/${entry.doctorId}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Constants.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () => navigateToDoctorScreen(context),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(entry.doctorImage),
                      backgroundColor: Colors.white,
                      radius: 55,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Д-р. ${entry.doctorFirstName}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        entry.doctorSpec,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          const Text(
                            'Дата: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          const Text(
                            'Время: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${entry.time.hour}:${entry.time.minute}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const Gap(5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Цена: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${entry.serviceCost} руб.',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          //   padding: const EdgeInsets.all(1.5),
                          //   child: Center(
                          //     child: Text(
                          //       '${entry.serviceCost} руб.',
                          //       style: const TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: ref.watch(getClinicByIdProvider(entry.clinicId)).when(
                        data: (clinic) {
                          return Row(
                            children: [
                              Text(
                                '${clinic.city}, ',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  clinic.address,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        error: ((error, stackTrace) => ErrorText(
                              error: error.toString(),
                            )),
                        loading: () => const Loader(),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
