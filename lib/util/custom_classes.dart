import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final bool isPassword;
  final double? width;
  final double? height;
  final Color? colorIcon;
  final IconData? sufixIcon;
  final Color? colorSufixIcon;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.isPassword = false,
    this.width,
    this.colorIcon,
    this.height,
    this.sufixIcon,
    this.colorSufixIcon,
    this.onChanged

  });

  @override
  State<StatefulWidget> createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isPassword;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 340,
      height: widget.height ?? 49,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFF2F2F2),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.hintText;
          }
          return null;
        },
        obscureText: isObscure,
        onChanged: widget.onChanged,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 15),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black26),
          prefixIcon: Icon(widget.icon, color: widget.colorIcon ?? Color(0xFF00b2b6)),
          suffixIcon:
          widget.isPassword
              ? IconButton(
            onPressed: () => {
              setState(() {
                isObscure = !isObscure;
              })
            },
            icon: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.black38),
          )
              : Icon(widget.sufixIcon, color: widget.colorSufixIcon),
        ),
      ),
    );
  }
}

