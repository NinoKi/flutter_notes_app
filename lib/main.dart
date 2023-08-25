import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_notes_app/data/datasource/note_remote_data_source.dart';
import 'package:flutter_notes_app/data/repositories/note_repository.dart';
import 'package:flutter_notes_app/screens/notes_screen.dart';
import 'package:get_it/get_it.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //final authRepository = AuthRepository();

  initDataSources();
  initRepository();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: NotesScreen(
              //authRepository: AuthRepository;
              ),
        ),
      ),
    );
  }
}

void initDataSources() {
  GetIt.I.registerSingleton(NotesRemoteDataSource());
}

void initRepository() {
  GetIt.I.registerSingleton(NotesRepository(GetIt.I.get()));
}
