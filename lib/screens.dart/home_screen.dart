import 'package:flutter/material.dart';
import '../models.dart/book.dart';
import '../models.dart/cart.dart';
import '../data.dart/books_data.dart';
import '../theme/app_theme.dart';
import 'book_detail_screen.dart';
import 'package:bookie_store/screens.dart/cart-screen.dart';
import 'book_request_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final cart = Cart();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Tous';
  late AnimationController _headerAnim;

  List<String> get categories {
    final cats = sampleBooks.map((b) => b.category).toSet().toList();
    return ['Tous', ...cats];
  }

  List<Book> get filteredBooks {
    return sampleBooks.where((book) {
      final matchesSearch =
          book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          book.author.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'Tous' || book.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _refreshCart() => setState(() {});

  @override
  void initState() {
    super.initState();
    _headerAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _headerAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: CustomScrollView(
        slivers: [
          // ── Elegant SliverAppBar ──
          SliverAppBar(
            expandedHeight: 170,
            pinned: true,
            stretch: true,
            backgroundColor: AppTheme.ink,
            actions: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartScreen(onCartUpdated: _refreshCart),
                  ),
                ).then((_) => _refreshCart()),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                          ),
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      if (cart.itemCount > 0)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              gradient: AppTheme.goldGradient,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${cart.itemCount}',
                                style: const TextStyle(
                                  color: AppTheme.ink,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Container(
                decoration: const BoxDecoration(gradient: AppTheme.inkGradient),
                child: Stack(
                  children: [
                    // Decorative elements
                    Positioned(
                      top: -30,
                      right: -30,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.gold.withOpacity(0.06),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 80,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.gold.withOpacity(0.08),
                        ),
                      ),
                    ),
                    // Header content
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 55, 20, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand row
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFD4A853),
                                      Color(0xFFE8C070),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.menu_book_rounded,
                                  color: AppTheme.ink,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Bookie Store',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${sampleBooks.length} livres disponibles',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.55),
                              fontSize: 12,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Search bar
                          Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                              ),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (v) =>
                                  setState(() => _searchQuery = v),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Titre, auteur, catégorie...',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.45),
                                  fontSize: 13,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.white60,
                                  size: 20,
                                ),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.white60,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          _searchController.clear();
                                          setState(() => _searchQuery = '');
                                        },
                                      )
                                    : null,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
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

          // ── Category chips ──
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.ink,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.cream,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final cat = categories[i];
                          final isSelected = cat == _selectedCategory;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedCategory = cat),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? AppTheme.ink : Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.ink
                                      : AppTheme.creamDark,
                                  width: 1.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.ink.withOpacity(0.18),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Text(
                                '${AppTheme.emojiFor(cat)} $cat',
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.muted,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Results count
                    Text(
                      filteredBooks.isEmpty && _searchQuery.isNotEmpty
                          ? 'Aucun résultat pour "$_searchQuery"'
                          : '${filteredBooks.length} livre${filteredBooks.length > 1 ? 's' : ''} trouvé${filteredBooks.length > 1 ? 's' : ''}',
                      style: TextStyle(
                        color: filteredBooks.isEmpty && _searchQuery.isNotEmpty
                            ? AppTheme.terracotta
                            : AppTheme.muted,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Books list or Empty state ──
          filteredBooks.isEmpty
              ? SliverFillRemaining(child: _buildEmptyState())
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildBookCard(filteredBooks[index]),
                      childCount: filteredBooks.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // ── Empty State with Request Option ──
  Widget _buildEmptyState() {
    return Container(
      color: AppTheme.cream,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.creamDark,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.gold.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Center(
              child: Text('🔍', style: TextStyle(fontSize: 42)),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _searchQuery.isNotEmpty
                ? '"$_searchQuery" introuvable'
                : 'Aucun livre dans cette catégorie',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.ink,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Ce livre n\'est pas encore dans notre catalogue.\nVoulez-vous nous le demander ?',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.muted, fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 32),

          // Request button — primary CTA
          SizedBox(
            width: double.infinity,
            height: 54,
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
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        BookRequestScreen(prefillTitle: _searchQuery),
                  ),
                ),
                icon: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: AppTheme.ink,
                ),
                label: const Text(
                  'Demander ce livre',
                  style: TextStyle(
                    color: AppTheme.ink,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Clear search secondary button
          TextButton.icon(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
                _selectedCategory = 'Tous';
              });
            },
            icon: const Icon(
              Icons.refresh_rounded,
              color: AppTheme.muted,
              size: 18,
            ),
            label: const Text(
              'Réinitialiser la recherche',
              style: TextStyle(color: AppTheme.muted, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // ── Book Card ──
  Widget _buildBookCard(Book book) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              BookDetailScreen(book: book, onCartUpdated: _refreshCart),
        ),
      ).then((_) => _refreshCart()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            // Cover
            Hero(
              tag: 'book_${book.id}',
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                ),
                child: Image.network(
                  book.imageUrl,
                  width: 90,
                  height: 128,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 90,
                    height: 128,
                    color: AppTheme.creamDark,
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: AppTheme.muted,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${AppTheme.emojiFor(book.category)} ${book.category}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF8B6914),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.5,
                        color: AppTheme.ink,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      book.author,
                      style: const TextStyle(
                        color: AppTheme.muted,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Stars
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < book.rating.floor()
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: AppTheme.gold,
                          size: 13,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${book.price.toStringAsFixed(0)} DT',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppTheme.ink,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cart.addBook(book);
                            _refreshCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${book.title} ajouté 🛒'),
                                backgroundColor: AppTheme.sage,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1C1917), Color(0xFF3B2F2F)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
