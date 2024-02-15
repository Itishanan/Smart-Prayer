class AyaoftheDay {
  final String? arText;
  final String? enTran;
  final String? surEnName;
  final int? surNumber;

  AyaoftheDay({this.arText, this.enTran, this.surEnName, this.surNumber});

  factory AyaoftheDay.fromJSON(Map<String, dynamic> json){
    return AyaoftheDay(
        arText:json['data'][0]['text'],
        enTran:json['data'][2]['text'],
        surNumber:json['data'][2]['numberInSurah'],
        surEnName:json['data'][2]['surah']['englishName']
    );
  }
}