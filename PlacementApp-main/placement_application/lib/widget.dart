import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  final String name;
  final TextEditingController controller;

  const FormSection({
    super.key,
    required this.name,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: TextField(
        controller: controller,
        maxLines: null,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue.shade600),
          ),
          fillColor: const Color(0xffffffff),
          filled: true,
          labelText: name,
        ),
      ),
    );
  }
}

class RequiredFormSection extends StatelessWidget {
  final String name;
  final TextEditingController controller;

  const RequiredFormSection({
    super.key,
    required this.name,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: TextField(
        controller: controller,
        maxLines: null,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue.shade600),
          ),
          fillColor: const Color(0xffffffff),
          filled: true,
          labelText: name,
          helperText: "*$name required",
          helperStyle: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.primary,
      child: Text(name),
    );
  }
}

class SearchField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  const SearchField({
    super.key,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            fillColor: const Color(0xfff6fbff),
            filled: true,
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.grey[500],
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final Color themeColor;

  const NavBar({
    Key? key,
    required this.themeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      UserAccountsDrawerHeader(
        accountName: const Text(
          "Nadim Bakhshov",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xffffffff),
          ),
        ),
        accountEmail: const Text(
          "mammamia@gmail.com",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xffffffff),
          ),
        ),
        decoration: BoxDecoration(
          color: themeColor,
        ),
      ),
      const ListTile(
        leading: Icon(Icons.home, color: Colors.black),
        title: Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
      ),
      const ListTile(
        leading: Icon(Icons.notifications, color: Colors.black),
        title: Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
      ),
      const ListTile(
        leading: Icon(Icons.settings, color: Colors.black),
        title: Text(
          "About",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
      ),
      const ListTile(
        leading: Icon(Icons.logout, color: Colors.black),
        title: Text(
          "Sign out",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
        // onTap: () => print("Log out")
      )
    ]));
  }
}
