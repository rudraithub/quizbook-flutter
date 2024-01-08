class StudyModel {
  final String std;
  final List<Subject> sub;
  
StudyModel({required this.std , required this.sub });
}
class Subject {
  
  final String imageUrl;
  final String subName;
  Subject({required this.imageUrl , required this.subName});
} 