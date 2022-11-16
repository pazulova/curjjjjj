
import 'package:currency_converter/store/history_data_store.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../store/my_currencies_store.dart';
import '../theme/colors.dart';

Widget currDropDown(String value, void onChange(val)) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: ValueListenableBuilder(
      valueListenable: MyCurDataStore.boxCurrency.listenable(),
      builder: (context, Box box, widget) {
        var list = box.values.toList();
        var listName = list.map((e) => e.currencyName);
        return DropdownButton<String>(
          value: value == "" || !listName.contains(value)
              ? list[0].currencyName
              : value,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: list.map<DropdownMenuItem<String>>((val) {
            return DropdownMenuItem(
              value: val.currencyName,
              child: Text(val.currencyName),
            );
          }).toList(),
          onChanged: (String? val) {
            onChange(val);
          },
        );
      },
    ),
  );
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class DropdownButtonExample extends StatefulWidget {
//   const DropdownButtonExample ({
//     Key? key,
//   }) : super(key: key);


//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }
// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }var userData = box.getAt(index);


// ValueListenableBuilder(
//  valueListenable: HiveDataStore.box.listenable(),
//    builder: (context, Box box, widget) {
//    return SafeArea(
//        child: box.length > 0 ? ListView.builder(
//            shrinkWrap: true,
//            itemCount: box.length,
//            itemBuilder: (BuildContext context, int index) {
//              var userData = box.getAt(index);
//              return Container(
//                padding: const EdgeInsets.all(10),
//                margin: const EdgeInsets.all(10),
//                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1),
//                    border: Border.all(color: Colors.blue.shade900),
//                    borderRadius: const BorderRadius.all(Radius.circular(10))),
//                child: Row(
//                  children: [
//                    Expanded(
//                      flex: 1,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          IntrinsicHeight(
//                            child: Row(
//                              children: [
//                                Text(userData.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                                ),
//                                VerticalDivider(color: Colors.blue.shade900,thickness: 2,),
//                                Text(userData.description, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                                ),
//                              ],
//                            ),
//                          ),
//                          const SizedBox(height: 15),
//                          RichText(text: TextSpan(text: 'Hobby: ', style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
//                              children: <TextSpan>[
//                                TextSpan(text: userData.hobby, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Expanded(
//                      flex: 0,
//                        child: Row(
//                          children: [
//                            InkWell(
//                              onTap:(){
//                                isUpdate.value = true;
//                                nameEditingCtr.text = userData.name;
//                                hobbyEditingCtr.text = userData.hobby;
//                                descriptionEditingCtr.text = userData.description;
//                                _showDialog(context,index);
//                              },
//                              child: Icon(Icons.edit, size: 30, color: Colors.blue.shade900,),
//                            ),
//                            const SizedBox(width: 10),
//                            InkWell(
//                              onTap: ()async{
//                                        await showDialog(
//                                          context: context,
//                                          builder: (context) => AlertDialog(
//                                            title: Text('Are you sure you want to delete ${userData.name}?'),
//                                            actions: <Widget>[
//                                              TextButton(
//                                                style: ButtonStyle(
//                                                  backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
//                                                  elevation: MaterialStateProperty.all(3),
//                                                  shadowColor: MaterialStateProperty.all(Colors.blue.shade900), //Defines shadowColor
//                                                ),
//                                                onPressed: () {dataStore.deleteUser(index: index);},
//                                                child: const Text('Yes', style: TextStyle(color: Colors.white),
//                                                ),
//                                              ),
//                                              TextButton(
//                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
//                                                  elevation: MaterialStateProperty.all(3),
//                                                  shadowColor: MaterialStateProperty.all(Colors.blue.shade900), //Defines shadowColor
//                                                ),
//                                                onPressed: () {Navigator.of(context, rootNavigator: true).pop(); },
//                                                child: const Text('No',
//                                                  style: TextStyle(color: Colors.white),
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        );
//                                      },
//                                child: Icon(Icons.delete,size:30,color: Colors.blue.shade900,))
//                          ],
//                        )),
//                  ],
//                ),
//              );
//            }):const Center(child: Text("No Data Found"),));
//  }
// )