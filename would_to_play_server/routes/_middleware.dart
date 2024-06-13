import 'package:dart_frog/dart_frog.dart';
import 'package:uuid/uuid.dart';
import 'package:would_to_play_contracts/would_to_play_contracts.dart';

abstract interface class Database {
  List<Proposal> get proposals;
  String push(Proposal proposal);
  void like(String uuid);
  void dislike(String uuid);
}

class InMemoryStorage implements Database {
  InMemoryStorage() : _proposals = [];

  final List<Proposal> _proposals;

  @override
  List<Proposal> get proposals {
    _proposals.sort((a, b) => a.update.compareTo(b.update));
    return _proposals;
  }

  @override
  String push(Proposal proposal) {
    final uuid = const Uuid().v4();
    proposals.add(
      Proposal(
        proposal.name,
        proposal.description,
        uuid,
        DateTime.now(),
        DateTime.now(),
        0,
      ),
    );
    _removeExpired();
    return uuid;
  }

  @override
  void like(String uuid) {
    final element = proposals.firstWhere((element) => element.uuid == uuid);
    element.likes += 1;
    if (element.likes < 0) element.likes = 0;
    element.update = DateTime.now();
    _removeExpired();
  }

  @override
  void dislike(String uuid) {
    final element = proposals.firstWhere((element) => element.uuid == uuid);
    element.likes -= 1;
    if (element.likes < 0) element.likes = 0;
    element.update = DateTime.now();
    _removeExpired();
  }

  void _removeExpired() {
    proposals.removeWhere(
      (element) => element.update.difference(DateTime.now()).inDays > 90,
    );
  }
}

var _database = InMemoryStorage();

Handler middleware(Handler handler) {
  return handler.use(provider<Database>((_) => _database));
}
