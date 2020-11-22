class LessonModel {
  String title;
  int sequence;
  String description;
  String videoUrl;
  String imageUrl;
  bool izTaken;
  String question;
  String correctAnswer;
  List choices;
  LessonModel.getData(data) {
    this.title = data['title'];
    this.sequence = data['sequence'];
    this.description = data['description'];
    this.imageUrl = data['imageUrl'];
    this.videoUrl = data['url'];
    this.izTaken = data['izTaken'];
    this.question = data['question'];
    this.correctAnswer = data['correctAnswer'];
    this.choices = data['choices'];
  }
  LessonModel() {}
  LessonModel.dummyLesson() {
    this.title = 'dummy';
  }
}
