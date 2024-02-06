class nutrition {
  Header? header;
  Body? body;

  nutrition({this.header, this.body});

  nutrition.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Header {
  String? resultCode;
  String? resultMsg;

  Header({this.resultCode, this.resultMsg});

  Header.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    return data;
  }
}

class Body {
  int? pageNo;
  int? totalCount;
  int? numOfRows;
  List<Items>? items;

  Body({this.pageNo, this.totalCount, this.numOfRows, this.items});

  Body.fromJson(Map<String, dynamic> json) {
    pageNo = json['pageNo'];
    totalCount = json['totalCount'];
    numOfRows = json['numOfRows'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNo'] = this.pageNo;
    data['totalCount'] = this.totalCount;
    data['numOfRows'] = this.numOfRows;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? dESCKOR;
  String? sERVINGWT;
  String? nUTRCONT1;
  String? nUTRCONT2;
  String? nUTRCONT3;
  String? nUTRCONT4;
  String? nUTRCONT5;
  String? nUTRCONT6;
  String? nUTRCONT7;
  String? nUTRCONT8;
  String? nUTRCONT9;
  String? bGNYEAR;
  String? aNIMALPLANT;

  Items(
      {this.dESCKOR,
      this.sERVINGWT,
      this.nUTRCONT1,
      this.nUTRCONT2,
      this.nUTRCONT3,
      this.nUTRCONT4,
      this.nUTRCONT5,
      this.nUTRCONT6,
      this.nUTRCONT7,
      this.nUTRCONT8,
      this.nUTRCONT9,
      this.bGNYEAR,
      this.aNIMALPLANT});

  Items.fromJson(Map<String, dynamic> json) {
    dESCKOR = json['DESC_KOR'];
    sERVINGWT = json['SERVING_WT'];
    nUTRCONT1 = json['NUTR_CONT1'];
    nUTRCONT2 = json['NUTR_CONT2'];
    nUTRCONT3 = json['NUTR_CONT3'];
    nUTRCONT4 = json['NUTR_CONT4'];
    nUTRCONT5 = json['NUTR_CONT5'];
    nUTRCONT6 = json['NUTR_CONT6'];
    nUTRCONT7 = json['NUTR_CONT7'];
    nUTRCONT8 = json['NUTR_CONT8'];
    nUTRCONT9 = json['NUTR_CONT9'];
    bGNYEAR = json['BGN_YEAR'];
    aNIMALPLANT = json['ANIMAL_PLANT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DESC_KOR'] = this.dESCKOR;
    data['SERVING_WT'] = this.sERVINGWT;
    data['NUTR_CONT1'] = this.nUTRCONT1;
    data['NUTR_CONT2'] = this.nUTRCONT2;
    data['NUTR_CONT3'] = this.nUTRCONT3;
    data['NUTR_CONT4'] = this.nUTRCONT4;
    data['NUTR_CONT5'] = this.nUTRCONT5;
    data['NUTR_CONT6'] = this.nUTRCONT6;
    data['NUTR_CONT7'] = this.nUTRCONT7;
    data['NUTR_CONT8'] = this.nUTRCONT8;
    data['NUTR_CONT9'] = this.nUTRCONT9;
    data['BGN_YEAR'] = this.bGNYEAR;
    data['ANIMAL_PLANT'] = this.aNIMALPLANT;
    return data;
  }
}
