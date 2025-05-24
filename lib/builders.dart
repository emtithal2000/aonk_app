import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildMobileInputs(
  double size,
  String hintText,
  IconData prefixIcon,
  TextInputType keyboardType,
  TextEditingController controller,
  List<TextInputFormatter> inputFormatters,
) {
  return Card(
    elevation: 2,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hintText,
          isDense: true,
          hintStyle: TextStyle(
            fontSize: size * 0.033,
            color: const Color(0xff52b8a0),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: const Color(0xff52b8a0),
            size: size * 0.05,
          ),
        ),
      ),
    ),
  );
}

Widget buildSelection(
  double size,
  String hint,
  List<String> items, {
  required Function(String) onSelected,
  String? tooltip,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: size * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: PopupMenuButton<String>(
        offset: Offset(0, size * 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tooltip: tooltip ?? '',
        itemBuilder: (context) => items.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: size * 0.02,
                color: const Color(0xff52b8a0),
              ),
            ),
          );
        }).toList(),
        onSelected: onSelected,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size * 0.2,
                child: Text(
                  hint,
                  style: TextStyle(
                    fontSize: size * 0.02,
                    color: const Color(0xff52b8a0),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Color(0xff52b8a0).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xff52b8a0),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildSelectionMobile(
  double size,
  List<String> items,
  String hint, {
  required Function(String) onSelected,
  bool isExpanded = false,
  String? Function(String?)? validator,
}) {
  return Card(
    elevation: 2,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: size * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: PopupMenuButton<String>(
        offset: Offset(0, size * 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        itemBuilder: (context) => items.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: size * 0.035,
                color: const Color(0xff52b8a0),
              ),
            ),
          );
        }).toList(),
        onSelected: onSelected,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.035),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: isExpanded ? size * 0.25 : size * 0.6,
                child: Text(
                  hint,
                  style: TextStyle(
                    fontSize: size * 0.035,
                    color: const Color(0xff52b8a0),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff52b8a0).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xff52b8a0),
                  size: size * 0.05,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildTextField({
  required double size,
  required String hintText,
  required IconData prefixIcon,
  required TextEditingController controller,
  required TextInputType keyboardType,
  List<TextInputFormatter>? inputFormatters,
  String? hinttext,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.08),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hintText,
        isDense: true,
        hintStyle: TextStyle(
          color: const Color(0xff84beb0),
          fontSize: size * 0.02,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0xff52b8a0),
          size: size * 0.03,
        ),
      ),
    ),
  );
}
