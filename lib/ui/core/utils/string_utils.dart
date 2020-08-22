import 'package:helper_widgets/string_utils/string_utils.dart' as utils;

class StringUtils {
  static String toTitleCase(String sentence) {
    if (utils.StringUtils.isEmpty(sentence)) return '';

    if (sentence == null) return '';
    var split = sentence.split(' ');

    if (split.isEmpty) return '';

    return split
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .toList()
        .join(" ");
  }
}
