import 'package:flutter/material.dart';
import '../models.dart/book.dart';
import '../models.dart/cart.dart';
import '../theme/app_theme.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  final VoidCallback onCartUpdated;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.onCartUpdated,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _addedToCart = false;

  void _addToCart() {
    Cart().addBook(widget.book);
    widget.onCartUpdated();
    setState(() => _addedToCart = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _addedToCart = false);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${widget.book.title}" ajouté au panier 🛒'),
        backgroundColor: AppTheme.sage,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: CustomScrollView(
        slivers: [
          // ── Hero AppBar ──
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: AppTheme.ink,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppTheme.inkGradient),
                child: Stack(
                  children: [
                    // Background decoration
                    Positioned(
                      top: -40,
                      right: -40,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.gold.withOpacity(0.07),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: -30,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.gold.withOpacity(0.05),
                        ),
                      ),
                    ),
                    // Book cover
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Hero(
                            tag: 'book_${book.id}',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  book.imageUrl,
                                  height: 210,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(
                                    height: 210,
                                    width: 140,
                                    color: AppTheme.inkLight,
                                    child: const Icon(
                                      Icons.menu_book_rounded,
                                      color: Colors.white54,
                                      size: 60,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Rating stars
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                5,
                                (i) => Icon(
                                  i < book.rating.floor()
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  color: AppTheme.gold,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${book.rating}',
                                style: const TextStyle(
                                  color: AppTheme.goldLight,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Content ──
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppTheme.gold.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        '${AppTheme.emojiFor(book.category)}  ${book.category}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8B6914),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Title
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.ink,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'par ${book.author}',
                      style: const TextStyle(
                        color: AppTheme.muted,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Description section
                    const Text(
                      'À propos de ce livre',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.ink,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppTheme.cardShadow,
                      ),
                      child: Text(
                        book.description,
                        style: const TextStyle(
                          fontSize: 14.5,
                          color: AppTheme.ink,
                          height: 1.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Price + CTA
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1C1917), Color(0xFF3B2F2F)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: AppTheme.elevatedShadow,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Prix',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${book.price.toStringAsFixed(0)} DT',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Georgia',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: _addToCart,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                gradient: _addedToCart
                                    ? const LinearGradient(
                                        colors: [
                                          AppTheme.sage,
                                          Color(0xFF4CAF50),
                                        ],
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Color(0xFFD4A853),
                                          Color(0xFFE8C070),
                                        ],
                                      ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _addedToCart
                                        ? Icons.check_rounded
                                        : Icons.shopping_bag_outlined,
                                    color: AppTheme.ink,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _addedToCart ? 'Ajouté !' : 'Ajouter',
                                    style: const TextStyle(
                                      color: AppTheme.ink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
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
        ],
      ),
    );
  }
}
