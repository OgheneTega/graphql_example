import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  HttpLink get httpLink {
    return HttpLink("http://localhost:8080/v1/graphql");
  }

  Link get link => httpLink;

  GraphQLClient get client {
    return GraphQLClient(cache: GraphQLCache(), link: httpLink);
  }

  Future<GraphQLServiceResponse> runQuery(QueryOptions options) async {
    QueryResult result = await client.query(options);

    return GraphQLServiceResponse(status: true, data: result.data);
  }

  Future<GraphQLServiceResponse> runMutation(MutationOptions options) async {
    QueryResult result = await client.mutate(options);

    return GraphQLServiceResponse(status: true, data: result.data);
  }
}

class GraphQLServiceResponse {
  final bool status;
  final Map<String, dynamic>? data;

  GraphQLServiceResponse({required this.status, required this.data});
}
