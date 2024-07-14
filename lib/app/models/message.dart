class message {
  int id;
  int user_id;
  String msg;
  String type; // User or AI
  String created_at;
  String updated_at;
  String deleted_at;
  message(
      {this.msg = "Trying to Fetching(Error)",
      this.id = 0,
      this.user_id = 0,
      this.type = "Trying to Fetching(Error)",
      this.created_at = "Trying to Fetching(Error)",
      this.updated_at = "Trying to Fetching(Error)",
      this.deleted_at = "Trying to Fetching(Error)"});
  factory message.fromJson(Map<String, dynamic> json) {
    return message(
        id: json["id"] ?? 0,
        user_id: json["user_id"] ?? 1,
        msg: json['chat'] ?? "",
        type: json['user_type'] ?? "",
        created_at: json['created_at'] ?? "",
        updated_at: json['updated_at'] ?? "",
        deleted_at: json['deleted_at'] ?? "");
  }
  Map<String, dynamic> toMap() {
    return {"msg": msg, "type": type};
  }
}
// "id": 1,
//             "user_id": 553,
//             "user_type": "User",
//             "chat": "Hello",
//             "created_at": "2024-06-19 11:25:14",
//             "updated_at": "2024-06-19 11:25:14",
//             "deleted_at": "0000-00-00 00:00:00",
//             "status": 1