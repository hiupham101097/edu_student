import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:flutter/material.dart';

Widget dropdownSelect<T>({
  required String label,
  required List<T> items,
  required T? selectedItem,
  required void Function(T?) onChanged,
  required String Function(T) itemLabelBuilder,
  required String text,
  bool isRequired = false,
  FormFieldValidator<T>? validator,
  bool isEnabled = true, // ✅ Thêm biến để điều khiển enable/disable
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        FormField<T>(
          validator: isEnabled
              ? validator ??
                  (isRequired
                      ? (value) =>
                          value == null ? 'Vui lòng chọn $text' : null
                      : null)
              : null,
          builder: (FormFieldState<T> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: isEnabled ? 1.0 : 0.6,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: field.hasError ? Colors.red : Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: isEnabled ? null : Colors.grey[200],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<T>(
                        isExpanded: true,
                        hint: Text(
                          'Chọn $text',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppStyle.colors[1][5],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        items: items.isNotEmpty
                            ? items.map((T item) {
                                return DropdownMenuItem<T>(
                                  value: item,
                                  child: Text(
                                    itemLabelBuilder(item),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppStyle.colors[2][11],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList()
                            : [
                                DropdownMenuItem<T>(
                                  enabled: false,
                                  child: Text(
                                    'Không có $text',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                        value: selectedItem,
                        onChanged: isEnabled
                            ? (value) {
                                onChanged(value);
                                field.didChange(value);
                              }
                            : null,
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 45.0,
                        ),
                        menuItemStyleData:
                            const MenuItemStyleData(height: 40),
                      ),
                    ),
                  ),
                ),
                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                    child: Text(
                      field.errorText ?? '',
                      style:
                          const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    ),
  );
}
