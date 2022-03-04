import 'package:flutter/widgets.dart';
import 'package:gaphql_example/services/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/user.dart';

import '../locator.dart';

class AuthViewModel extends ChangeNotifier {
  final Map _authData = {};
  final GraphQLService _graphQl = locator<GraphQLService>();
  Map get authData => _authData;
  final usernameController = TextEditingController();

  bool _busy = false;
  bool get busy => _busy;

  late int _userId;
  // late String? _requestId;
  // late String? _verificationKey;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  Future enterUsername() async {
    String username = _authData['username'].toString().toLowerCase();
    // User user = User();
    // _userId = user.id!;
    setBusy(true);
    bool res = await doesUsernameExist(username);
    setBusy(false);

    if (!res) {
      setBusy(true);

      const String updateGQLUsername = r'''
        mutation UpdateGQLUser($userID: Int!, $username: String!) {
          update_user_user(where: {username: {_eq: $username}, id: {_eq: $userID} }) {
           id
           username
          }
        }
      ''';

      MutationOptions options = MutationOptions(
        document: gql(updateGQLUsername),
        variables: {
          "userID": _userId,
          "username": username,
        },
      );
      GraphQLServiceResponse graphqlRes = await _graphQl.runMutation(options);

      setBusy(false);

      if (graphqlRes.status) {
        debugPrint("User $username exists");
      }
    } else {
      debugPrint("User $username does not exist");
    }
  }

  Future<bool> doesUsernameExist(String username) async {
    const String doesUserExist = r'''
      query DoesUserExist($username: String!) {
        user_user(where: {username: {_eq: $username}}) {id}
      }
    ''';

    QueryOptions options = QueryOptions(
      document: gql(doesUserExist),
      variables: {
        "username": username,
      },
    );
    GraphQLServiceResponse graphqlRes = await _graphQl.runQuery(
      options,
    );

    return graphqlRes.status;
  }

  validateAndCallFunction({
    required GlobalKey<FormState> formKey,
  }) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    enterUsername();
  }
}
