class Status {
  int _statusCode;
  int _dbSize;

  Status(this._statusCode, this._dbSize);

  Status.map(dynamic obj) {
    this._statusCode = obj["status_code"];
    this._dbSize = obj["db_size"];
  }

  int get statusCode => _statusCode;
  int get dbSize => _dbSize;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["status_code"] = _statusCode;
    map["db_size"] = _dbSize;
    return map;
  }

}