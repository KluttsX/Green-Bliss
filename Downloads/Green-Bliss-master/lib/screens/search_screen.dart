import 'package:Bliss/screens/blog.dart';
import 'package:Bliss/screens/search_details.dart';
import 'package:Bliss/widgets/custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    loadSearchHistory();
  }

  Future<void> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      BlogPage.previousSearch = prefs.getStringList('searchHistory') ?? [];
    });
  }

  Future<void> saveSearchHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', history);
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Iconsax.arrow_left),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: const Color(0xFF2E3E5C),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextFormFild(
                          hint: "Buscar",
                          prefixIcon: Iconsax.search_normal_1,
                          controller: searchController,
                          filled: true,
                          suffixIcon: searchController.text.isEmpty
                              ? null
                              : Iconsax.close_circle,
                          onTapSuffixIcon: () {
                            searchController.clear();
                          },
                          onChanged: (pure) {
                            setState(() {});
                          },
                          onEditingComplete: () async {
                            void addSearchToHistory(String searchText) async {
                              if (!BlogPage.previousSearch
                                  .contains(searchText)) {
                                BlogPage.previousSearch.add(searchText);
                                await saveSearchHistory(
                                    BlogPage.previousSearch);
                              }
                            }

                            addSearchToHistory(searchController.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResults(
                                  searchQuery: searchController.text,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: BlogPage.previousSearch.length,
                itemBuilder: (context, index) => previousSearchsItem(index),
              ),
              Visibility(
                visible: BlogPage.previousSearch.isEmpty,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Search Suggestion",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 24),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              searchSuggestionsTiem("Puntos de reciclaje"),
                              searchSuggestionsTiem("Como reciclar el papel"),
                              searchSuggestionsTiem(
                                  "Manualidades de reciclaje"),
                              searchSuggestionsTiem("Beneficios de reciclar"),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  previousSearchsItem(int index) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF4F5F7),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchResults(
                  searchQuery: BlogPage.previousSearch[index],
                ),
              ),
            );
          },
          child: Dismissible(
            key: GlobalKey(),
            onDismissed: (DismissDirection dir) async {
              setState(() {
                BlogPage.previousSearch.removeAt(index);
              });
              await saveSearchHistory(BlogPage.previousSearch);
            },
            child: Row(
              children: [
                const Icon(Iconsax.clock, color: Color(0xFF2E3E5C)),
                const SizedBox(width: 10),
                Text(
                  BlogPage.previousSearch[index],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF2E3E5C),
                      ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_right,
                  color: Color(0xFF2E3E5C),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  searchSuggestionsTiem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        margin: const EdgeInsets.only(left: 0),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
            color: const Color(0xFFF4F5F7),
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: const Color(0xFF2E3E5C)),
        ),
      ),
    );
  }
}
