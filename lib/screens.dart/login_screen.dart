import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final _nomCtrl = TextEditingController();
  final _prenomCtrl = TextEditingController();
  final _emailInscCtrl = TextEditingController();
  final _passInscCtrl = TextEditingController();
  final _emailConnCtrl = TextEditingController();
  final _passConnCtrl = TextEditingController();

  bool _obscureInsc = true;
  bool _obscureConn = true;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animCtrl.dispose();
    for (final c in [
      _nomCtrl,
      _prenomCtrl,
      _emailInscCtrl,
      _passInscCtrl,
      _emailConnCtrl,
      _passConnCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _go() => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const HomeScreen()),
  );

  void _handleConnexion() {
    if (_emailConnCtrl.text.isEmpty || _passConnCtrl.text.isEmpty) {
      _showError('Veuillez remplir tous les champs.');
      return;
    }
    _go();
  }

  void _handleInscription() {
    if (_nomCtrl.text.isEmpty ||
        _prenomCtrl.text.isEmpty ||
        _emailInscCtrl.text.isEmpty ||
        _passInscCtrl.text.isEmpty) {
      _showError('Veuillez remplir tous les champs.');
      return;
    }
    _go();
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppTheme.terracotta,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ignore: unused_element_parameter
  InputDecoration _dec(String label, IconData icon, {bool password = false}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppTheme.gold, size: 20),
      labelStyle: const TextStyle(color: AppTheme.muted, fontSize: 14),
      filled: true,
      fillColor: AppTheme.creamDark,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          // ignore: deprecated_member_use
          color: AppTheme.creamDark.withOpacity(0.0),
          width: 0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.gold, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: Stack(
        children: [
          // Decorative background
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // ignore: deprecated_member_use
                color: AppTheme.gold.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // ignore: deprecated_member_use
                color: AppTheme.ink.withOpacity(0.05),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    children: [
                      const SizedBox(height: 48),

                      // Logo area
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1C1917), Color(0xFF3B2F2F)],
                          ),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: AppTheme.elevatedShadow,
                        ),
                        child: const Center(
                          child: Text('📚', style: TextStyle(fontSize: 36)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Bookie Store',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ink,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Votre librairie en ligne',
                        style: TextStyle(
                          color: AppTheme.muted,
                          fontSize: 14,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: AppTheme.elevatedShadow,
                        ),
                        child: Column(
                          children: [
                            // Tab bar
                            Container(
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppTheme.creamDark,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1C1917),
                                      Color(0xFF3B2F2F),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: Colors.white,
                                unselectedLabelColor: AppTheme.muted,
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                dividerColor: Colors.transparent,
                                tabs: const [
                                  Tab(text: 'Connexion'),
                                  Tab(text: 'Inscription'),
                                ],
                              ),
                            ),

                            // Tab content
                            SizedBox(
                              height: 310,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // ─ Connexion ─
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      20,
                                      16,
                                      20,
                                      20,
                                    ),
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _emailConnCtrl,
                                          decoration: _dec(
                                            'Email',
                                            Icons.alternate_email_rounded,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        const SizedBox(height: 14),
                                        TextField(
                                          controller: _passConnCtrl,
                                          obscureText: _obscureConn,
                                          decoration:
                                              _dec(
                                                'Mot de passe',
                                                Icons.lock_outline_rounded,
                                              ).copyWith(
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _obscureConn
                                                        ? Icons
                                                              .visibility_off_outlined
                                                        : Icons
                                                              .visibility_outlined,
                                                    color: AppTheme.muted,
                                                    size: 20,
                                                  ),
                                                  onPressed: () => setState(
                                                    () => _obscureConn =
                                                        !_obscureConn,
                                                  ),
                                                ),
                                              ),
                                        ),
                                        const Spacer(),
                                        _primaryButton(
                                          'Se connecter',
                                          _handleConnexion,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ─ Inscription ─
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      20,
                                      16,
                                      20,
                                      20,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: _nomCtrl,
                                                decoration: _dec(
                                                  'Nom',
                                                  Icons.person_outline_rounded,
                                                ),
                                                textCapitalization:
                                                    TextCapitalization.words,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: TextField(
                                                controller: _prenomCtrl,
                                                decoration: _dec(
                                                  'Prénom',
                                                  Icons.badge_outlined,
                                                ),
                                                textCapitalization:
                                                    TextCapitalization.words,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _emailInscCtrl,
                                          decoration: _dec(
                                            'Email',
                                            Icons.alternate_email_rounded,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _passInscCtrl,
                                          obscureText: _obscureInsc,
                                          decoration:
                                              _dec(
                                                'Mot de passe',
                                                Icons.lock_outline_rounded,
                                              ).copyWith(
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _obscureInsc
                                                        ? Icons
                                                              .visibility_off_outlined
                                                        : Icons
                                                              .visibility_outlined,
                                                    color: AppTheme.muted,
                                                    size: 20,
                                                  ),
                                                  onPressed: () => setState(
                                                    () => _obscureInsc =
                                                        !_obscureInsc,
                                                  ),
                                                ),
                                              ),
                                        ),
                                        const Spacer(),
                                        _primaryButton(
                                          "S'inscrire",
                                          _handleInscription,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Guest access
                      GestureDetector(
                        onTap: _go,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.muted.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.storefront_outlined,
                                color: AppTheme.muted,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Continuer en tant que visiteur',
                                style: TextStyle(
                                  color: AppTheme.muted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1C1917), Color(0xFF3B2F2F)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppTheme.ink.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
