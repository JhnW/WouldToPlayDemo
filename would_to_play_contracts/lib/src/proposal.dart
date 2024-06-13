import 'package:json_annotation/json_annotation.dart';

part 'proposal.g.dart';

@JsonSerializable()
class Proposal {
  Proposal(this.name, this.description, this.uuid, this.creation, this.update,
      this.likes);

  final String name;
  final String description;
  final DateTime creation;
  DateTime update;
  final String uuid;
  int likes;

  factory Proposal.fromJson(Map<String, dynamic> json) =>
      _$ProposalFromJson(json);
  Map<String, dynamic> toJson() => _$ProposalToJson(this);
}
