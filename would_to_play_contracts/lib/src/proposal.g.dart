// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proposal _$ProposalFromJson(Map<String, dynamic> json) => Proposal(
      json['name'] as String,
      json['description'] as String,
      json['uuid'] as String,
      DateTime.parse(json['creation'] as String),
      DateTime.parse(json['update'] as String),
      (json['likes'] as num).toInt(),
    );

Map<String, dynamic> _$ProposalToJson(Proposal instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'creation': instance.creation.toIso8601String(),
      'update': instance.update.toIso8601String(),
      'uuid': instance.uuid,
      'likes': instance.likes,
    };
