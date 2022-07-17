import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/colors/app_colors.dart';
import '../../localization/locale_keys.g.dart';
class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
      width: 317,
      height: 70,
      child: TextFormField(
        autofocus: false,
        validator: (String? value) {
          if (value!.isEmpty) {
            return LocaleKeys.signin_validation_text_signin_name_valid_text
                .tr();
          }
          return null;
        },
        // maxLength: 30,

        ///sd_________________________************************************//
        // onChanged: (value) => setState(() => inputtedValue = value),

        decoration: InputDecoration(
          fillColor: AppColors.aptiwhite,
          filled: true,
          hintText: LocaleKeys.signin_card_signin_name_inside_text.tr(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.aptidarkgray5),
          ),
          border: OutlineInputBorder(
            // on error only
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          
          // suffixIcon: IconButton(
          //   onPressed: cancelController.clear,
          //   icon: const Icon(Icons.clear),
          // ),
        ),
      ),
    ),
    );
  }
}