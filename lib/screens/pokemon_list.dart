import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/pokemon_controller.dart';
import 'pokemon_detail.dart';

class PokemonListScreen extends StatelessWidget {
  final controller = Get.put(PokemonController());
  final ScrollController scrollController = ScrollController();

  PokemonListScreen() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.fetchCards();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchCards();
    return Scaffold(
      appBar: AppBar(
        title: buildSearchBar(),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: SafeArea(
        child: buildPokemonList(),
      ),
    );
  }

  // Build search bar
  buildSearchBar() {
    return TextField(
      onChanged: (value) {
        if (value.isEmpty) {
          controller.clearSearch(); // Reset to initial list if empty
        } else {
          controller.setSearchQuery('set.name:$value'); // Trigger search
        }
      },
      decoration: InputDecoration(
        hintText: 'Search Pokémon',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        prefixIcon: Icon(Icons.search, color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.grey,
    );
  }

  // Build the Pokemon list grid
  buildPokemonList() {
    return Obx(() {
      if (controller.isLoading.value && controller.cardList.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.cardList.isEmpty) {
        return Center(child: Text('No cards found.'));
      }

      return Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: controller.cardList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final card = controller.cardList[index];
                return GestureDetector(
                  onTap: () => Get.to(() => PokemonDetailScreen(card: card)),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: card.imageUrl,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            card.name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (controller.isFetchingMore.value)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      );
    });
  }
}
