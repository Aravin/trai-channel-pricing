class Channel {
  final int id;
  final String name;
  final String broadcaster;
  final String lang;
  final double cost;
  final String genre;
  final String streamType;
  final String airtel;
  final String dishTv;
  final String sunDirect;
  final String tataSky;
  final String d2h;

  Channel({
    this.id,
    this.name,
    this.broadcaster,
    this.lang,
    this.cost,
    this.genre,
    this.streamType,
    this.airtel,
    this.dishTv,
    this.sunDirect,
    this.tataSky,
    this.d2h,
  });

  factory Channel.fromJSON(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      name: json['name'],
      broadcaster: json['broadcaster'],
      lang: json['lang'],
      cost: json['cost'],
      genre: json['genre'],
      streamType: json['streamType'],
      airtel: json['airtel'],
      dishTv: json['dishTv'],
      sunDirect: json['sunDirect'],
      tataSky: json['tataSky'],
      d2h: json['d2h'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'broadcaster': broadcaster,
      'lang': lang,
      'cost': cost,
      'genre': genre,
      'streamType': streamType,
      'airtel': airtel,
      'dishTv': dishTv,
      'sunDirect': sunDirect,
      'tataSky': tataSky,
      'd2h': d2h,
    };
  }
}
