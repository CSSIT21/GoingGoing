class Filters {
  static const _filters = [
    "Women Only",
    "Child in Car",
    "Family Car",
    "Elder in Car",
    "20 Years Old Up"
  ];
  List<Filter> filters;

  Filters(this.filters);

  Filters.fromJson(List<String> json)
      : filters = json.map((e) {
          if (_filters.contains(e)) {
            return Filter(name: e);
          } else {
            return Filter(name: e, value: false);
          }
        }).toList();

  List<String> toJson() => getFilterNames(true);

  void setFilter(String key, bool value) {
    filters.firstWhere((el) => el.name == key).value = value;
  }

  List<String> getFilterNames([bool? value]) {
    var list = <String>[];

    if (value != null) {
      list = filters.where((el) => value == el.value).map((el) => el.name).toList();
      print("list: $list");
    } else {
      list = filters.map((el) => el.name).toList();
    }

    if (list.isEmpty) {
      return ['-'];
    } else {
      return list;
    }
  }

  List<bool> getFilterValues([bool? value]) {
    if (value != null) {
      return filters.where((el) => value == el.value).map((el) => el.value).toList();
    } else {
      return filters.map((el) => el.value).toList();
    }
  }
}

class Filter {
  String name;
  bool value;

  Filter({
    required this.name,
    this.value = true,
  });
}
