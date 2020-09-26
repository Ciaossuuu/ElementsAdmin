import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference lesson = FirebaseFirestore.instance.collection('lessons');
  //add
  Future<void> addLesson(
    String sequence,
    String title,
    String video_url,
    String video_time,
    String header,
    String description,
    String banner_url,
    String question,
    List choices,
    String correctAnswer,
  ) async {
    return lesson
        .doc(sequence)
        .set({
          'sequence': sequence,
          'title': title,
          'video_url': video_url,
          'video_time': video_time,
          'header': header,
          'description': description,
          'banner_url': banner_url,
          'question': question,
          'choices': choices,
          'correctAnswer': correctAnswer
        })
        .then((value) => print("Lesson Added"))
        .catchError((error) => print("Failed to add lesson: $error"));
  }

  //update
  Future<void> updateLesson(DocumentSnapshot doc, String sequence, String title,
      String video_url, String video_time, String header, String description) {
    return lesson
        .doc(doc.id)
        .update({
          'sequence': sequence,
          'title': title,
          'video_url': video_url,
          'video_time': video_time,
          'header': header,
          'description': description
        })
        .then((value) => print("Lesson Updated"))
        .catchError((error) => print("Failed to update lesson: $error"));
  }

  //delete
  Future<void> deleteLesson(DocumentSnapshot doc, String sequence) {
    return lesson
        .doc(doc.id)
        .delete()
        .then((value) => print("Lesson Deleted"))
        .catchError((error) => print("Failed to delete lesson: $error"));
  }
}
