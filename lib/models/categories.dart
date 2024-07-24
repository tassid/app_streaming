enum Category {
  action('Ação'),
  animation('Animação'),
  adventure('Aventura'),
  comedy('Comédia'),
  documentary('Documentário'),
  drama('Drama'),
  sciFi('Ficção Científica'),
  romance('Romance'),
  suspense('Suspense'),
  horror('Terror');

  final String categoryName;

  const Category(
    this.categoryName,
  );
}
