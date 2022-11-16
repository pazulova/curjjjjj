import 'package:flutter/material.dart';



class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30, ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const AllCurrencies()
                    //       ),
                    // );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 36),
                    child: Text('All Currencies'),
                  )),
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 36),
                child: Text('Favorite Currencies'),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const
                //        MyCurrenciesPage()
                //        ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
