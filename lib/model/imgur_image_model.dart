class ImgurImageModel {
  ImgurImageModel(
      {this.id,
      this.title,
      this.deleteHash,
      this.width,
      this.height,
      this.dateTime,
      this.imageLink});

  ImgurImageModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.title = parsedJson['title'],
        this.deleteHash = parsedJson['deletehash'],
        this.width = parsedJson['width'],
        this.height = parsedJson['height'],
        this.dateTime = parsedJson['datetime'],
        this.imageLink = parsedJson['link'];

  final String id;
  final String title;
  final String deleteHash;
  final int width;
  final int height;
  final int dateTime;
  final String imageLink;
}
