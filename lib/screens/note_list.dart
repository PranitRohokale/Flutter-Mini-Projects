// import 'package:flutter/material.dart';
// import 'package:notekeeper/database/database_helper.dart';
// import 'package:notekeeper/screens/note_details.dart';

// class note_list extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _note_listState();
//   }
// }

// class _note_listState extends State<note_list> {
//   int _count = 10;

//   //constructure
//   _note_listState() {
//     // List<Map<String, dynamic>> rows = DatabaseHelper.instance.selectAll();
//     // setState(() {
//     //   this._count = rows.length;
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Note Keeper"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(5.5),
//         child: Container(
//           child: getNoteListView(),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         tooltip: "Add new Note",
//         onPressed: () async {
//           // print(await DatabaseHelper.instance.insert({
//           // DatabaseHelper.ColoumTitle: "Dsa",
//           // DatabaseHelper.ColoumDescription: "Data Structure Adn Algorithm"
//           // }));
//           List<Map<String, dynamic>> rows =
//               await DatabaseHelper.instance.selectAll();
//           setState(() {
//             this._count = rows.length;
//           });
//           print(await DatabaseHelper.instance.selectAll());
//           navigateToDetails("Add note");
//         },
//       ),
//     );
//   }

//   getListData() {
//     var list = List.generate(500, (index) => "note $index");
//     return list;
//   }

//   getNoteListView() {
//     return ListView.builder(
//       itemCount: _count,
//       itemBuilder: (context, index) {
//         return Card(
//           color: Colors.amber.shade100,
//           elevation: 2,
//           child: ListTile(
//             leading: CircleAvatar(
//               child: Icon(Icons.keyboard_arrow_right_sharp),
//               backgroundColor: Colors.yellowAccent,
//             ),
//             trailing: IconButton(
//                 icon: Icon(Icons.delete_forever_sharp),
//                 onPressed: () {
//                   print("delete");
//                 }),
//             onTap: () {
//               print("note $index tapped");
//               navigateToDetails("Edit Note");
//             },
//           ),
//         );
//       },
//     );
//   }

//   void navigateToDetails(String title) {
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return NoteDetails(title);
//     }));
//   }
// }
