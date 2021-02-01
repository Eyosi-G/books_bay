final baseUrl = "https://ebooks-bay.herokuapp.com/api/v1";

class Endpoints {
  static final loginURL = '$baseUrl/login';
  static final registerURL = '$baseUrl/register';
  static final booksURL = '$baseUrl/books';
  static final imageUrl = (String image) => '$baseUrl/images/$image';
}

const kSharedPreferenceName = "user_data";
