part of 'notes_bloc.dart';

sealed class NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<NoteModel> notes;

  NotesLoadedState({
    required this.notes,
  });
}

class NotesErrorState extends NotesState {}
