import 'package:edu_student/system/_variables/storage/global_params.dart';

import '../../model/chatbot/message.dart';

class DataViewMessage {
  final List<MessageModel> listMessage = [
    MessageModel(
      id: 'QuickAsk',
      userSenderId: 57,
      profileModel: GlobalParams.getUserData(),
      content:
          'Chào bạn, bạn có thể chọn một trong các câu hỏi dưới đây để được tư vấn nhanh nhé!',
      dateTime: '2025-04-21',
      messageStatus: MessageStatus.success,
      isRead: true,
    ),
    MessageModel(
      id: 'Ask_LichHoc',
      userSenderId: 01,
      content: 'Lịch học của các khóa học như thế nào?',
      dateTime: '2025-04-21',
      messageStatus: MessageStatus.success,
      isRead: true,
    ),
    MessageModel(
      id: 'Ask_HocPhi',
      userSenderId: 01,
      content: 'Học phí của các khóa học là bao nhiêu?',
      dateTime: '2025-04-22',
      messageStatus: MessageStatus.success,
      isRead: true,
    ),
    MessageModel(
      id: 'Ask_MonHoc',
      userSenderId: 01,
      content: 'Trung tâm dạy những môn gì?',
      dateTime: '2025-04-22',
      messageStatus: MessageStatus.success,
      isRead: true,
    ),
    MessageModel(
      id: 'Ask_ChatLuong',
      userSenderId: 01,
      content: 'Chất lượng giảng dạy có tốt không?',
      dateTime: '2025-04-22',
      messageStatus: MessageStatus.success,
      isRead: true,
    ),
    MessageModel(
      id: 'Ask_DauVaoDauRa',
      userSenderId: 01,
      content: 'Tiêu chuẩn đầu vào và đầu ra là gì?',
      dateTime: '2025-04-22',
      messageStatus: MessageStatus.success,
      isRead: true,
    ),
    MessageModel(
      id: 'Ask_MoiTruong',
      userSenderId: 01,
      content: 'Môi trường học tập và sĩ số lớp học ra sao?',
      dateTime: '2025-04-22',
      messageStatus: MessageStatus.success,
      isRead: true,
    ),
  ];
}

class DataChatBotExsample {
  List<String> listChatBot = [
    'Học phí của các khóa học là bao nhiêu?',
    'Lịch học của các khóa học như thế nào?',
    'Tiêu chuẩn đầu vào và đầu ra là gì?',
    'Môi trường học tập và sĩ số lớp học ra sao?',
    'Chất lượng giảng dạy có tốt không?',
    'Trung tâm dạy những môn gì?',
  ];
}
