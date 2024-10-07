import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: const EdgeInsets.only(
        left: 20,
      ),
      height: 45,
      decoration: const BoxDecoration(
        color: Color(0xFF93B1A6),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: TextField(
        textAlign: TextAlign.left,
        onChanged: (v) {},
        onSubmitted: (v) async {},
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 5),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: null,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black87,
            onPressed: () {},
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
