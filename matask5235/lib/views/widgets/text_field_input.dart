import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPass;
  final bool isPrice; // Thêm thuộc tính isPrice
  final TextInputType textInputType;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.isPass = false,
    this.isPrice = false, // Giá trị mặc định là false
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none, // Loại bỏ viền mặc định
                contentPadding: const EdgeInsets.all(8),
              ),
              keyboardType: textInputType,
              obscureText: isPass,
              inputFormatters:
                  isPrice
                      ? [
                        FilteringTextInputFormatter.digitsOnly,
                        ThousandsSeparatorInputFormatter(),
                      ]
                      : null,
            ),
          ),
          if (isPrice)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'VND',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern(
    'vi',
  ); // Sử dụng locale 'vi'

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int value =
        int.tryParse(
          newValue.text.replaceAll('.', '').replaceAll(',', ''),
        ) ??
        0; // Xóa cả dấu ',' và '.'
    final String newText = _formatter.format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
