class SuggestionPlace {
  final String placeId;
  final String description;

  const SuggestionPlace(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
