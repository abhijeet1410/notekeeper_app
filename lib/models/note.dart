class Note {
  int? _id;
  String? _title;
  String? _description;
  String? _date;
  int? _priority;

  Note(this._id, this._title, this._description, this._date, this._priority);

  int? get id => _id;
  String? get title => _title;

  // String? getTitle() {
  //   return this._title;
  // }

  String? get description => _description;
  String? get date => _date;
  int? get priority => _priority;

  set title(String? newTitle){
    this._title = newTitle;
  }

  // void setTitle(String? newTitle) {
  //   this._title = newTitle;
  // }

  set description(String? newDescription) {
    this._description = newDescription;
  }

  set priority(int? priority) {
    this._priority = priority;
  }

  set date(String? newDate) {
    this._date = date;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['priority'] = _priority;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._priority = map['priority'];
  }

}