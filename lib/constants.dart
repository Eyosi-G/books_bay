final baseUrl = "https://ebooks-bay.herokuapp.com/api/v1";

class Endpoints {
  static final loginURL = '$baseUrl/login';
  static final registerURL = '$baseUrl/register';
  static final booksURL = '$baseUrl/books';
  static final imageURL = (String image) => '$baseUrl/images/$image';
  static final generateCheckoutURL = '$baseUrl/purchase';
  static final getPurchasedBooksURL = (String id) => '$baseUrl/users/$id/books';
  static final downloadURL = (String id) => '$baseUrl/download/books/$id';
}

const kSharedPreferenceName = "user_data";
const kHiveCartName = 'carts';
