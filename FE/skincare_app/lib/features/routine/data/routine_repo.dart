import 'package:skincare_app/features/routine/data/routine_api.dart';
import 'package:skincare_app/features/routine/models/routine.dart';

class RoutineRepo {
  final RoutineApi api = RoutineApi();

  Future<List<Routine>> getAll() async {
    try {
      final res = await api.getAll();
      if (res.statusCode == 200) {
        List<Routine> routines = (res.data as List)
            .map((routine) => Routine.fromJson(routine))
            .toList();
        return routines;
      } else {
        throw Exception("Failed to load routines");
      }
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  Future<Routine> getById(String id) async {
    final res = await api.getById(id);
    return Routine.fromJson(res.data);
  }

  // Save routine
  Future<bool> saveRoutine(String id) async {
    try {
      final res = await api.saveRoutine(id);
      if (res.statusCode == 201) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  // Unsave routine
  Future<bool> unSaveRoutine(String id) async {
    try {
      final res = await api.unSaveRoutine(id);
      if (res.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return true;
  }
}
