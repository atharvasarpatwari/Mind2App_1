class UserSelection {
  bool homePage;
  bool loginPage;
  bool productGrid;
  bool categories;
  bool cartPage;

  UserSelection({
    this.homePage = false,
    this.loginPage = false,
    this.productGrid = false,
    this.categories = false,
    this.cartPage = false,
  });

  Map<String, dynamic> toJson() => {
        "homePage": homePage,
        "loginPage": loginPage,
        "productGrid": productGrid,
        "categories": categories,
        "cartPage": cartPage,
      };

  factory UserSelection.fromJson(Map<String, dynamic> j) {
    return UserSelection(
      homePage: j["homePage"] ?? false,
      loginPage: j["loginPage"] ?? false,
      productGrid: j["productGrid"] ?? false,
      categories: j["categories"] ?? false,
      cartPage: j["cartPage"] ?? false,
    );
  }
}