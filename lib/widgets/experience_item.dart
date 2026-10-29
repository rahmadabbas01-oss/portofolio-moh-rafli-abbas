import 'package:flutter/material.dart';
import '../constants.dart';
import 'common_widgets.dart';

class ExperienceDetailItem extends StatelessWidget {
  final String title;
  final String company;
  final String period;
  final String location;
  final String description;
  final List<String>? skills;

  const ExperienceDetailItem({
    super.key,
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.description,
    this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: linkedinChipBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.business_center_outlined, color: linkedinBlue, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: linkedinDarkText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                company,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: linkedinDarkText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$period · $location',
                style: const TextStyle(color: linkedinMutedText, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: linkedinDarkText, height: 1.5, fontSize: 13),
              ),
              if (skills != null && skills!.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: skills!.map((s) => MiniTag(text: 'Keterampilan: $s')).toList(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}