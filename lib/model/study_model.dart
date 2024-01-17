class StudyModel {
  final String std;
  final int stdId;
  final List<Subject> sub;
  
StudyModel({required this.std , required this.stdId, required this.sub });
}
class Subject {
  final int subId;
  final String imageUrl;
  final String subName;
  Subject({required this.imageUrl , required this.subId , required this.subName});
} 