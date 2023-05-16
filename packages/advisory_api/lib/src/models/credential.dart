import 'package:json_annotation/json_annotation.dart';

part 'credential.g.dart';

@JsonSerializable()
class Credential {
  Credential({
    required this.id,
    required this.token,
  });

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);

  factory Credential.initial() {
    return Credential(id: '', token: '');
  }
  final String id;
  final String token;

  Map<String, dynamic> toJson() => _$CredentialToJson(this);
}
