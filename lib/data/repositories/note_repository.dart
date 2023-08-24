import 'package:flutter_notes_app/data/datasource/note_remote_data_source.dart';
import 'package:flutter_notes_app/data/dto/note_dto.dart';
import 'package:flutter_notes_app/data/models/note_model.dart';

class NotesRepository {
  final NotesRemoteDataSource _notesRemoteDataSource;

  NotesRepository(this._notesRemoteDataSource);

// проксируюший метод, обращение к какой-то сущности через другую сущность
  Future<void> write(String note) async {
    await _notesRemoteDataSource.write(note);
  }

  Stream<List<NoteDto>> getAll() {
    // should it be List<NoteModel>???
    return _notesRemoteDataSource.getAll().map(
          (notesDto) => notesDto
              .map(
                (e) => NoteDto(
                  // originally NoteModel
                  note: e.note,
                  path: e.path,
                ),
              )
              .toList(),
        );
  }

  Future<void> remove(String notePath) async {
    await _notesRemoteDataSource.remove(notePath);
  }
}
