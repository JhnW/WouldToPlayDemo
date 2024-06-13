// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/proposal/index.dart' as proposal_index;
import '../routes/proposal/like/index.dart' as proposal_like_index;

import '../routes/_middleware.dart' as middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/proposal/like', (context) => buildProposalLikeHandler()(context))
    ..mount('/proposal', (context) => buildProposalHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildProposalLikeHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => proposal_like_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildProposalHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => proposal_index.onRequest(context,));
  return pipeline.addHandler(router);
}

