class StudyModel {
  final String std;
  final List<Subject> sub;
  final String isNew;
StudyModel({required this.std , required this.sub , required this.isNew});
}
class Subject {
  final String imageUrl;
  final String subName;
  Subject({required this.imageUrl , required this.subName});
}