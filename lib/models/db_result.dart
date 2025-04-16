class DBResult{
  final bool isSuccess;
  final String message;

  List<Map<String,dynamic>> libraryList;

  DBResult({required this.isSuccess,required this.message,required this.libraryList});
}