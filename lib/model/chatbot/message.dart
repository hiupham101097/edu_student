
import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

import '../../system/base/model/user/user_data_model.dart';

// ignore: must_be_immutable
class MessageChatBot extends Equatable with Mappable {
  String? sender;
  String? text;
  int? id;

  MessageChatBot({this.sender, this.text, this.id});

  @override
  void mapping(Mapper map) {
    map("sender", sender, (v) => sender = v);
    map("text", text, (v) => text = v);
    map("id", id, (v) => id = v);
  }

  factory MessageChatBot.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return MessageChatBot();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<MessageChatBot>();
    return obj ?? MessageChatBot();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class MessageModel extends Equatable with Mappable {
  MessageModel({
    this.id,
    this.userSenderId,
    this.image,
    this.title,
    this.content,
    this.dateTime,
    this.messageStatus,
    this.profileModel,
    this.isRead,
  });

  String? id;
  int? userSenderId;
  String? image;
  String? title;
  String? content;
  String? dateTime;
  MessageStatus? messageStatus;
  UserDataModal? profileModel;
  bool? isRead;

  @override
  void mapping(Mapper map) {
    map("id", id, (v) => id = v);
    map("userSenderId", userSenderId, (v) => userSenderId = v);
    map("image", image, (v) => image = v);
    map("title", title, (v) => title = v);
    map("content", content, (v) => content = v);
    map("dateTime", dateTime, (v) => dateTime = v);
    map("messageStatus", messageStatus, (v) => messageStatus = v);
    map("profileModel", profileModel, (v) => profileModel = v);
    map("isRead", isRead, (v) => isRead = v);
  }

  factory MessageModel.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return MessageModel();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<MessageModel>();
    return obj ?? MessageModel();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props => [
    id,
    userSenderId,
    content,
    dateTime,
    messageStatus,
  ];
}

enum MessageStatus { success, error, warring, waitting }

class ChatBotScrip {
  ChatBotScrip({this.title, this.id, this.parentId, this.content});

  String? title;
  int? id;
  int? parentId;
  String? content;
}
