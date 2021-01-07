class Package {
  final String name;
  final double price;
  final Map<String, num> channels;

  Package({this.name, this.price, this.channels});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      name: json['name'],
      price: json['price'],
      channels: json['channels'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'price': this.price,
      'channels': this.channels,
    };
  }
}
