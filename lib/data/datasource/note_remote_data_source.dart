import 'dart:js_interop';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_notes_app/data/dto/note_dto.dart';

// будет всегдп возвращать NoteDto

class NotesRemoteDataSource {
  Future<void> write(String note) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) return;

    final ref = FirebaseDatabase.instance.ref('notes/$id');

    await ref.push().set({
      'noteId': 1,
      'note': note,
    });
  }

  Stream<List<NoteDto>> getAll() {
    try {
      final id = FirebaseAuth.instance.currentUser?.uid;
      final ref = FirebaseDatabase.instance.ref('notes/$id');

      return ref.onValue.map(
        (event) {
          final snapshot = event.snapshot.value as Map?;

          if (snapshot == null) {
            return const [];
          }

          return snapshot.keys
              .map(
                (key) => NoteDto(
                  note: snapshot[key]['note'] as String,
                  path: key,
                ),
              )
              .toList();
        },
      );
    } catch (e) {
      return const Stream.empty();
    }
  }

  Future<void> remove(String notePath) async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    final ref = FirebaseDatabase.instance.ref('notes/$id');

    ref.child(notePath).remove();
  }
}
