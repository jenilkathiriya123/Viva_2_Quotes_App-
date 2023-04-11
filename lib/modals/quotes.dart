class Quotes {
  final String quote;
  int? id;

  Quotes({this.id, required this.quote});

  factory Quotes.fromMap({required Map data}) {
    return Quotes(
      quote: data["content"],
    );
  }

  factory Quotes.fromDB({required Map data}) {
    return Quotes(
      quote: data["name"],
    );
  }
}
