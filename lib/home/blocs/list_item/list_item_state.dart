part of 'list_item_bloc.dart';

enum ListItemStatus {
  initial,
  loading,
  completed,
  error,
}

class ListItemState extends Equatable {
  const ListItemState({
    required this.status,
    required this.items,
    required this.error,
  });

  factory ListItemState.initial() {
    return ListItemState(
      status: ListItemStatus.initial,
      items: const [],
      error: CustomError.initial(),
    );
  }

  final ListItemStatus status;
  final List<Item> items;
  final CustomError error;

  @override
  List<Object> get props => [status, items, error];

  @override
  bool get stringify => true;

  ListItemState copyWith({
    ListItemStatus? status,
    List<Item>? items,
    CustomError? error,
  }) {
    return ListItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }
}
