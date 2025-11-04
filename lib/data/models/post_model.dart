class Post {
  final String imageUrl;
  final String userEmail;
  final String description;

  Post({
    required this.imageUrl,
    required this.userEmail,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "userEmail": userEmail,
        "description": description,
      };
}
