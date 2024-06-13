import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:would_to_play_contracts/would_to_play_contracts.dart';

import '../_middleware.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  try {
    if (context.request.method == HttpMethod.get) return _getProposals(context);
    if (context.request.method == HttpMethod.post) return _addProposal(context);
    return Response(statusCode: HttpStatus.methodNotAllowed);
  } catch (_) {
    return Response(statusCode: HttpStatus.forbidden);
  }
}

FutureOr<Response> _addProposal(RequestContext context) async {
  try {
    final proposa = Proposal.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    final uuid = context.read<Database>().push(proposa);
    return Response.json(
      statusCode: HttpStatus.created,
      body: uuid,
    );
  } catch (_) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}

FutureOr<Response> _getProposals(RequestContext context) async {
  final proposals = context.read<Database>().proposals;
  return Response.json(body: proposals);
}
