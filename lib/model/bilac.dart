class Bilac {
  int? id;
  String? json;
  String? time;

  Bilac({
    this.id,
    this.json,
    this.time,
  });

  Bilac.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    json = json['json'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['json'] = json;
    data['time'] = time;
    return data;
  }
}
