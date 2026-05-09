import 'package:flutter/material.dart';
import '../models.dart/cart.dart';
import '../theme/app_theme.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onCartUpdated;

  const CartScreen({super.key, required this.onCartUpdated});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cart = Cart();

  void _refresh() {
    setState(() {});
    widget.onCartUpdated();
  }

  void _placeOrder() {
    if (cart.items.isEmpty) return;
    final count = cart.itemCount;
    final total = cart.total;
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppTheme.cream,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.sage, Color(0xFF4CAF50)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.sage.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Commande confirmée !',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.ink,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$count article${count > 1 ? 's' : ''} commandé${count > 1 ? 's' : ''}',
                style: const TextStyle(color: AppTheme.muted, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total payé',
                      style: TextStyle(color: AppTheme.muted),
                    ),
                    Text(
                      '${total.toStringAsFixed(2)} DT',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.ink,
                        fontFamily: 'Georgia',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1C1917), Color(0xFF3B2F2F)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      cart.clear();
                      widget.onCartUpdated();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Retour à la boutique',
                      style: TextStyle(
                        color: Colors.white,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        backgroundColor: AppTheme.ink,
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mon Panier',
              style: TextStyle(
                fontFamily: 'Georgia',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (cart.itemCount > 0)
              Text(
                '${cart.itemCount} article${cart.itemCount > 1 ? 's' : ''}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
      body: cart.items.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, i) =>
                        _buildCartItem(cart.items[i], i),
                  ),
                ),
                _buildCheckout(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppTheme.creamDark,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('🛒', style: TextStyle(fontSize: 40)),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Votre panier est vide',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.ink,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ajoutez des livres pour commencer',
            style: TextStyle(color: AppTheme.muted, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          // Cover
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(18),
            ),
            child: Image.network(
              item.book.imageUrl,
              width: 72,
              height: 96,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 72,
                height: 96,
                color: AppTheme.creamDark,
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: AppTheme.muted,
                ),
              ),
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppTheme.ink,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.book.author,
                    style: const TextStyle(
                      color: AppTheme.muted,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.totalPrice.toStringAsFixed(2)} DT',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppTheme.ink,
                        ),
                      ),
                      // Qty controls
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.creamDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _qtyButton(Icons.remove, () {
                              cart.decreaseQuantity(item.book.id);
                              _refresh();
                            }),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppTheme.ink,
                                ),
                              ),
                            ),
                            _qtyButton(Icons.add, () {
                              cart.addBook(item.book);
                              _refresh();
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Delete
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                cart.removeBook(item.book.id);
                _refresh();
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.terracotta.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppTheme.terracotta,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16, color: AppTheme.ink),
      ),
    );
  }

  Widget _buildCheckout() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.ink.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Summary rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${cart.itemCount} article${cart.itemCount > 1 ? 's' : ''}',
                style: const TextStyle(color: AppTheme.muted, fontSize: 14),
              ),
              Text(
                '${cart.total.toStringAsFixed(2)} DT',
                style: const TextStyle(color: AppTheme.muted, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Livraison',
                style: TextStyle(color: AppTheme.muted, fontSize: 14),
              ),
              Text(
                cart.total >= 80 ? 'Gratuite 🎉' : '7.00 DT',
                style: TextStyle(
                  color: cart.total >= 80 ? AppTheme.sage : AppTheme.muted,
                  fontSize: 14,
                  fontWeight: cart.total >= 80
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppTheme.creamDark, thickness: 1.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.ink,
                ),
              ),
              Text(
                '${(cart.total + (cart.total >= 80 ? 0 : 7)).toStringAsFixed(2)} DT',
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppTheme.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
                onPressed: _placeOrder,
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppTheme.ink,
                ),
                label: const Text(
                  'Passer la commande',
                  style: TextStyle(
                    color: AppTheme.ink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          if (cart.total < 80)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Plus que ${(80 - cart.total).toStringAsFixed(2)} DT pour la livraison gratuite !',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.muted, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
