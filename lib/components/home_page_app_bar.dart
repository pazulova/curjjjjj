import 'package:currency_converter/screens/history_page.dart';
import 'package:flutter/material.dart';

import '../constants/text_constants.dart';
import '../theme/colors.dart';
import '../theme/text_style.dart';


class HomePageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppbar({
    Key? key,
  }) : super(key: key);
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text(AppText.appTitl, style: AppTextStyles.titleStyle),
      
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
              icon:  const Icon(
                Icons.place_outlined,
                size: 30,
              ))
        ]);
  }
}
