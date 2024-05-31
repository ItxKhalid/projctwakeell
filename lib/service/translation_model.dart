class TranslationModel {
  final String languageName;
  final String countryName;

  TranslationModel({required this.languageName, required this.countryName});
}

List<TranslationModel> translationList = [
  TranslationModel(languageName: "en", countryName: "UK"),
  TranslationModel(languageName: "ur", countryName: "PK"),
];