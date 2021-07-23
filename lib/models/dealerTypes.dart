import 'dart:math';

import 'package:panache/models/paintColor.dart';

class DealerTypes {
  String type;
  int stock;
  int sold;

  DealerTypes(
    String type,
    int stock,
    int sold,
  ) {
    this.type = type;
    this.stock = stock;
    this.sold = sold;
  }
}

List<DealerTypes> dealerTypes = List<DealerTypes>.empty(growable: true);

void initDealerTypes() {
  dealerTypes.addAll(types.map((t) {
    return DealerTypes(t, Random().nextInt(10000), Random().nextInt(10000));
  }));
}
