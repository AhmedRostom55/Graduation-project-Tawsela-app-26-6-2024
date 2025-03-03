import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final double width;
  final double height;
  final double radius;
  final String titleAbove;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Function(String)? onChanged;
  final bool useValidator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.textAlign = TextAlign.right,
    this.textDirection = TextDirection.rtl,
    required this.width,
    required this.height,
    this.titleAbove = '',
    this.keyboardType,
    this.radius = 10,
    this.maxLength,
    this.maxLengthEnforcement,
    this.inputFormatters,
    this.initialValue,
    this.maxLines = 1,
    this.controller,
    this.useValidator = true,
    this.textInputAction,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleAbove.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              titleAbove,
              style: const TextStyle(
                fontFamily: font,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: kGreyFont,
              ),
            ),
          ),
        SizedBox(
          height: height,
          width: width,
          child: TextFormField(
            initialValue: initialValue,
            maxLengthEnforcement: maxLengthEnforcement,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: const TextStyle(
                color: Colors.black, fontFamily: font, fontSize: 13),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: useValidator ? (value) {
              if (  value == null || value.isEmpty) {
                return S.of(context).FieldIsRequired;
              } else if (maxLength != null && value.length != maxLength!) {
                return "ادخل 10 ارقام بدون كود الدولة";
              }
              return null;
            }: null,
            textDirection: textDirection,
            textAlign: textAlign,
            cursorColor: kGreenBigButtons,
            onChanged: onChanged,
            decoration: InputDecoration(
              errorStyle: const TextStyle(fontFamily: font, height: 0.05),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                borderSide: const BorderSide(color: kGreyBorderLight),
              ),
              labelText: labelText,
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 16.0,
              ),
              hintStyle:
                  const TextStyle(color: kGreyFontLight, fontFamily: font),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                borderSide: const BorderSide(color: kGreyBorderLight),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kGreenButtonBorder),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kRed),
              ),
            ),
            maxLength: maxLength,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}