import 'package:app_streaming/models/content.dart';

class Movie extends Content {
  final String diretor;

  Movie({
    required super.titulo,
    required super.descricao,
    required super.urlCapa,
    required super.urlVideo,
    required super.dataLancamento,
    required this.diretor,
  }) : super(
          tipo: 'Filme',
        );
}
