import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/name_list.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  @override
  State<SearchBar> createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> {
  late Icon _searchIcon;
  late Widget _title;

  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  NameList nameList = NameList();
  late List<Name> _list;
  late bool _isSearching;
  String _searchText = "";
  List searchresult = [];

  _SearchBarState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    _searchIcon = const Icon(Icons.search_sharp);
    _title = const Text('Noun');
    _list = nameList.getList();
    _isSearching = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _title,
      centerTitle: true,
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
            onPressed: () {
              //print('called');
              setState(() {
                if (_searchIcon.icon == Icons.search_sharp) {
                  // print('if');
                  _searchIcon = const Icon(Icons.cancel);
                  _title = const ListTile(
                      leading: Icon(
                        Icons.search_sharp,
                        color: Colors.white10,
                        size: 28,
                      ),
                      title: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Search a noun..',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white),
                        //onChanged: searchOperation(_searchText),
                      ));
                  setState(() {
                    _isSearching = true;
                  });
                } else {
                  _searchIcon = const Icon(Icons.search_sharp);
                  _title = const Text('Noun');
                }
              });
            },
            icon: _searchIcon)
      ],
    );
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String textData = _list[i].text;
        if (textData.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(textData);
        }
      }
    }
  }
}

// class MyAppBar extends AppBar {
//   const MyAppBar({key key, Widget title})
//       : super(
//           key: key,
//           title: title,
//         );
// }
