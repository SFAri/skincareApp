enum InteractionLevel {
  GOOD,
  WARNING,
  AVOID,
}

InteractionLevel interactionLevelFromString(String value) {
  return InteractionLevel.values.firstWhere(
    (e) => e.name == value,
    orElse: () => InteractionLevel.WARNING,
  );
}

String interactionLevelToString(InteractionLevel level) {
  return level.name;
}