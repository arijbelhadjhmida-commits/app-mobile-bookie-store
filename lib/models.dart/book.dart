class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final double price;
  final String description;
  final String category;
  final double rating;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.category,
    this.rating = 4.0,
  });
}
