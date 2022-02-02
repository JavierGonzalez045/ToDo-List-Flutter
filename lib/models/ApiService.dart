class ApiService {
  String name;
  String url;
  // https://localhost:5001/api/Tasks

  ApiService(name, url) {
    this.name = name;
    this.url = url;
  }
}


// Future<List<ApiService>> _getTodoList;

//   Future<List<ApiService>> _getTodo() async {
//     final response = await http.get("https://localhost:5001/api/Tasks");

//     if (response.statusCode == 200) {
//       print(response.body);
//     } else {
//       throw Exception("Connection failed");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getTodo();
//   }