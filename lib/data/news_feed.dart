class NewsFeed {
  final String author;
  final String article;
  final String title;
  final String uid;
  final DateTime time;
  final int shares;
  final List<dynamic> likes;
  final String image;
  final bool show;
  final String category;

  NewsFeed(
      {this.uid,
      this.author,
      this.article,
      this.time,
      this.title,
      this.likes,
      this.shares,
      this.image,
      this.show,
      this.category});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'author': author,
      'article': article,
      'time': time,
      'likes': likes,
      'title': title,
      'shares': shares,
      'image': image,
      'show': show,
      'category': category,
    };
  }

  static NewsFeed fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NewsFeed(
        author: map['author'],
        uid: map['uid'],
        article: map['article'],
        time: map['time'],
        likes: map['likes'],
        shares: map['shares'],
        image: map['image'],
        title: map['title'],
        category: map['category'],
        show: map['show']);
  }
}
