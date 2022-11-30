import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/widgets/app_bars/main_appbar.dart';
import 'package:healthy_medicine_2/widgets/app_bars/top_appbar.dart';
import 'package:healthy_medicine_2/widgets/lists/clinics.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              TopAppBar(
                  onSearchTap: () {},
                  title: 'Выберите удобную для себя клинику'),
              Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: cityValue,
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppTheme.indigoColor,
                    size: 28,
                  ),
                  elevation: 0,
                  style: AppTheme.titleTextStyle,
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
