class Record{
  int humAr;
  int humSolo;
  int tempAr;
  int luz;
  bool maduro;
  DateTime data;

  Record(this.humAr, this.humSolo, this.tempAr, this.luz, this.maduro, this.data);

  @override
  String toString() {
    return 'Record{humAr: $humAr, humSolo: $humSolo, tempAr: $tempAr, luz: $luz, maduro: $maduro, data: $data}';
  }
}