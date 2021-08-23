import 'package:flutter/material.dart';

class SearchUser extends SearchDelegate<String> {
  final List<String> allUsers;
  final List<String> usersSuggestion;

  SearchUser({required this.allUsers, required this.usersSuggestion});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> allOfUsers = allUsers
        .where(
          (user) => user.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.builder(
        itemCount: allOfUsers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allOfUsers[index]),
            onTap: () {
              query = allOfUsers[index];
              close(context, query);
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> allUserSuggestions = usersSuggestion
        .where(
          (user) => user.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.builder(
        itemCount: allUserSuggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allUserSuggestions[index]),
            onTap: () {
              query = allUserSuggestions[index];
              close(context, query);
            },
          );
        });
  }
}
