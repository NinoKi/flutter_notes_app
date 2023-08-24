part of 'notes_bloc.dart';

class NotesEvent {}

class LoadNotesEvent extends NotesEvent {}

class WriteNoteEvent extends NotesEvent {
  final String text;

  WriteNoteEvent({required this.text});
}

class RemoveNotesEvent extends NotesEvent {
  final String path;

  RemoveNotesEvent({required this.path});
}
