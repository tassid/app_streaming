import 'package:app_streaming/models/content.dart';

class TvShow extends Content {
  final String finalizada;

  TvShow({
    required super.titulo,
    required super.descricao,
    required super.urlCapa,
    required super.urlVideo,
    required super.dataLancamento,
    required this.finalizada,
  }) : super(
          tipo: 'Filme',
        );
}
