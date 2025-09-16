import 'dart:convert';

class NotifyMessage {
  NotifyMessage({this.sender, this.channelId, this.messageId});

  Sender? sender;
  String? channelId;
  String? messageId;

  factory NotifyMessage.fromJson(Map<String, dynamic> input) {
    var notifyMessage = NotifyMessage(
      sender: Sender.fromJson(json.decode(input["sender"])),
      channelId: input["channelId"],
      messageId: input["messageId"],
    );

    return notifyMessage;
  }
}

class Sender {
  Sender({this.tenantId, this.userId, this.name = ""});

  int? tenantId;
  int? userId;
  String name;

  factory Sender.fromJson(Map<String, dynamic> input) => Sender(
      tenantId: input["tenantId"],
      userId: input["userId"],
      name: input["name"]);
}
