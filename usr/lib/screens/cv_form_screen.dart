import 'package:flutter/material.dart';
import '../models/cv_models.dart';
import 'cv_preview_screen.dart';

class CVFormScreen extends StatefulWidget {
  const CVFormScreen({super.key});

  @override
  State<CVFormScreen> createState() => _CVFormScreenState();
}

class _CVFormScreenState extends State<CVFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Personal Info
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _summaryController = TextEditingController();

  // Dynamic Lists
  final List<WorkExperience> _experiences = [];
  final List<Education> _educations = [];
  final List<Skill> _skills = [];

  void _addExperience() {
    setState(() {
      _experiences.add(WorkExperience(company: '', role: '', startDate: '', endDate: '', description: ''));
    });
  }

  void _addEducation() {
    setState(() {
      _educations.add(Education(institution: '', degree: '', startDate: '', endDate: ''));
    });
  }

  void _addSkill() {
    setState(() {
      _skills.add(Skill(name: '', level: 'Beginner'));
    });
  }

  void _generateCV() {
    if (_formKey.currentState!.validate()) {
      final cvData = CVData(
        personalInfo: PersonalInfo(
          fullName: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          linkedin: _linkedinController.text,
          professionalSummary: _summaryController.text,
        ),
        experience: _experiences,
        education: _educations,
        skills: _skills,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CVPreviewScreen(cvData: cvData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATS CV Builder'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Personal Information'),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: _linkedinController,
                decoration: const InputDecoration(labelText: 'LinkedIn URL'),
              ),
              TextFormField(
                controller: _summaryController,
                decoration: const InputDecoration(labelText: 'Professional Summary'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('Work Experience'),
              ..._experiences.asMap().entries.map((entry) {
                int index = entry.key;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _experiences[index].company,
                          decoration: const InputDecoration(labelText: 'Company'),
                          onChanged: (val) => _experiences[index].company = val,
                        ),
                        TextFormField(
                          initialValue: _experiences[index].role,
                          decoration: const InputDecoration(labelText: 'Role'),
                          onChanged: (val) => _experiences[index].role = val,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: _experiences[index].startDate,
                                decoration: const InputDecoration(labelText: 'Start Date'),
                                onChanged: (val) => _experiences[index].startDate = val,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                initialValue: _experiences[index].endDate,
                                decoration: const InputDecoration(labelText: 'End Date'),
                                onChanged: (val) => _experiences[index].endDate = val,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          initialValue: _experiences[index].description,
                          decoration: const InputDecoration(labelText: 'Description (Bullet points)'),
                          maxLines: 3,
                          onChanged: (val) => _experiences[index].description = val,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() => _experiences.removeAt(index));
                            },
                            child: const Text('Remove', style: TextStyle(color: Colors.red)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              ElevatedButton.icon(
                onPressed: _addExperience,
                icon: const Icon(Icons.add),
                label: const Text('Add Experience'),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('Education'),
              ..._educations.asMap().entries.map((entry) {
                int index = entry.key;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _educations[index].institution,
                          decoration: const InputDecoration(labelText: 'Institution'),
                          onChanged: (val) => _educations[index].institution = val,
                        ),
                        TextFormField(
                          initialValue: _educations[index].degree,
                          decoration: const InputDecoration(labelText: 'Degree'),
                          onChanged: (val) => _educations[index].degree = val,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: _educations[index].startDate,
                                decoration: const InputDecoration(labelText: 'Start Date'),
                                onChanged: (val) => _educations[index].startDate = val,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                initialValue: _educations[index].endDate,
                                decoration: const InputDecoration(labelText: 'End Date'),
                                onChanged: (val) => _educations[index].endDate = val,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() => _educations.removeAt(index));
                            },
                            child: const Text('Remove', style: TextStyle(color: Colors.red)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              ElevatedButton.icon(
                onPressed: _addEducation,
                icon: const Icon(Icons.add),
                label: const Text('Add Education'),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('Skills'),
              Wrap(
                spacing: 8,
                children: _skills.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Chip(
                    label: SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Skill',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onChanged: (val) => _skills[index].name = val,
                      ),
                    ),
                    onDeleted: () {
                      setState(() => _skills.removeAt(index));
                    },
                  );
                }).toList(),
              ),
              ElevatedButton.icon(
                onPressed: _addSkill,
                icon: const Icon(Icons.add),
                label: const Text('Add Skill'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _generateCV,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Generate ATS CV', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _linkedinController.dispose();
    _summaryController.dispose();
    super.dispose();
  }
}
