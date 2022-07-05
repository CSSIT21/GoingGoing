class Filters {
  List<Filter> filters;

  Filters(this.filters);

  Filters.fromJson(List<dynamic> json)
      : filters = json.map((e) => Filter(name: e)).toList();

  List<String> toJson() => getFilterNames(true);

  void setFilter(String key, bool value) {
    filters.firstWhere((el) => el.name == key).value = value;
  }

  List<String> getFilterNames([bool? value]) {
    var list = <String>[];

    if (value != null) {
      list = filters
          .where((el) => value == el.value)
          .map((el) => el.name)
          .toList();
    } else {
      list = filters.map((el) => el.name).toList();
    }

    return list;
  }

  List<bool> getFilterValues([bool? value]) {
    if (value != null) {
      return filters
          .where((el) => value == el.value)
          .map((el) => el.value)
          .toList();
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
