import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widget.dart';

class RoleForm extends StatefulWidget {
  String companyName;
  String roleName;
  DateTime date;
  String description;
  String link;

  RoleForm({
    super.key,
    required this.companyName,
    required this.roleName,
    required this.date,
    required this.description,
    required this.link,
  });

  @override
  State<RoleForm> createState() => _MyFormState();
}

class _MyFormState extends State<RoleForm> {
  final _company = TextEditingController();
  final _role = TextEditingController();
  final _description = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  final _link = TextEditingController();
  int daysleft = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.companyName != "") {
      _company.text = widget.companyName;
    }

    if (widget.roleName != "") {
      _role.text = widget.roleName;
    }

    if (widget.description != "") {
      _description.text = widget.description;
    }

    if (widget.link != "") {
      _link.text = widget.link;
    }

    setState(() {
      if ((widget.date).toString().split(" ")[0] !=
          (DateTime.now()).toString().split(" ")[0]) {
        datecontroller.text = DateFormat().add_yMMMEd().format(widget.date);
        daysleft = widget.date.difference(DateTime.now()).inDays + 1;
      }
    });

    void showSuccessMessage(String message) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void onCancel() {
      Navigator.of(context).pop();
    }

    void onSave() {
      if (_company.text != "" &&
          _role.text != "" &&
          datecontroller.text  != "" &&
          _description.text == "" &&
          _link.text == "") {
        Navigator.of(context)
            .pop([_company.text, _role.text, widget.date, "", ""]);
      } else if (_company.text != "" &&
          _role.text != "" &&
          datecontroller.text  != "" &&
          _description.text == "" &&
          _link.text != "") {
        Navigator.of(context)
            .pop([_company.text, _role.text, widget.date, "", _link.text]);
      } else if (_company.text != "" &&
          _role.text != "" &&
          datecontroller.text  != "" &&
          _description.text != "" &&
          _link.text == "") {
        Navigator.of(context).pop(
            [_company.text, _role.text, widget.date, _description.text, ""]);
      } else if (_company.text != "" &&
          _role.text != "" &&
          datecontroller.text  != "" &&
          _description.text != "" &&
          _link.text != "") {
        Navigator.of(context).pop([
          _company.text,
          _role.text,
          widget.date,
          _description.text,
          _link.text
        ]);
      } else {
        showSuccessMessage('Failed. Check if you filled everything required');
      }
    }

    Future<void> selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.date,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 36500)),
      );

      if (picked != null) {
        setState(() {
          widget.date = picked;
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xffe8f6ff),
      appBar: AppBar(
        title: const Text(
          "Form",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xffffffff),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(0),
              shrinkWrap: false,
              physics: const ScrollPhysics(),
              children: [
                RequiredFormSection(
                  name: "Company Name",
                  controller: _company,
                ),
                RequiredFormSection(name: "Role Name", controller: _role),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: TextField(
                    controller: datecontroller,
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
                      prefixIcon: const Icon(Icons.calendar_today),
                      filled: true,
                      labelText: "Application deadline",
                      helperText: "*deadline required",
                      helperStyle: const TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      selectDate();
                    },
                    readOnly: true,
                  ),
                ),
                FormSection(name: "Description", controller: _description),
                FormSection(name: "Link", controller: _link),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MyButton(name: "Save", onPressed: onSave),
            const SizedBox(
              width: 4,
            ),
            MyButton(name: "Cancel", onPressed: onCancel),
          ]),
        ],
      ),
    );
  }
}
