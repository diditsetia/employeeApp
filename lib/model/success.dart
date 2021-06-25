class SuccessMss {
  SuccessMss({
    this.token,
  });

  String token;

  factory SuccessMss.fromJson(Map<String, dynamic> json) => SuccessMss(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
