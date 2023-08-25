import 'dart:async';
import 'package:flutter_notes_app/data/models/note_model.dart';
import 'package:flutter_notes_app/data/dto/note_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes_app/data/repositories/note_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc(this._notesRepository) : super(NotesLoadingState()) {
    on<LoadNotesEvent>(_onLoadEvent);
    on<WriteNoteEvent>(_onWriteEvent);
    on<RemoveNotesEvent>(_onRemoveEvent);
    add(LoadNotesEvent());
  }

  FutureOr<void> _onLoadEvent(
    LoadNotesEvent event,
    Emitter emit,
  ) {
    emit.forEach(_notesRepository.getAll(), onData: (notes) {
      return NotesLoadedState(notes: notes); // originally NoteModel
    }, onError: (_, __) {
      return NotesErrorState();
    });
  }

  FutureOr<void> _onWriteEvent(
    WriteNoteEvent event,
    Emitter emit,
  ) async {
    try {
      await _notesRepository.write(event.text);
    } catch (e) {
      emit(NotesErrorState());
    }
  }

  FutureOr<void> _onRemoveEvent(
    RemoveNotesEvent event,
    Emitter emit,
  ) async {
    try {
      await _notesRepository.remove(event.path);
    } catch (e) {
      emit(NotesErrorState());
    }
  }
}
