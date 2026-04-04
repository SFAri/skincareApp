enum RoutineTime { MORNING, NIGHT }

RoutineTime routineTimeFromString(String value) {
  return RoutineTime.values.firstWhere(
    (e) => e.name == value,
    orElse: () => RoutineTime.MORNING,
  );
}

String routineTimeToString(RoutineTime time) {
  return time.name;
}