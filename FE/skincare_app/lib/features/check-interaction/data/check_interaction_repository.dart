import 'package:skincare_app/core/enums/interaction_level.dart';
import 'package:skincare_app/features/check-interaction/models/check_result.dart';
import 'check_interaction_api.dart';

class CheckInteractionRepository {
  final InteractionApi api = InteractionApi();

  Future<CheckResult> checkInteraction(String first, String second) async {
    try {
      final res = await api.checkInteraction(first, second);
      if (res.statusCode == 200) {
        return CheckResult.fromJson(res.data);
      }
      throw Exception("Failed to check interaction");
    } catch (e) {
      return CheckResult(
        id: "unknown",
        level: InteractionLevel.WARNING,
        message:
            "Chưa có kết quả nào về phản ứng giữa 2 hoạt chất: " +
            first +
            " và " +
            second,
      );
    }
  }
}
