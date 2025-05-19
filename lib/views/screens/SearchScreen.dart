import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_real_estate/controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.put(SearchMainController());
  final RxList<String> _selectedCriteria = <String>[].obs;

  final List<String> criteriaList = [
    'Triệu đô',
    'Lãi vốn (Rẻ)',
    'Dòng tiền ổn định',
    'Để ở',
    'Để kinh doanh',
    'Hẻm ô tô',
  ];

  final RxList<String> provinces = ['Hà Nội', 'TP.HCM', 'Đà Nẵng'].obs;
  final RxList<String> districts = ['Quận 1', 'Thanh Xuân', 'Quận 3'].obs;
  final RxList<String> wards = ['Phường A', 'Phường B', 'Phường C'].obs;
  final RxString selectedDistrict = 'Thanh Xuân'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tìm kiếm bất động sản')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Tìm kiếm',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _keywordRow(),

            const SizedBox(height: 8),
            _sectionLabel('Khu vực'),
            _dropdownField(
              'Tỉnh/Thành phố',
              controller.province,
              provinces,
              isRequired: true,
            ),
            const SizedBox(height: 8),

            _dropdownField(
              'Quận/Huyện',
              controller.district,
              districts,
              isRequired: true,
            ),
            const SizedBox(height: 8),

            _dropdownField('Phường/Xã', controller.ward, wards),
            const SizedBox(height: 8),

            _textField(hint: 'Ví dụ: Trần Phú', label: 'Tên đường'),
            const SizedBox(height: 8),

            _textField(hint: 'Ví dụ: 12.3', label: 'Địa chỉ'),

            const SizedBox(height: 8),
            _sectionLabel('Khoảng giá'),
            Row(
              children: [
                Expanded(child: _textField(hint: 'tỷ', label: 'Từ giá')),
                const SizedBox(width: 16),
                Expanded(child: _textField(hint: 'tỷ', label: 'Đến giá')),
              ],
            ),

            const SizedBox(height: 8),
            _sectionLabel('Tiêu chí'),
            Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 8,
                children:
                    criteriaList.map((label) {
                      final isSelected = _selectedCriteria.contains(label);
                      return FilterChip(
                        label: Text(label),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            _selectedCriteria.add(label);
                          } else {
                            _selectedCriteria.remove(label);
                          }
                        },
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _keywordRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Từ khoá',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Nhập từ khoá tìm kiếm',
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _textField({String? label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none, // mặc định ẩn đi
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black26, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdownField(
    String label,
    RxString selectedValue,
    List<String> items, {
    bool isRequired = false,
  }) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: isRequired ? '* ' : '',
              style: const TextStyle(color: Colors.red),
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
              ],
            ),
          ),
          DropdownButtonFormField<String>(
            value:
                items.contains(selectedValue.value)
                    ? selectedValue.value
                    : null,
            hint: const Text('Chọn'),
            items:
                items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
            onChanged: (val) {
              if (val != null) selectedValue.value = val;
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none, // mặc định ẩn đi
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
