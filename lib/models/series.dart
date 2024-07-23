import 'package:app_streaming/models/contents.dart';

class Series extends Contents {
  final String finalizada;

  Series({
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
