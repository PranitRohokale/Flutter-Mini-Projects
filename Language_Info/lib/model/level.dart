class Leval {
  int _id;
  int _leval;

  Leval(this._leval);
  Leval.withId(this._id, this._leval);

  int get id => _id;
  int get leval => _leval;

  // converting level object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) map['id'] = _id;

    map['leval'] = _leval;

    return map;
  }

  //extract a Leval object to class object
  Leval.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._leval = map['leval'];
  }
}
