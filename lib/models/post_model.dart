class PostModel {
  String? name;
  String? id;
  // String? postId;
  String? created_at;
  String? image;
  String? text;
  String? postImage;
  int? likes;
  int? comments;

  PostModel({
    this.image,
    this.name,
    this.id,
    // this.postId,
    this.created_at,
    this.text,
    this.postImage,
    this.likes,
    this.comments,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    id = json['id'];
    // postId = json['postId'];
    created_at = json['created_at'];
    text = json['text'];
    postImage = json['postImage'];
    likes = json['likes'];
    comments = json['comments'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'postId': postId,
      'name': name,
      'image': image,
      'text': text,
      'created_at': created_at,
      'postImage': postImage,
      'likes': likes,
      'comments': comments,
    };
  }
  @override
  String toString() {
    return 'PostModel(id: $id,name: $name, text: $text, image: $image, postImage: $postImage, created_at: $created_at, likes: $likes, comments: $comments,)';
  }
}
