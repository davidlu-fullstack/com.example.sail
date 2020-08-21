class TransformerService {
  static String listToString(List<String> list, String joinObject) {
    return list.join('$joinObject');
  }

  static List<String> stringToList(String object, String joinObject) {
    return object.split(joinObject);
  }
}
