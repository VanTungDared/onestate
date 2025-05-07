import 'package:app_real_estate/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.put(SearchMainController());
  final RxList<String> _selectedCriteria = <String>[].obs;

  final List<String> criteriaList = [
    'Triệu đô',
    'Lãi vốn (Rẻ)',
    'Dòng tiền ổn định',
    'Chính chủ',
    'Để ở',
    'Để kinh doanh',
    'Hẻm ô tô',
    'Chủ cần bán gấp',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            const Text(
              'Tiêu chí',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Wrap(
                spacing: 10,
                runSpacing: 10,
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
            const SizedBox(height: 24),
            // === GIÁ TIỀN ===
            const Text(
              'Giá tiền',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Obx(
              () => Row(
                children: [
                  Text(
                    controller.isMillionDollar.value
                        ? '${controller.price.value.toInt()} triệu đô'
                        : '${controller.price.value.toInt()} tỷ',
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Checkbox(
                        value: controller.isMillionDollar.value,
                        onChanged:
                            (val) => controller.isMillionDollar.value = val!,
                      ),
                      const Text('Triệu đô'),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => Slider(
                value: controller.price.value,
                min: 0,
                max: 20,
                divisions: 20,
                label: '${controller.price.value.toInt()} tỷ',
                onChanged: (val) => controller.price.value = val,
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.isMillionDollar.value ? '0 triệu đô' : '0 tỷ',
                  ),
                  Text(
                    controller.isMillionDollar.value ? '20 triệu đô' : '20 tỷ',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // === KHU VỰC ===
            const Text(
              'Khu vực',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            _buildLocationSelector('Tỉnh/Thành phố', controller.province),
            _buildLocationSelector('Quận/Huyện', controller.district),
            _buildLocationSelector('Phường/Xã', controller.ward),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Tìm kiếm bằng từ khóa',
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildLocationSelector(String label, RxString value) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: const Border(bottom: BorderSide(color: Colors.black12)),
            ),
            child: Text(value.value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
