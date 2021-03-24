class BlogsModel {
  String id;
  String createdAt;
  String title;
  String imageUrl;

  BlogsModel({this.id, this.createdAt, this.title, this.imageUrl});

  BlogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    title = json['title'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}