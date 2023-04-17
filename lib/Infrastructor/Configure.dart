class Configures {
  int? iD;
  String? kEYWORD;
  String? dESC;
  int? eNABLE;
  int? vISIBLE;
  String? vALUE;
  String? uNITTYPE;
  String? gROUPTYPE;
  int? sTATUS;

  Configures(
      {this.iD,
      this.kEYWORD,
      this.dESC,
      this.eNABLE,
      this.vISIBLE,
      this.vALUE,
      this.uNITTYPE,
      this.gROUPTYPE,
      this.sTATUS});

  Configures.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    kEYWORD = json['KEYWORD'];
    dESC = json['DESC'];
    eNABLE = json['ENABLE'];
    vISIBLE = json['VISIBLE'];
    vALUE = json['VALUE'];
    uNITTYPE = json['UNIT_TYPE'];
    gROUPTYPE = json['GROUP_TYPE'];
    sTATUS = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['KEYWORD'] = this.kEYWORD;
    data['DESC'] = this.dESC;
    data['ENABLE'] = this.eNABLE;
    data['VISIBLE'] = this.vISIBLE;
    data['VALUE'] = this.vALUE;
    data['UNIT_TYPE'] = this.uNITTYPE;
    data['GROUP_TYPE'] = this.gROUPTYPE;
    data['STATUS'] = this.sTATUS;
    return data;
  }
}
