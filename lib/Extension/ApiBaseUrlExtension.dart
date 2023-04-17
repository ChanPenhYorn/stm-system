extension apiBaseUrlExtension on Map<String, dynamic> {
  String toParamQuery() {
    String params = '';
    var entry = this.keys.toList();
    entry.forEach((e) => {
          if (this[e] != null && this[e] != '')
            {
              params += '${e}=${this[e]}&',
            }
        });
    params = params.substring(0, params.length - 1);
    return params;
  }
}
