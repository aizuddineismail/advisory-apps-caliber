class CustomError implements Exception {
  CustomError({
    required this.statusCode,
    required this.message,
  });

  factory CustomError.initial() {
    return CustomError(
      statusCode: 0,
      message: '',
    );
  }

  final int statusCode;
  final String message;
}
