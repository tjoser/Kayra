import 'dart:developer';

String replaceTurkishLetters(String input) {
  final Map<String, String> replacements = {
    'ç': 'c',
    'ğ': 'g',
    'ı': 'i',
    'i': 'i',
    'ö': 'o',
    'ş': 's',
    'ü': 'u',
    'Ç': 'C',
    'Ğ': 'G',
    'I': 'I',
    'İ': 'I',
    'Ö': 'O',
    'Ş': 'S',
    'Ü': 'U',
  };

  try {
    for (var entry in replacements.entries) {
      input = input.replaceAll(entry.key, entry.value);
    }
  } catch (e) {
    print('An error occurred in replaceTurkishLetters: $e');
  }

  return input;
}

List<String> divideStringIntoFourEqualParts(String input) {
  try {
    log(input);
    List<String> words = input.split(" ");
    int wordCount = words.length;
    int splitIndex1 = (wordCount / 4).floor();
    int splitIndex2 = 2 * (wordCount / 4).floor();
    int splitIndex3 = 3 * (wordCount / 4).floor();

    String firstPart = words.sublist(0, splitIndex1).join(" ");
    String secondPart = words.sublist(splitIndex1, splitIndex2).join(" ");
    String thirdPart = words.sublist(splitIndex2, splitIndex3).join(" ");
    String fourthPart = words.sublist(splitIndex3).join(" ");

    return [firstPart, secondPart, thirdPart, fourthPart];
  } catch (e) {
    print("An error occurred in divideStringIntoFourEqualParts: $e");
    return ["Error", "Error", "Error", "Error"];
  }
}
