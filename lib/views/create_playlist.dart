// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:spotify_clone/controllers/user_controller.dart';
// import 'package:spotify_clone/views/views.dart';

// class CreatePlaylist extends StatelessWidget {
//   CreatePlaylist({Key? key}) : super(key: key);
//   final decoration = BoxDecoration(
//       gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           stops: [0.02, 1],
//           colors: [Colors.grey.shade500, Colors.black]));
//   final inputDecoration = InputDecoration(
//       border: UnderlineInputBorder(
//           borderRadius: BorderRadius.zero,
//           borderSide: BorderSide(color: Colors.black)),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10));

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: UserController(),
//       builder: (UserController user) => Scaffold(
//         body: SafeArea(
//           child: Center(
//             child: Container(
//               decoration: decoration,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     createPlaylistTitle,
//                     style: kCreatePlayListTitleStyle,
//                   ),
//                   Container(
//                     margin: kMarginTop10,
//                     height: 100,
//                     child: TextFormField(
//                       textAlign: TextAlign.center,
//                       cursorColor: Colors.grey,
//                       cursorWidth: 1,
//                       cursorHeight: 50,
//                       onChanged: (value) {
//                         user.createPlaylistName = value;
//                         user.update();
//                       },
//                       style: kCreatePlaylistSearchTextStyle,
//                       decoration: inputDecoration,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 40,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: Container(
//                             width: 100,
//                             child: Text(
//                               createPlaylistCancel,
//                               style: kCreatePlayListButtonCancelTextStyle,
//                             )),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           user.createPlaylist();
//                           Get.back();
//                         },
//                         child: Container(
//                             width: 100,
//                             child: Text(
//                               user.createPlaylistName.isEmpty
//                                   ? createPlaylistSkip
//                                   : createPlaylistCreate,
//                               style: kCreatePlayListButtonCreateTextStyle,
//                             )),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
