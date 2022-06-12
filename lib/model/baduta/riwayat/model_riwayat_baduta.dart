
import 'package:kua/model/baduta/detail/model_detail_baduta.dart';
import 'package:kua/model/baduta/detail/model_header_baduta.dart';
part 'model_riwayat_baduta.g.dart';
class ModelRiwayatBaduta{
  ModelRiwayatBaduta(){}
  ModelHeaderBaduta header;
  List<ModelDetailBaduta> details;

  factory ModelRiwayatBaduta.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}