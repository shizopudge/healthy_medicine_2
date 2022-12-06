import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

class ServiceCard extends StatefulWidget {
  final String image;
  final String title;
  final int cost;
  const ServiceCard({
    super.key,
    required this.image,
    required this.title,
    required this.cost,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppTheme.indigoColor.shade400,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: AppTheme.dedicatedWhiteTextStyle,
            ),
            Image.network(
              widget.image,
              height: 50,
            ),
            Text(
              '${widget.cost} руб.',
              style: AppTheme.dedicatedWhiteTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
