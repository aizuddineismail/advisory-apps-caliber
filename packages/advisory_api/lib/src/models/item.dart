import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Item extends Equatable {
  const Item({
    required this.id,
    required this.listName,
    required this.distance,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  factory Item.initial() {
    return const Item(
      id: '',
      listName: '',
      distance: '',
    );
  }

  final String id;
  final String listName;
  final String distance;

  @override
  List<Object> get props => [id, listName, distance];
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
