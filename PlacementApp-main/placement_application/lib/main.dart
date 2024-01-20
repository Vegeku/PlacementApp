import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_role_page.dart' as role_form;
import 'job_roles.dart' as r;
import 'data/database.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('roles');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffe8f6ff)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final _myBox = Hive.box('roles');

  // List of jobs a user saved
  RoleDatabase db = RoleDatabase();

  List _foundJobs = [];

  @override
  void initState() {
    if (_myBox.get("ROLES") != null) {
      db.loadData();
      _foundJobs = db.jobs;
    }
    super.initState();
  }

  String tracker(int days) {
    String message = 'you missed the deadline';
    if (days > 0) {
      message = "deadline in $days days";
    }
    return message;
  }

  Color colorPicker(int days) {
    Color colour = const Color(0xffE53D00);
    if (days > 30) {
      colour = const Color(0xff3cdc97);
    } else if (days > 7) {
      colour = const Color(0xffFFE900);
    }
    return colour;
  }

  void deleteTask(int index) {
    setState(() {
      db.jobs.remove(index);
    });

    db.updateDatabase();
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = db.jobs;
    } else {
      results = db.jobs
          .where((user) =>
              user[0].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              user[1].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      _foundJobs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // drawer: NavBar(themeColor: Theme.of(context).colorScheme.primary),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  obscureText: false,
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
                      hintText: "Search for roles or companies",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),
              Expanded(
                flex: 1,
                child: _foundJobs.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: false,
                        physics: const ScrollPhysics(),
                        itemCount: _foundJobs.length,
                        itemBuilder: (content, index) {
                          r.Job role = r.Job(
                            company: _foundJobs[index][0],
                            name: _foundJobs[index][1],
                            deadline: _foundJobs[index][2],
                            description: _foundJobs[index][3],
                            link: _foundJobs[index][4],
                          );

                          return Tooltip(
                              message: 'View and Edit Role',
                              child: GestureDetector(
                                  onTap: () async {
                                    String companyName = _foundJobs[index][0];

                                    String roleName = _foundJobs[index][1];

                                    DateTime date = _foundJobs[index][2];

                                    String description = _foundJobs[index][3];

                                    String link = _foundJobs[index][4];

                                    final roleInfo = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                role_form.RoleForm(
                                                  companyName: companyName,
                                                  roleName: roleName,
                                                  date: date,
                                                  description: description,
                                                  link: link,
                                                )));
                                    setState(() {
                                      db.jobs[index][0] = roleInfo[0];
                                      db.jobs[index][1] = roleInfo[1];
                                      db.jobs[index][2] = roleInfo[2];
                                      db.jobs[index][3] = roleInfo[3];
                                      db.jobs[index][4] = roleInfo[4];

                                      role.setCompany(roleInfo[0]);
                                      role.setName(roleInfo[1]);
                                      role.setDaysLeft(roleInfo[2]);
                                      role.setDescription(roleInfo[3]);
                                      role.setLink(roleInfo[4]);
                                    });
                                    db.updateDatabase();
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.all(7),
                                    color: const Color(0xffe5f3fc),
                                    shadowColor: const Color(0xff000000),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: 65,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: colorPicker(
                                            role.getDeadline().difference(DateTime.now()).inDays + 1,
                                          ),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(500.0),
                                          border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          tracker(
                                            role.getDeadline().difference(DateTime.now()).inDays + 1,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      title: Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              role.getCompany(),
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 2, 0, 16),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              role.getName(),
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                color: Color(0xff6a6969),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      trailing: SizedBox(
                                        width: 126,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(Icons.delete, color: Colors.black),
                                                        onPressed: () {
                                                          setState(() {
                                                            db.jobs.removeAt(index);
                                                          });

                                                          db.updateDatabase();
                                                        },
                                                        tooltip: 'Delete Role',
                                                        iconSize: MediaQuery.of(context).size.width * 0.03, // Adjust the multiplier as needed
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(Icons.open_in_browser, color: Colors.black),
                                                        onPressed: () async {
                                                          var url = Uri.parse(role.getLink());
                                                          if (await canLaunchUrl(url)) {
                                                            await launchUrl(url, mode: LaunchMode.inAppWebView,);
                                                          } else {
                                                            // ignore: use_build_context_synchronously
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                                                  content: const SizedBox(
                                                                    height: 120,
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        Text(
                                                                          "Link not working or empty field. Edit the advert",
                                                                          style: TextStyle(
                                                                            fontWeight: FontWeight.w700,
                                                                            fontStyle: FontStyle.normal,
                                                                            fontSize: 16,
                                                                            color: Color(0xfffffffff),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                        tooltip: "Click to view job description's website",
                                                        iconSize: MediaQuery.of(context).size.width * 0.03, // Adjust the multiplier as needed
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )));
                        })
                    : const Center(child: Text('No roles')),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final roleInfo =
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => role_form.RoleForm(
                            companyName: '',
                            roleName: '',
                            date: DateTime.now(),
                            description: '',
                            link: '',
                          )));
              if (roleInfo.length >= 3) {
                setState(() {
                  db.jobs.add(roleInfo);
                });
                db.updateDatabase();
              }
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            tooltip: 'Add Role',
            child: const Icon(Icons.add, color: Colors.black),
          ),
        ));
  }
}
