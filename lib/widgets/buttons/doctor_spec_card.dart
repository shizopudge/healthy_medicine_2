import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String docspec;
  final String spec;
  const CategoryCard({
    super.key,
    required this.image,
    required this.docspec,
    required this.spec,
  });

  void navigateToChoiceClinic(BuildContext context) {
    Routemaster.of(context).push('/clinics/$spec');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToChoiceClinic(context),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
        ),
        child: Container(
          width: 110,
          padding: const EdgeInsets.all(
            12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Constants.secondColor,
          ),
          child: Column(
            children: [
              Image.asset(
                image,
                height: 40,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                docspec,
                style: const TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
