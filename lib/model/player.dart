class Player {
  String? name;
  String? avatar;
  int? id;

  Player({this.name, this.avatar, this.id});

  Player.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['id'] = id;
    return data;
  }
}
