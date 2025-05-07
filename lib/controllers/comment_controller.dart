import 'package:get/get.dart';

class CommentController extends GetxController {
  var replyingToIndex =
      RxnInt(); // chỉ lưu index của bình luận đang được trả lời
  var replyText = "".obs;

  void toggleReply(int index) {
    if (replyingToIndex.value == index) {
      replyingToIndex.value = null; // đóng lại nếu đang mở
    } else {
      replyingToIndex.value = index;
    }
  }

  void submitReply(int parentIndex) {
    // TODO: xử lý logic gửi comment ở đây
    // debugPrint("Reply to comment $parentIndex: ${replyText.value}");
    replyText.value = "";
    replyingToIndex.value = null;
  }
}
