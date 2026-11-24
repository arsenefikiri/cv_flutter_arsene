import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/cv_data.dart';
import '../services/api_service.dart';

// [MODIFIÉ TP2] Passage de StatelessWidget (données locales CvData.familyMembers)
// à StatefulWidget connecté à l'API REST /famille-membres
class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  // [AJOUT TP2] États dynamiques issus de la base de données via l'API
  List<ApiFamilyMember> _members = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  // [AJOUT TP2] Consultation de la liste via GET /famille-membres
  Future<void> _loadMembers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final members = await ApiService.getFamilyMembers();
      if (!mounted) return;
      setState(() {
        _members = members;
        _isLoading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage =
            'Erreur lors du chargement des membres. Vérifiez WampServer.';
        _isLoading = false;
      });
    }
  }

  // [AJOUT TP2] Suppression d'un membre via DELETE /famille-membres/{id}
  Future<void> _deleteMember(ApiFamilyMember member) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: Text(
          'Voulez-vous vraiment supprimer ${member.fullName} (${member.parente}) ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await ApiService.deleteFamilyMember(member.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Membre supprimé avec succès.')),
      );
      await _loadMembers();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Impossible de supprimer le membre.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // [AJOUT TP2] Formulaire modal d'ajout (POST) ou de modification (PUT / POST multipart)
  Future<void> _openMemberForm({ApiFamilyMember? existing}) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _FamilyMemberFormSheet(existing: existing),
    );

    if (saved == true) {
      await _loadMembers();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_isLoading) {
      bodyContent = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage != null) {
      bodyContent = Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off, size: 48, color: Colors.red.shade400),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textDark),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadMembers,
                icon: const Icon(Icons.refresh),
                label: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    } else if (_members.isEmpty) {
      bodyContent = RefreshIndicator(
        onRefresh: _loadMembers,
        child: ListView(
          children: const [
            SizedBox(height: 120),
            Center(
              child: Text(
                'Aucun membre de famille enregistré.\nAppuyez sur + pour en ajouter un.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted),
              ),
            ),
          ],
        ),
      );
    } else {
      bodyContent = RefreshIndicator(
        onRefresh: _loadMembers,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 84),
          itemCount: _members.length,
          itemBuilder: (context, index) {
            final member = _members[index];
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // [MODIFIÉ TP2] Affichage de l'image distante image_url retournée par l'API
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 68,
                        height: 68,
                        color: Colors.white,
                        child: (member.imageUrl != null &&
                                member.imageUrl!.isNotEmpty)
                            ? Image.network(
                                member.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 36,
                                    color: AppColors.primaryNavy,
                                  );
                                },
                              )
                            : const Icon(
                                Icons.person,
                                size: 36,
                                color: AppColors.primaryNavy,
                              ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.fullName,
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
                              member.parente,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Né(e) le ${member.dateNaissance} à ${member.lieuNaissance}',
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // [AJOUT TP2] Boutons Modifier et Supprimer sur chaque carte
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Modifier',
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: AppColors.primaryNavy,
                          ),
                          onPressed: () => _openMemberForm(existing: member),
                        ),
                        IconButton(
                          tooltip: 'Supprimer',
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red.shade700,
                          ),
                          onPressed: () => _deleteMember(member),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: bodyContent,
      // [AJOUT TP2] Bouton flottant pour ajouter un nouveau membre dans la base
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: Colors.white,
        onPressed: () => _openMemberForm(),
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
    );
  }
}

// [AJOUT TP2] Widget interne pour créer ou modifier un membre avec ou sans photo
class _FamilyMemberFormSheet extends StatefulWidget {
  final ApiFamilyMember? existing;

  const _FamilyMemberFormSheet({this.existing});

  @override
  State<_FamilyMemberFormSheet> createState() => _FamilyMemberFormSheetState();
}

class _FamilyMemberFormSheetState extends State<_FamilyMemberFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late final TextEditingController _nomController;
  late final TextEditingController _postnomController;
  late final TextEditingController _prenomController;
  late final TextEditingController _lieuController;
  late final TextEditingController _dateController;
  late final TextEditingController _parenteController;

  XFile? _pickedImage;
  bool _isSaving = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nomController = TextEditingController(text: e?.nom ?? '');
    _postnomController = TextEditingController(text: e?.postnom ?? '');
    _prenomController = TextEditingController(text: e?.prenom ?? '');
    _lieuController = TextEditingController(text: e?.lieuNaissance ?? '');
    _dateController = TextEditingController(text: e?.dateNaissance ?? '');
    _parenteController = TextEditingController(text: e?.parente ?? '');
  }

  @override
  void dispose() {
    _nomController.dispose();
    _postnomController.dispose();
    _prenomController.dispose();
    _lieuController.dispose();
    _dateController.dispose();
    _parenteController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file != null) {
      setState(() => _pickedImage = file);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = DateTime.tryParse(_dateController.text) ?? DateTime(1995);
    final selected = await showDatePicker(
      context: context,
      initialDate: initial.isAfter(now) ? now : initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (selected != null) {
      final yyyy = selected.year.toString().padLeft(4, '0');
      final mm = selected.month.toString().padLeft(2, '0');
      final dd = selected.day.toString().padLeft(2, '0');
      _dateController.text = '$yyyy-$mm-$dd';
    }
  }

  Future<void> _save() async {
    setState(() => _errorText = null);
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      if (widget.existing == null) {
        await ApiService.createFamilyMember(
          nom: _nomController.text,
          postnom: _postnomController.text,
          prenom: _prenomController.text,
          lieuNaissance: _lieuController.text,
          dateNaissance: _dateController.text,
          parente: _parenteController.text,
          imageFile: _pickedImage,
        );
      } else {
        await ApiService.updateFamilyMember(
          id: widget.existing!.id,
          nom: _nomController.text,
          postnom: _postnomController.text,
          prenom: _prenomController.text,
          lieuNaissance: _lieuController.text,
          dateNaissance: _dateController.text,
          parente: _parenteController.text,
          newImageFile: _pickedImage,
        );
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorText = e.message;
        _isSaving = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorText = 'Erreur lors de l\'enregistrement.';
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditing ? 'Modifier un membre' : 'Ajouter un membre',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 14),
              if (_errorText != null) ...[
                Text(
                  _errorText!,
                  style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                ),
                const SizedBox(height: 10),
              ],
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _postnomController,
                decoration: const InputDecoration(
                  labelText: 'Postnom *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(
                  labelText: 'Prénom *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _lieuController,
                decoration: const InputDecoration(
                  labelText: 'Lieu de naissance *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: _pickDate,
                decoration: const InputDecoration(
                  labelText: 'Date de naissance (AAAA-MM-JJ) *',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _parenteController,
                decoration: const InputDecoration(
                  labelText: 'Lien de parenté (ex: Père, Mère, Frère) *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _isSaving ? null : _pickImage,
                icon: const Icon(Icons.photo_library_outlined),
                label: Text(
                  _pickedImage != null
                      ? 'Photo sélectionnée : ${_pickedImage!.name}'
                      : (isEditing
                          ? 'Changer la photo (facultatif)'
                          : 'Choisir une photo (facultatif)'),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                    : Text(isEditing ? 'Enregistrer les modifications' : 'Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
