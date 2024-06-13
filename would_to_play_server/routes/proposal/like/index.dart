import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:would_to_play_contracts/would_to_play_contracts.dart';

import '../../_middleware.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  try {
    if (context.request.method == HttpMethod.post) return _like(context);
    if (context.request.method == HttpMethod.delete) return _dislike(context);
    return Response(statusCode: HttpStatus.methodNotAllowed);
  } catch (_) {
    return Response(statusCode: HttpStatus.forbidden);
  }
}

FutureOr<Response> _like(RequestContext context) async {
  try {
    final like = Like.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    context.read<Database>().like(like.uuid);
    return Response.json(
      statusCode: HttpStatus.accepted,
    );
  } catch (_) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}

FutureOr<Response> _dislike(RequestContext context) async {
  try {
    final like = Like.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    context.read<Database>().dislike(like.uuid);
    return Response.json(
      statusCode: HttpStatus.accepted,
    );
  } catch (_) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}
