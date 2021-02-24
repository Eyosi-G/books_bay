final baseUrl = "http://192.168.1.5:8080/api/v1";

class Endpoints {
  static final loginURL = '$baseUrl/login';
  static final registerURL = '$baseUrl/register';
  static final imageURL = (String image) => '$baseUrl/images/$image';

  //books
  static final booksURL = '$baseUrl/books';
  static final bookURL = (String bookId) => '$baseUrl/books/$bookId';
  static final deleteBookURL = (String bookId) => '$baseUrl/books/$bookId';
  static final getUsersBooks =
      (String userId) => '$baseUrl/users/$userId/books';
  static final insertBookURL = '$baseUrl/books';
  static final updateBookURL = '$baseUrl/books';

  //comments
  static final getComments =
      (String bookId) => '$baseUrl/books/$bookId/comments';
  static final deleteComment = (String bookId, String commentId) =>
      '$baseUrl/books/$bookId/comments/$commentId';
  static final createComment = '$baseUrl/comments';
  static final updateComment = '$baseUrl/comments';
  static final getComment = (String bookId, String commentId) =>
      '$baseUrl/books/$bookId/comments/$commentId';

  //user
  static final getAccount = (String userId) => '$baseUrl/users/$userId';
  static final deleteAccount = (String userId) => '$baseUrl/users/$userId';
  static final updateAccount = '$baseUrl/users';

  //admin
  static final getUsersURL = '$baseUrl/admin/users';
  static final updatePermissionURL = '$baseUrl/admin/permissions/users';
}

const kSharedPreferenceName = "user_data";
const kHiveCartName = 'carts';
