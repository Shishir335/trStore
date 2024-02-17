class Product {
  int? id;
  String? slug;
  String? url;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  String? status;
  String? category;
  int? quantity;

  Product(
      {this.id,
      this.slug,
      this.url,
      this.title,
      this.content,
      this.image,
      this.thumbnail,
      this.status,
      this.category,
      this.quantity = 0});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    url = json['url'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    category = json['category'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['url'] = url;
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['thumbnail'] = thumbnail;
    data['status'] = status;
    data['category'] = category;
    data['quantity'] = quantity;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slug': slug,
      'url': url,
      'title': title,
      'content': content,
      'image': image,
      'thumbnail': thumbnail,
      'status': status,
      'category': category,
      'publishedAt': id,
      'updatedAt': id,
      'userId': id,
      'quantity': quantity,
    };
  }
}
