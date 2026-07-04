import 'package:flutter/material.dart';
import '../models/cv_models.dart';

class CVPreviewScreen extends StatelessWidget {
  final CVData cvData;

  const CVPreviewScreen({super.key, required this.cvData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export/Print to PDF feature coming soon!')),
              );
            },
            tooltip: 'Print to PDF',
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Text(
                    cvData.personalInfo.fullName.toUpperCase(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    children: [
                      if (cvData.personalInfo.email.isNotEmpty) Text(cvData.personalInfo.email),
                      if (cvData.personalInfo.phone.isNotEmpty) Text(cvData.personalInfo.phone),
                      if (cvData.personalInfo.linkedin.isNotEmpty) Text(cvData.personalInfo.linkedin),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Professional Summary
                if (cvData.personalInfo.professionalSummary.isNotEmpty) ...[
                  _buildSectionTitle('PROFESSIONAL SUMMARY'),
                  Text(cvData.personalInfo.professionalSummary, style: const TextStyle(height: 1.5)),
                  const SizedBox(height: 24),
                ],

                // Experience
                if (cvData.experience.isNotEmpty) ...[
                  _buildSectionTitle('WORK EXPERIENCE'),
                  ...cvData.experience.where((e) => e.company.isNotEmpty).map((exp) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(exp.role, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('${exp.startDate} - ${exp.endDate}', style: const TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                        Text(exp.company, style: const TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(exp.description, style: const TextStyle(height: 1.4)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 8),
                ],

                // Education
                if (cvData.education.isNotEmpty) ...[
                  _buildSectionTitle('EDUCATION'),
                  ...cvData.education.where((e) => e.institution.isNotEmpty).map((edu) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(edu.institution, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('${edu.startDate} - ${edu.endDate}', style: const TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                        Text(edu.degree),
                      ],
                    ),
                  )),
                  const SizedBox(height: 12),
                ],

                // Skills
                if (cvData.skills.isNotEmpty) ...[
                  _buildSectionTitle('SKILLS'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: cvData.skills
                        .where((s) => s.name.isNotEmpty)
                        .map((s) => Text('${s.name}${s != cvData.skills.last ? ',' : ''}'))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.0),
        ),
        const Divider(color: Colors.black87, thickness: 1),
        const SizedBox(height: 12),
      ],
    );
  }
}
