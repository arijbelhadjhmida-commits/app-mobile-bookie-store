import 'package:flutter/material.dart';
import 'package:bookie_store/theme/app_theme.dart';

class BookRequestScreen extends StatefulWidget {
  final String prefillTitle;

  const BookRequestScreen({super.key, this.prefillTitle = ''});

  @override
  State<BookRequestScreen> createState() => _BookRequestScreenState();
}

class _BookRequestScreenState extends State<BookRequestScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  final _authorController = TextEditingController();
  final _categoryController = TextEditingController();
  final _messageController = TextEditingController();
  final _emailController = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  bool _submitted = false;

  final List<String> _categories = [
    'Développement personnel',
    'Productivité',
    'Finance',
    'Roman',
    'Psychologie',
    'Science & Tech',
    'Histoire',
    'Philosophie',
    'Biographie',
    'Jeunesse',
    'Autre',
  ];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.prefillTitle);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _titleController.dispose();
    _authorController.dispose();
    _categoryController.dispose();
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);
    }
  }

  InputDecoration _fieldDecoration(
    String label,
    IconData icon, {
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppTheme.gold, size: 20),
      labelStyle: const TextStyle(color: AppTheme.muted, fontSize: 14),
      hintStyle: TextStyle(
        color: AppTheme.muted.withOpacity(0.6),
        fontSize: 13,
      ),
      filled: true,
      fillColor: AppTheme.cream,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppTheme.creamDark, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.gold, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.terracotta, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.terracotta, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: CustomScrollView(
        slivers: [
          // Custom AppBar
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppTheme.ink,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppTheme.inkGradient),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.gold.withOpacity(0.08),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: -30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.gold.withOpacity(0.06),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.gold.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.gold.withOpacity(0.4),
                              ),
                            ),
                            child: const Text(
                              '📬  Demande de livre',
                              style: TextStyle(
                                color: AppTheme.goldLight,
                                fontSize: 11,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Introuvable ?\nDemandez-le !',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Georgia',
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _submitted ? _buildSuccessState() : _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.gold.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Text('💡', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Nous traitons les demandes sous 48h et vous contactons par email dès que le livre est disponible.',
                          style: TextStyle(
                            color: AppTheme.ink.withOpacity(0.75),
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                _sectionLabel('📚 Informations du livre'),
                const SizedBox(height: 14),

                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: _fieldDecoration(
                    'Titre du livre *',
                    Icons.menu_book_rounded,
                    hint: 'Ex: Le Petit Prince',
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Champ requis' : null,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 14),

                // Author
                TextFormField(
                  controller: _authorController,
                  decoration: _fieldDecoration(
                    'Auteur (optionnel)',
                    Icons.person_outline_rounded,
                    hint: 'Ex: Antoine de Saint-Exupéry',
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 14),

                // Category dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: _fieldDecoration(
                    'Catégorie (optionnel)',
                    Icons.category_outlined,
                  ),
                  dropdownColor: AppTheme.cream,
                  borderRadius: BorderRadius.circular(14),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.gold,
                  ),
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(
                            '${AppTheme.emojiFor(cat)}  $cat',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.ink,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                ),
                const SizedBox(height: 28),

                _sectionLabel('✉️ Vos coordonnées'),
                const SizedBox(height: 14),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: _fieldDecoration(
                    'Email *',
                    Icons.alternate_email_rounded,
                    hint: 'votre@email.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Champ requis';
                    if (!v.contains('@')) return 'Email invalide';
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Message
                TextFormField(
                  controller: _messageController,
                  decoration: _fieldDecoration(
                    'Message (optionnel)',
                    Icons.chat_bubble_outline_rounded,
                    hint:
                        'Pourquoi souhaitez-vous ce livre ? Toute info supplémentaire...',
                  ).copyWith(alignLabelWithHint: true),
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 32),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD4A853), Color(0xFFE8C070)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.gold.withOpacity(0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _submitRequest,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send_rounded,
                            color: AppTheme.ink,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Envoyer ma demande',
                            style: TextStyle(
                              color: AppTheme.ink,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppTheme.ink,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildSuccessState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Success icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFD4A853), Color(0xFFE8C070)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gold.withOpacity(0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 52,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Demande envoyée !',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppTheme.ink,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Merci pour votre demande.\nNous vous contacterons à ${_emailController.text} dès que le livre "${_titleController.text}" sera disponible.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 40),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.ink,
              side: const BorderSide(color: AppTheme.ink, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            label: const Text(
              'Retour à la boutique',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
