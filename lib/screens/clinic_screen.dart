import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/common/clinic_choice_menu.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

const List<String> cities = [
  'Москва',
  'Уфа',
  'Санкт-Петербург',
  'Казань',
];

class ClinicScreen extends ConsumerStatefulWidget {
  final String spec;
  const ClinicScreen({
    super.key,
    required this.spec,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClinicScreenState();
}

class _ClinicScreenState extends ConsumerState<ClinicScreen> {
  String cityValue = '';

  @override
  void initState() {
    super.initState();
    cityValue = ref.read(userProvider)!.city;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bg,
      appBar: AppBar(
        backgroundColor: Constants.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Routemaster.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.textColor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: cityValue,
                  icon: const RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Constants.textColor,
                    ),
                  ),
                  dropdownColor: Constants.primaryColor,
                  elevation: 16,
                  style: const TextStyle(
                    color: Constants.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  underline: Container(
                    height: 2,
                    color: Constants.textColor,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      cityValue = value!;
                    });
                  },
                  items: cities.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Выберите удобную для себя клинику',
                  style: TextStyle(
                    color: Constants.textColor,
                    fontSize: 36,
                  ),
                ),
              ),
              Expanded(
                  child: ClinicMenu(
                spec: widget.spec,
                city: cityValue,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
