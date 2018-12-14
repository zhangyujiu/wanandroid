class ResultData {
  int errorCode;
  String errorMsg;
  var data;

  ResultData.fromJson(Map<String, dynamic> json)
      : errorCode = json["errorCode"],
        errorMsg = json["errorMsg"],
        data = json["data"];

  Map<String, dynamic> toJson() => {
    "code": errorCode,
    "errorMsg": errorMsg,
    "data": data,
  };
}
