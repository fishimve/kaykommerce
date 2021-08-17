class KaykoUser {
  final String userId;

  KaykoUser(this.userId);

  KaykoUser.fromMap(Map<String, dynamic> data) : userId = data['userId'];

  Map<String, dynamic> toMap() => {'userId': userId};
}
