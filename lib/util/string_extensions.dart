extension StringX on String {
  String withParams(Map<String, dynamic> params) {
    var result = this;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }
}
