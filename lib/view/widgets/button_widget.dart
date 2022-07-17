import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onClicked;
  //bool? btnActive;
  const ButtonWidget({
    @required this.text,
    @required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 342,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.aptiblueprimary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
          onPressed: onClicked,
          child: const Text('Kayit ol'),
        ),
      );
}
