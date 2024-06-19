import 'package:instagram_planner/inspiration/data/inspiration_model.dart';

abstract class InspirationRepo {
  Future<List<InspirationModel>> fetchInspirations(String category);
}
