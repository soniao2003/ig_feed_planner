import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/inspiration/data/inspiration_model.dart';
import 'package:instagram_planner/inspiration/domain/inspiration_repo.dart';
import 'package:instagram_planner/inspiration/data/inspirationservice.dart';

class InspirationsNotifier extends StateNotifier<List<InspirationModel>> {
  late final InspirationRepo _inspoRepo;

  InspirationsNotifier(StateNotifierProviderRef ref, category) : super([]) {
    _inspoRepo = ref.read(inspirationsProvider);
    fetchInspirations(category);
  }

  Future<List<InspirationModel>> fetchInspirations(String category) async {
    try {
      List<InspirationModel> fetchedInspoList =
          await _inspoRepo.fetchInspirations(category);
      state = fetchedInspoList;
      print('Fetched inspo list: $fetchedInspoList');
      return fetchedInspoList;
    } catch (e) {
      print('Error fetching inspo list: $e');
      return [];
    }
  }
}
