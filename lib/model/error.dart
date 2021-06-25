class ErrorMess {
  ErrorMess({
    this.error,
  });

  String error;

  factory ErrorMess.fromJson(Map<String, dynamic> json) => ErrorMess(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}
