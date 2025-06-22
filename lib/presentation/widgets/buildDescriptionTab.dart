import 'package:flutter/material.dart';

Widget buildDescriptionTab() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Miêu tả chi tiết',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          '20.39.9 Mỹ Đình 34.1/35 5.5 7.7 2 tỷ\n'
          'Mỹ Đình 2 Nam Từ Liêm 6-9 Tỷ HĐ\n'
          'Phạm Văn Hay Thiên Sơn\n'
          '0367383444 H3GB nguồn Hội đồng thẩm định\n\n'
          'BÙM >7 BÙM >7 BÙM,\n'
          'SIÊU PHẨM - VỈA HÈ - KINH DOANH - BIỆT THỰ KHU PHỐ ĐI BỘ CHÂU ÂU - VỊ TRÍ HIẾM- VĂN PHÒNG.... AN NINH TUYỆT VỜI - AN SINH ĐẲNG CẤP.\n'
          'BT4 - 4LV (Lô44/214 Nguyễn Xiển) KĐT Hạ Đình 171 4 12 59.5 tỷ Thanh Xuân 50 nền đô 100 HD TP Mai Trung\n'
          'Khối Đại Dương 0963660234, hợp tác DT.\n\n'
          'Mô tả:\n'
          '- KBT Mỹ Đình với quy mô 7.49 ha, đường rộng 20m, có vỉa hè, cách mặt phố Nguyễn Xiển 100m,\n'
          'cách ngã tư Nguyễn Trãi và phố Linh Đàm 500m, nằm gần các trục đường lớn và hệ thống kỹ thuật và các gói thầu giao thông Quốc gia và thành phố như: Quốc lộ 6, nhà máy nước Hạ Đình, Vành đai 3, Lương Thế Vinh nối dài, tuyến đường quy hoạch 40m Triều Khúc,\n'
          '… thuận tiện di chuyển, phù hợp để ở, kinh doanh và là vị trí các mặt kinh doanh thương mại trong tương lai.\n\n'
          'Tiện ích:\n'
          '- Biệt thự sát phố đi bộ Thanh xuân.\n'
          '- Thiết kế thông sàn hiện đại sang trọng. - Xây dựng 6 tầng, nhà đang cho thuê làm văn phòng.\n'
          '- Nhà mới hoàn thiện đẹp vuông đất, có 1-0-2\n'
          '- Di chuyển dễ, gần trục thông tầng cho thuê phổ biến\n'
          '- Bảo vệ 24/7, tiện ích nội khu đầy đủ: công viên, trường học, nhà xe,\n'
          '- Sổ đỏ riêng, hoàn công, 2 lối đi\n'
          '- Bán nhà tặng nội thất cao cấp, 2 cầu 3 công lắp âm trần sẵn.\n\n'
          'Ace dẫn khách bác cáo trước sau khi dẫn TP Mai Dịch 600 phút để nhận chìa khoá + hỗ trợ tiếp và kết nối tạo nền tảng chuẩn trí tuệ nhân tạo.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
      ],
    ),
  );
}
