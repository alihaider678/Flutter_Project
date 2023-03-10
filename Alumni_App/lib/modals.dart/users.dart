class MyUser {
  String uid;
  String name;
  String tag;
  String email;
  String username;
  String course;
  String branch;
  String rollNumber;
  String startingYear;
  String endingYear;
  String SubAdmin;
  String Number;
  String skill;
  List<String> chattingPartners;

  MyUser({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.course,
    this.branch,
    this.tag,
    this.rollNumber,
    this.endingYear,
    this.startingYear,
    this.chattingPartners,
    this.SubAdmin,
    this.Number,
    this.skill,
  });

  Map toMap(MyUser myUser) {
    var data = Map<String, dynamic>();
    data['uid'] = myUser.uid;
    data['name'] = myUser.name;
    data['email'] = myUser.email;
    data['tag'] = myUser.tag;
    data['MyUsername'] = myUser.username;
    data["course"] = myUser.course;
    data["branch"] = myUser.branch;
    data["rollNumber"]=myUser.rollNumber;
    data["startingYear"]=myUser.startingYear;
    data["endingYear"]=myUser.endingYear;
    data["chattingPartners"]=myUser.chattingPartners;
    data["SubAdmin"]=myUser.SubAdmin;
    data["Number"]=myUser.Number;
    data["Skill"]=myUser.skill;
    return data;
  }

  MyUser.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.tag = mapData['tag'];
    this.username = mapData['MyUsername'];
    this.course=mapData["course"];
    this.branch=mapData["branch"];
    this.rollNumber=mapData["rollNumber"];
    this.startingYear=mapData["startingYear"];
    this.endingYear=mapData["endingYear"];
    this.chattingPartners=mapData["chattingPartners"];
    this.SubAdmin=mapData["SubAdmin"];
    this.Number=mapData["Number"];
    this.skill=mapData["Skill"];
  }
}