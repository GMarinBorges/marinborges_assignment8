class Course {
  final String id;
  final String fname;
  final String lname;
  final String studentID;
  final String dateEntered;

  Course._(this.id, this.fname, this.lname, this.studentID, this.dateEntered);

  factory Course.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final fname = json['fname'];
    final lname = json['lname'];
    final studentID = json['studentID'];
    final dateEntered = json['dateEntered'];

    return Course._(id, fname, lname, studentID, dateEntered);
  }
}
