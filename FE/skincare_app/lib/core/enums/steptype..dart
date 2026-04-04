enum StepType {
  remover,
  cleanser,
  toner,
  serum,
  moisturizer,
  sunscreen,
  retinol,
  treatment
}

StepType parseStepType(String type) {
  return StepType.values.firstWhere(
    (e) => e.name.toUpperCase() == type,
  );
}