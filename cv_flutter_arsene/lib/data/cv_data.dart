import 'package:flutter/material.dart';


class AppColors {
  static const Color primaryNavy = Color(0xFF14096B); // Bleu marine de l'en-tête et des titres
  static const Color sidebarBg = Color(0xFFEAEFF7);   // Bleu-gris clair de la colonne gauche
  static const Color pageBg = Color(0xFFFFFFFF);      // Fond blanc principal
  static const Color textDark = Color(0xFF1F2937);    // Texte principal sombre
  static const Color textMuted = Color(0xFF6B7280);   // Sous-titres et dates en gris
}


class EducationItem {
  final String title;
  final String period;
  final String institution;
  final String? description;

  const EducationItem({
    required this.title,
    required this.period,
    required this.institution,
    this.description,
  });
}

class ExperienceItem {
  final String title;
  final String period;
  final String company;
  final String? description;

  const ExperienceItem({
    required this.title,
    required this.period,
    required this.company,
    this.description,
  });
}

class FamilyMember {
  final String nom;
  final String lien;
  final String profession;
  final String photoPath;

  const FamilyMember({
    required this.nom,
    required this.lien,
    required this.profession,
    required this.photoPath,
  });
}

class ContactItem {
  final String title;
  final String value;
  final String actionUrl;
  final IconData icon;

  const ContactItem({
    required this.title,
    required this.value,
    required this.actionUrl,
    required this.icon,
  });
}


class CvData {
  // --- Identité & En-tête ---
  static const String fullName = 'IRAGI FIKIRI ARSENE';
  static const String jobTitle = 'Technicien Informaticien & Réseaux';
  static const String profilePhoto = 'assets/images/arsene.jpg';
  static const String email = 'arsenefikiri04@gmail.com';
  static const String phonesHeader = '+243 978113449 ; +243 858599720';
  static const String address = '39, Avenue Walikale, Himbi, Goma, Nord-Kivu RDC';

  // --- Profil ---
  static const String profileSummary =
      'Technicien informaticien avec une formation en systèmes informatiques, réseaux et télécommunications. '
      'J’ai acquis de l’expérience en assistance technique et en maintenance informatique. '
      'Je possède également des connaissances en programmation web, en bureautique et en design graphique. '
      'Je suis motivé, sérieux et prêt à mettre mes compétences en pratique tout en continuant à apprendre et à progresser professionnellement.';

  // --- Informations personnelles ---
  static const Map<String, String> personalInfos = {
    'Date de naissance :': '04 OCTOBRE 2004',
    'Lieu de naissance :': 'BUKAVU',
    'Sexe :': 'MASCULIN',
    'Nationalité :': 'CONGOLAISE',
    'État civil :': 'CÉLIBATAIRE',
  };

  // --- Études et formations ---
  static const List<EducationItem> educations = [
    EducationItem(
      title: 'Réseaux télécommunications',
      period: '2023 – 2026',
      institution: 'ISIG GOMA',
      description:
          'Études supérieures en systèmes informatiques (réseaux et télécommunications) niveau BAC+3 à l’Institut Supérieur d’Informatique et de Gestion (ISIG/GOMA).',
    ),
    EducationItem(
      title: 'Commerciale et gestion',
      period: '2018 – 2022',
      institution: 'C.S. MAMA SOPHIE HIMBI',
      description:
          'École secondaire au Complexe Scolaire MAMA SOPHIE HIMBI et obtention du diplôme d’État en commerciale et gestion.',
    ),
    EducationItem(
      title: 'Anglais niveau 1',
      period: '2023',
      institution: 'PYE',
    ),
    EducationItem(
      title: 'Prestation des cérémonies',
      period: '2023',
      institution: 'B11 EVENTS',
      description:
          'Formation en prestation de cérémonies des experts et professionnels chez B11 EVENTS.',
    ),
  ];

  // --- Expérience professionnelle ---
  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      title: 'Assistant technicien informaticien',
      period: '2026 – Ce jour',
      company: 'GODWINNER CORPORATION',
    ),
  ];

  // --- Compétences ---
  static const List<String> skills = [
    'Bureautique',
    'Assistance réseaux informatiques',
    'Programmation web (HTML, CSS, JS, PHP, WordPress)',
    'Maintenance des outils informatiques',
    'Microsoft Office (Word, Excel, PowerPoint)',
    'Conception maquettes visuelles et design graphique (Adobe Photoshop)',
  ];

  // --- Langues ---
  static const List<String> languages = [
    'Français : Très bien (lu et parlé)',
    'Anglais : Niveau 1',
    'Swahili : Bien (lu et parlé)',
  ];

  // --- Centres d'intérêt ---
  static const List<String> interests = [
    'Nouvelles technologies et administration réseau',
    'Design graphique et création visuelle',
    'Événementiel et animation de cérémonies',
  ];


  static const List<FamilyMember> familyMembers = [
    FamilyMember(
      nom: 'FIKIRI DEO',
      lien: 'Père',
      profession: 'Technicien',
      photoPath: 'assets/images/pere.jpg',
    ),
    FamilyMember(
      nom: 'IMMACULEE MIHIGO',
      lien: 'Mère',
      profession: 'Commerçante',
      photoPath: 'assets/images/mere.jpg',
    ),
    FamilyMember(
      nom: 'FIKIRI CHRIS',
      lien: 'Grand frère',
      profession: 'Ingénieur Civil',
      photoPath: 'assets/images/frere.jpg',
    ),
    FamilyMember(
      nom: 'KANEGA JESS',
      lien: 'Soeur',
      profession: 'Étudiante',
      photoPath: 'assets/images/soeur.jpg',
    ),
  ];

  
  static const List<ContactItem> contacts = [
    ContactItem(
      title: 'Téléphone Principal (Airtel)',
      value: '+243 978 113 449',
      actionUrl: 'tel:+243978113449',
      icon: Icons.phone,
    ),
    ContactItem(
      title: 'Téléphone Secondaire (Orange)',
      value: '+243 858 599 720',
      actionUrl: 'tel:+243858599720',
      icon: Icons.phone_android,
    ),
    ContactItem(
      title: 'Adresse E-mail',
      value: 'arsenefikiri04@gmail.com',
      actionUrl: 'mailto:arsenefikiri04@gmail.com?subject=Contact%20depuis%20votre%20CV%20Flutter',
      icon: Icons.email,
    ),
    ContactItem(
      title: 'Adresse Physique',
      value: '39, Avenue Walikale, Himbi, Goma, Nord-Kivu RDC',
      actionUrl: 'https://www.google.com/maps/search/?api=1&query=Himbi+Goma+RDC',
      icon: Icons.location_on,
    ),
    ContactItem(
      title: 'GitHub',
      value: 'github.com/arsenefikiri',
      actionUrl: 'https://github.com/arsenefikiri',
      icon: Icons.code,
    ),
    ContactItem(
      title: 'LinkedIn',
      value: 'linkedin.com/in/iragiarsene',
      actionUrl: 'https://www.linkedin.com',
      icon: Icons.work,
    ),
  ];
}