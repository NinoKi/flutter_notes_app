import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes_app/bloc/notes_bloc.dart';
import 'package:flutter_notes_app/data/datasource/note_remote_data_source.dart';
import 'package:flutter_notes_app/data/repositories/note_repository.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesBloc(
        NotesRepository(
          NotesRemoteDataSource(),
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              return switch (state) {
                NotesLoadingState() => const Center(
                    child: Text('Loading...'),
                  ),
                NotesLoadedState() => Column(
                    children: [
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: _noteController,
                          decoration: const InputDecoration(
                            hintText: 'Note',
                            prefixIcon: Icon(Icons.note),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<NotesBloc>().add(
                                WriteNoteEvent(text: _noteController.text),
                              );
                        },
                        child: const Text('Add'),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: state.notes.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(state.notes[index].note),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      context.read<NotesBloc>().add(
                                            RemoveNotesEvent(
                                                path: state.notes[index].path),
                                          );
                                    },
                                  ),
                                );
                              }))
                    ],
                  ),
                NotesErrorState() => const Center(
                    child: Text('Error'),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
