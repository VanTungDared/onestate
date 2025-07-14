import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoubleEndedSlider extends StatefulWidget {
  const DoubleEndedSlider({super.key});

  @override
  State<DoubleEndedSlider> createState() => _DoubleEndedSliderState();
}

class _DoubleEndedSliderState extends State<DoubleEndedSlider> {
  RangeValues _currentRange = const RangeValues(0, 100);

  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startController.text = _currentRange.start.toInt().toString();
    _endController.text = _currentRange.end.toInt().toString();
  }

  void _updateStartFromText(String text) {
    final parsed = int.tryParse(text);
    if (parsed != null && parsed >= 0 && parsed <= _currentRange.end) {
      setState(() {
        _currentRange = RangeValues(parsed.toDouble(), _currentRange.end);
      });
    }
  }

  void _updateEndFromText(String text) {
    final parsed = int.tryParse(text);
    if (parsed != null && parsed >= 0 && parsed >= _currentRange.start) {
      setState(() {
        _currentRange = RangeValues(_currentRange.start, parsed.toDouble());
      });
    }
  }

  @override
  void dispose() {
    _endController.dispose();
    _startController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _startController.text = _currentRange.start.toInt().toString();
    _endController.text = _currentRange.end.toInt().toString();
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Từ: ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' ${_currentRange.start.toInt()}',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TextField(
                      controller: _startController,
                      keyboardType: TextInputType.number,
                      onChanged: _updateStartFromText,
                      decoration: InputDecoration(
                        hintText: "Vd: 20",
                        suffixText: "tỷ",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Đến: ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '${_currentRange.end.toInt()}',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TextField(
                      controller: _endController,
                      keyboardType: TextInputType.number,
                      onChanged: _updateEndFromText,
                      decoration: InputDecoration(
                        hintText: "Vd: 20",
                        suffixText: "tỷ",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          RangeSlider(
            values: _currentRange,
            min: 0,
            max: 100,
            divisions: 100,
            labels: RangeLabels(
              _currentRange.start.toInt().toString(),
              _currentRange.end.toInt().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRange = values;
              });
            },
          ),
          PriceRangeRadioGroup(
            currentRange: _currentRange,
            onChanged: (newRange) {
              setState(() {
                _currentRange = newRange;
              });
            },
          ),
        ],
      ),
    );
  }
}

class PriceRangeRadioGroup extends StatefulWidget {
  final RangeValues currentRange;
  final Function(RangeValues) onChanged;

  const PriceRangeRadioGroup({
    super.key,
    required this.currentRange,
    required this.onChanged,
  });

  @override
  State<PriceRangeRadioGroup> createState() => _PriceRangeRadioGroupState();
}

class _PriceRangeRadioGroupState extends State<PriceRangeRadioGroup> {
  PriceRangeOption? _selectedOption;

  final List<PriceRangeOption> options = [
    PriceRangeOption('<1 tỷ', 0, 1),
    PriceRangeOption('1–3 tỷ', 1, 3),
    PriceRangeOption('3–5 tỷ', 3, 5),
    PriceRangeOption('5–10 tỷ', 5, 10),
    PriceRangeOption('10–40 tỷ', 10, 40),
    PriceRangeOption('40–70 tỷ', 40, 70),
    PriceRangeOption('70–100 tỷ', 70, 100),
    PriceRangeOption('>100 tỷ', 100, 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:
          options.map((option) {
            return RadioListTile<PriceRangeOption>(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              title: Text(option.label),
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                  widget.onChanged(RangeValues(value!.start, value.end));
                });
              },
            );
          }).toList(),
    );
  }
}

class PriceRangeOption {
  final String label;
  final double start;
  final double end;

  PriceRangeOption(this.label, this.start, this.end);
}
