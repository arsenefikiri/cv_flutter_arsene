import 'package:flutter/material.dart';
import '../data/cv_data.dart';

class CvHomePage extends StatelessWidget {
  const CvHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. EN-TÊTE BLEU MARINE
          Container(
            color: AppColors.primaryNavy,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 105,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Image.asset(
                    CvData.profilePhoto,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 50, color: AppColors.primaryNavy);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CvData.fullName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        CvData.jobTitle,
                        style: TextStyle(
                          color: Color(0xFFD1D5DB),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        CvData.email,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 2),
                      Text(
                        CvData.phonesHeader,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 2),
                      Text(
                        CvData.address,
                        style: TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. CORPS PRINCIPAL BLANC (Profil, Études, Expérience)
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle(title: 'PROFIL'),
                const SizedBox(height: 8),
                const Text(
                  CvData.profileSummary,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.45,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 22),

                const _SectionTitle(title: 'ÉTUDES ET FORMATIONS'),
                const SizedBox(height: 12),
                ...CvData.educations.map(
                  (edu) => _TimelineItem(
                    title: edu.title,
                    period: edu.period,
                    institution: edu.institution,
                    description: edu.description,
                  ),
                ),
                const SizedBox(height: 14),

                const _SectionTitle(title: 'EXPÉRIENCE PROFESSIONNELLE'),
                const SizedBox(height: 12),
                ...CvData.experiences.map(
                  (exp) => _TimelineItem(
                    title: exp.title,
                    period: exp.period,
                    institution: exp.company,
                    description: exp.description,
                  ),
                ),
              ],
            ),
          ),

          // 3. BLOC BLEU-GRIS CLAIR (Infos perso, Compétences, Langues, Intérêts)
          Container(
            color: AppColors.sidebarBg,
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle(title: 'INFORMATIONS PERSONNELLES'),
                const SizedBox(height: 12),
                ...CvData.personalInfos.entries.map(
                  (entry) => _PersonalInfoRow(label: entry.key, value: entry.value),
                ),

                const SizedBox(height: 20),
                const _SectionTitle(title: 'COMPÉTENCES'),
                const SizedBox(height: 10),
                ...CvData.skills.map((skill) => _BulletPoint(text: skill)),

                const SizedBox(height: 20),
                const _SectionTitle(title: 'LANGUES'),
                const SizedBox(height: 10),
                ...CvData.languages.map((lang) => _BulletPoint(text: lang)),

                const SizedBox(height: 20),
                const _SectionTitle(title: 'CENTRES D’INTÉRÊT'),
                const SizedBox(height: 10),
                ...CvData.interests.map((interest) => _BulletPoint(text: interest)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 2.5,
          color: AppColors.primaryNavy,
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String period;
  final String institution;
  final String? description;

  const _TimelineItem({
    required this.title,
    required this.period,
    required this.institution,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                period,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            institution,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: AppColors.textDark,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PersonalInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _PersonalInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNavy,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.35,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}