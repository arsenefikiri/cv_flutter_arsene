import 'package:flutter/material.dart';
import '../data/cv_data.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final membres = CvData.familyMembers;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: membres.length,
      itemBuilder: (context, index) {
        final membre = membres[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12.0),
          color: AppColors.sidebarBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: AppColors.primaryNavy.withValues(alpha: 0.15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Photo du membre de la famille
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 68,
                    height: 68,
                    color: Colors.white,
                    child: Image.asset(
                      membre.photoPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 36,
                          color: AppColors.primaryNavy,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Informations du membre
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        membre.nom,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryNavy,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          membre.lien,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Profession : ${membre.profession}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
