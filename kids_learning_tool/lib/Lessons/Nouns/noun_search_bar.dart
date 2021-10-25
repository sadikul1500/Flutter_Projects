import 'package:flutter/material.dart';
//import 'dart:async';

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> {
  late Icon _searchIcon;
  late Widget _title;
  @override
  void initState() {
    _searchIcon = const Icon(Icons.search_sharp);
    _title = const Text('Noun');
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
                      ));
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

  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// class MyAppBar extends AppBar {
//   const MyAppBar({key key, Widget title})
//       : super(
//           key: key,
//           title: title,
//         );
// }
