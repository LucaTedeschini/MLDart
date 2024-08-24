class LabelEncoder {
  var converter = Map<String, int>();
  LabelEncoder();
  void fit(List labels) {
    for (String ele in labels) {
      if (!this.converter.containsKey(ele)) {
        this.converter[ele] = this.converter.length + 1;
      }
    }
  }

  List transform(List labels) {
    if (this.converter.length == 0) {
      throw Exception("You must fit the LE first");
    }
    var encoded = [];
    for (String ele in labels) {
      if (this.converter.containsKey(ele)) {
        encoded.add(this.converter[ele]);
      } else {
        throw Exception("Found a label without a correspondence");
      }
    }
    return encoded;
  }

  List transform_reverse(List labels) {
    if (this.converter.length == 0) {
      throw Exception("You must fit the LE first");
    }

    var decoded = [];
    for (int ele in labels) {
      if (this.converter.containsValue(ele)) {
        decoded.add(
            this.converter.keys.firstWhere((k) => this.converter[k] == ele));
      } else {
        throw Exception("Found a label without a correspondence");
      }
    }
    return decoded;
  }
}
