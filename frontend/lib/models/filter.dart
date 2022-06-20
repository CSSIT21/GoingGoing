class Filters {
  static const _filters = [
    "Woman Only",
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
            return Filter(name: e, value: true);
          } else {
            return Filter(name: e, value: false);
          }
        }).toList();

  List<String> toJson() => filters.where((el) => true == el.value).map((el) => el.name).toList();

  void setFilter(String key, bool value) {
    filters.firstWhere((el) => el.name == key).value = value;
  }
}

class Filter {
  String name;
  bool value;

  Filter({
    required this.name,
    this.value = false,
  });
}
