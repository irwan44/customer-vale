class Post {
  final String title;
  final String author;
  final String category;
  final DateTime date;
  final String content;
  final String? imageUrl;
  final List<String>? articleSection;

  Post({
    required this.title,
    required this.author,
    required this.category,
    required this.date,
    required this.content,
    this.imageUrl,
    this.articleSection,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<String>? articleSection = [];
    if (json['yoast_head_json']['schema']['@graph'][0]['articleSection'] != null) {
      articleSection = List<String>.from(json['yoast_head_json']['schema']['@graph'][0]['articleSection']);
    }

    return Post(
      title: json['title']['rendered'],
      author: json['_embedded']['author']?[0]['name'] ?? 'Unknown',
      category: json['_embedded']['wp:term']?[0][0]['name'] ?? 'Uncategorized',
      date: DateTime.parse(json['date']),
      content: json['content']['rendered'],
      imageUrl: json['_embedded']['wp:featuredmedia'] != null ? json['_embedded']['wp:featuredmedia'][0]['source_url'] : null,
      articleSection: articleSection.isNotEmpty ? articleSection : null,
    );
  }
}
