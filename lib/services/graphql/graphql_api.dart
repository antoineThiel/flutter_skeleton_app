import 'package:flutter/material.dart';
import 'package:flutter_skeleton_app/services/states/authentication_state.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'graphql_routes.dart';

class GraphQLApi {
  static String baseLink = "http://localhost:4000/graphql";

  static Future<bool> register(
      {required String username,
      required String email,
      required String password,
      required GraphQLClient client}) async {
    String register = GraphQLRoutes.signUp(
        email: email, password: password, username: username);
    QueryResult res =
        await client.mutate(MutationOptions(document: gql(register)));
    if (res.data?['email'] != null) {
      return true;
    }
    return false;
  }

  static Future<String> authenticate(
      {required String email,
      required String password,
      required GraphQLClient client}) async {
    String login = GraphQLRoutes.signIn(email: email, password: password);
    QueryResult res =
        await client.mutate(MutationOptions(document: gql(login)));
    if (res.data != null && res.data?['signIn'] != null) {
      return res.data!['signIn'];
    }
    return "";
  }
}
