part of 'notes_bloc.dart';

class NotesEvent {}

class LoadNotesEvent extends NotesEvent {}

class WriteNoteEvent extends NotesEvent {
  final String text;

  WriteNoteEvent({required this.text});
}

class RemoveNoteEvent {
  final String notePath;

  RemoveNoteEvent({required this.notePath});
}
