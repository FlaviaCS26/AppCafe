class PromocaoModel {
  late int id;
  late String urlImage;

  PromocaoModel.fromJson(Map json) {
    id = json['id'];
    urlImage = json['urlImage'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['urlImage'] = urlImage;
    return data;
  }
}
