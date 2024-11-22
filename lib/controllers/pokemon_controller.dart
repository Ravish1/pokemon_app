import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/pokemon_card.dart';

class PokemonController extends GetxController {
  final cardList = <PokemonCard>[].obs;
  final isLoading = false.obs;
  final isFetchingMore = false.obs;
  int page = 1;
  bool hasMoreData = true;
  String query = ''; // Track the search query

  // Function to fetch cards based on the search query or all cards
  Future<void> fetchCards({String query = ''}) async {
    if (isLoading.value || (isFetchingMore.value && !hasMoreData)) return;

    // Handle loading states
    if (page == 1) {
      isLoading.value = true;
    } else {
      isFetchingMore.value = true;
    }

    // API URL based on search query
    final searchQuery = query.isEmpty ? this.query : query;

    final url = searchQuery.isEmpty
        ? 'https://api.pokemontcg.io/v2/cards?page=$page&pageSize=10'
        : 'https://api.pokemontcg.io/v2/cards?q=$searchQuery';
    print("URLLLLLLLLLL" + url);
    try {
      final response = await http.get(Uri.parse(url));
      print("Responseeeeeeeeeeeee"+response.body.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        if (data.isEmpty) {
          hasMoreData = false; // No more data to load
        } else {
          cardList.addAll(data.map((e) => PokemonCard.fromJson(e)).toList());
          page++;
        }
      }
    } catch (e) {
      print("Error fetching cards: $e");
    } finally {
      isLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  // Clear search and reset to initial state
  void clearSearch() {
    query = '';
    cardList.clear();
    page = 1;
    hasMoreData = true;
    fetchCards(); // Fetch all cards again
  }

  // Set the query when search is performed
  void setSearchQuery(String query) {
    this.query = query;
    cardList.clear(); // Clear previous results
    page = 1; // Start from page 1
    hasMoreData = true;
    fetchCards(query: query); // Fetch cards based on query
  }
}
