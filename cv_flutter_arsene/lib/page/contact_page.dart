import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/cv_data.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _lancerAction(BuildContext context, String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible d\'ouvrir : $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final contacts = CvData.contacts;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Me Contacter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Appuyez sur une coordonnée pour lancer un appel, envoyer un e-mail ou ouvrir un profil.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ...contacts.map(
            (contact) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10.0),
              color: AppColors.sidebarBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: AppColors.primaryNavy.withValues(alpha: 0.15),
                ),
              ),
              child: ListTile(
                onTap: () => _lancerAction(context, contact.actionUrl),
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  child: Icon(contact.icon, size: 20),
                ),
                title: Text(
                  contact.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                  ),
                ),
                subtitle: Text(
                  contact.value,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
