enum Category {
  all('Categorias', ''),
  action('Ação', '28'),
  animation('Animação', '16'),
  adventure('Aventura', '12'),
  comedy('Comédia', '35'),
  documentary('Documentário', '99'),
  drama('Drama', '18'),
  sciFi('Ficção Científica', '878'),
  romance('Romance', '10749'),
  suspense('Suspense', '53'),
  horror('Terror', '27');

  final String categoryName;
  final String apiCategoryId;

  const Category(this.categoryName, this.apiCategoryId);

  static Category? fromApiCategoryId(String id) {
    return Category.values.firstWhere(
      (category) => category.apiCategoryId == id,
    );
  }
}
