enum Role { USER, ADMIN }

Role roleFromString(String value) {
  return Role.values.firstWhere(
    (e) => e.name == value,
    orElse: () => Role.USER,
  );
}

String roleToString(Role role) {
  return role.name;
}