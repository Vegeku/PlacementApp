// ignore_for_file: must_be_immutable

// import 'package:material.dart';

class Job {
  String name;
  String company;
  DateTime deadline;
  String description;
  String link;

  Job({
    required this.name,
    required this.company,
    required this.deadline,
    required this.description,
    required this.link,
  });

  String getName() {
    return name;
  }

  String getCompany() {
    return company;
  }

  DateTime getDeadline() {
    return deadline;
  }

  String getDescription() {
    return description;
  }

  String getLink() {
    return link;
  }

  void setName(String newName) {
    name = newName;
  }

  void setCompany(String newCompany) {
    company = newCompany;
  }

  void setDaysLeft(DateTime dateUpdate) {
    deadline = dateUpdate;
  }

  void setDescription(String newDescription) {
    name = newDescription;
  }

  void setLink(String newLink) {
    company = newLink;
  }
}
