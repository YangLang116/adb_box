import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class WindowOptionWidget<T> extends StatelessWidget {
  final T? selectItem;
  final List<T> dataList;
  final String hint;
  final double width;
  final bool showBorder;
  final String Function(T item) covert;
  final void Function(T item) onSelected;

  const WindowOptionWidget({
    super.key,
    required this.selectItem,
    required this.dataList,
    required this.hint,
    this.width = 160,
    this.showBorder = true,
    required this.covert,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        value: selectItem,
        onChanged: (value) {
          if (value != null && value != selectItem) {
            onSelected.call(value);
          }
        },
        hint: _buildHint(),
        items: _buildItems(),
        buttonStyleData: _buildStyle(),
        iconStyleData: _buildIconStyle(),
        dropdownStyleData: _buildDropdownStyle(),
        menuItemStyleData: _buildItemStyle(),
      ),
    );
  }

  Widget _buildHint() {
    return Text(
      hint,
      style: TextStyle(
        color: ColorConstant.hint,
        fontSize: FontConstant.hint,
        height: 0,
      ),
    );
  }

  List<DropdownMenuItem<T>> _buildItems() {
    return dataList.map((item) {
      return DropdownMenuItem<T>(value: item, child: _buildItem(item));
    }).toList();
  }

  Widget _buildItem(T item) {
    return Center(
      child: Text(
        covert.call(item),
        style: TextStyle(
          color: ColorConstant.foreground,
          fontSize: FontConstant.H2,
          height: 1,
        ),
      ),
    );
  }

  MenuItemStyleData _buildItemStyle() {
    return MenuItemStyleData(
      height: 32,
      overlayColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        return ColorConstant.primary;
      }),
    );
  }

  DropdownStyleData _buildDropdownStyle() {
    return DropdownStyleData(
      width: width,
      maxHeight: 138,
      offset: Offset(0, -5),
      padding: EdgeInsets.all(5),
      openInterval: Interval(0.1, 0.3),
      decoration: BoxDecoration(
        color: ColorConstant.background,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorConstant.border, width: 1),
      ),
    );
  }

  IconStyleData _buildIconStyle() {
    return IconStyleData(
      iconEnabledColor: ColorConstant.hint,
    );
  }

  ButtonStyleData _buildStyle() {
    return ButtonStyleData(
      padding: EdgeInsets.only(left: 10, right: 5),
      width: width,
      height: 32,
      decoration: BoxDecoration(
        color: ColorConstant.background,
        borderRadius: BorderRadius.circular(5),
        border: showBorder
            ? Border.all(color: ColorConstant.border, width: 1)
            : null,
      ),
      overlayColor: WidgetStateColor.transparent,
    );
  }
}
