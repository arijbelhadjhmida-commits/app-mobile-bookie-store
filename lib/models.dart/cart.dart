import 'book.dart';

class CartItem {
  final Book book;
  int quantity;

  CartItem({required this.book, this.quantity = 1});

  double get totalPrice => book.price * quantity;
}

class Cart {
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;
  Cart._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get total => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addBook(Book book) {
    final existing = _items.where((i) => i.book.id == book.id);
    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      _items.add(CartItem(book: book));
    }
  }

  void removeBook(String bookId) {
    _items.removeWhere((i) => i.book.id == bookId);
  }

  void decreaseQuantity(String bookId) {
    final existing = _items.where((i) => i.book.id == bookId);
    if (existing.isNotEmpty) {
      if (existing.first.quantity > 1) {
        existing.first.quantity--;
      } else {
        removeBook(bookId);
      }
    }
  }

  void clear() => _items.clear();
}
