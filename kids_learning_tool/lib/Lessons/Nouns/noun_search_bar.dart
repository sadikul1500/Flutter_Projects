import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/name_list.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';

// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   String? _result;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Search...')),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Text(_result ?? '', style: const TextStyle(fontSize: 18)),
//             ElevatedButton(
//               onPressed: () async {
//                 var result = await showSearch<String>(
//                   context: context,
//                   delegate: CustomDelegate(),
//                 );
//                 setState(() => _result = result);
//               },
//               child: const Text('Search'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomDelegate extends SearchDelegate<String> {
  NameList nameList = NameList();
  List<String> data = [];
  List<Name> names = [];

  CustomDelegate() {
    names = nameList.getList();
    for (final e in names) {
      data.add(e.text);
    }
    print('reached');
  }

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> listToShow;
    if (query.isNotEmpty) {
      listToShow = data
          .where((e) =>
              e.toLowerCase().contains(query.toLowerCase()) &&
              e.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    } else {
      listToShow = data;
    }

    return ListView.builder(
      itemCount: listToShow.length,
      itemBuilder: (_, i) {
        var noun = listToShow[i];
        return ListTile(
          title: Text(noun),
          onTap: () => close(context, noun),
        );
      },
    );
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:kids_learning_tool/Lessons/Nouns/name_list.dart';
// import 'package:kids_learning_tool/Lessons/Nouns/names.dart';

// class SearchNoun extends StatefulWidget {
//   //with PreferredSizeWidget
//   @override
//   State<SearchNoun> createState() => _SearchNounState();

//   //@override
//   //Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _SearchNounState extends State<SearchNoun> {
//   //late Icon _searchIcon;
//   //late Widget _title;

//   final globalKey = GlobalKey<ScaffoldState>();
//   final TextEditingController _controller = TextEditingController();
//   final dio = Dio();
//   NameList nameList = NameList();
//   late List<Name> _list;
//   //late bool _isSearching;
//   String _searchText = "";
//   late List<Name> _searchresult;
//   List<Name> _showNames = [];

//   _SearchNounState() {
//     _controller.addListener(() {
//       if (_controller.text.isEmpty) {
//         setState(() {
//           _searchText = "";
//           _list = _showNames;
//         });
//       } else {
//         setState(() {
//           _searchText = _controller.text;
//         });
//       }
//     });
//   }

//   @override
//   void initState() {
//     //_searchIcon = const Icon(Icons.search_sharp);
//     //_title = const Text('Noun');
//     _list = nameList.getList();
//     // _isSearching = false;
//     _searchOperation();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _myAppBar(context),
//       body: Container(
//         child: _buildList(),
//       ),
//       resizeToAvoidBottomInset: false,
//     );
//   }

//   Widget _buildList() {
//     if (!(_searchText.isEmpty)) {
//       late List tempList; // = new List();
//       for (int i = 0; i < _showNames.length; i++) {
//         if (_showNames[i]
//             .text
//             .toLowerCase()
//             .contains(_searchText.toLowerCase())) {
//           _searchresult.add(_showNames[i]);
//         }
//       }
//       _list = _searchresult;
//     }
//     return ListView.builder(
//       itemCount: _showNames == null ? 0 : _list.length,
//       itemBuilder: (BuildContext context, int index) {
//         return new ListTile(
//           title: Text(_list[index].text),
//           onTap: () => print(_list[index].text),
//         );
//       },
//     );
//   }

//   AppBar _myAppBar(BuildContext context) {
//     return AppBar(
//       title: const ListTile(
//           leading: Icon(
//             Icons.search_sharp,
//             color: Colors.white10,
//             size: 28,
//           ),
//           title: TextField(
//             cursorColor: Colors.black,
//             decoration: InputDecoration(
//               hintText: 'Search a noun..',
//               hintStyle: TextStyle(
//                 color: Colors.white,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: InputBorder.none,
//             ),
//             style: TextStyle(color: Colors.white),
//             //onChanged: searchOperation(_searchText),
//           )),
//       centerTitle: true,
//     );
//   }

//   void _searchOperation() async {
//     final response = await dio.get('https://swapi.co/api/people');
//     print(response);
//     List _tempList = []; // = new List();
//     for (int i = 0; i < response.data['results'].length; i++) {
//       _tempList.add(response.data['results'][i]);
//     }
//     setState(() {
//       _showNames = _searchresult;
//       _showNames.shuffle();
//       _list = _showNames;
//     });
//   }
// }

// // /_title = const ListTile(

// // void searchOperation(String searchText) {
// //   searchresult.clear();
// //   if (_isSearching != null) {
// //     for (int i = 0; i < _list.length; i++) {
// //       String textData = _list[i].text;
// //       if (textData.toLowerCase().contains(searchText.toLowerCase())) {
// //         searchresult.add(textData);
// //       }
// //     }
// //   }
// // }

// //AppBar:
// // title: _title,
// // centerTitle: true,
// // automaticallyImplyLeading: true,
// // actions: [
// //   IconButton(
// //       onPressed: () {
// //         //print('called');
// //         setState(() {
// //           if (_searchIcon.icon == Icons.search_sharp) {
// //             // print('if');
// //             _searchIcon = const Icon(Icons.cancel);

// // setState(() {
// //   _isSearching = true;
// // });
// // } else {
// //   _searchIcon = const Icon(Icons.search_sharp);
// //   _title = const Text('Noun');
// // }
// //         });
// //       },
// //       icon: _searchIcon)
// // ],
