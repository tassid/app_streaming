import 'package:app_streaming/models/contents.dart';

class Movies extends Contents {
  final String diretor;

  Movies({
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
