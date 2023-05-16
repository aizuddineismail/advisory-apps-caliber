part of 'list_item_bloc.dart';

abstract class ListItemEvent extends Equatable {
  const ListItemEvent();

  @override
  List<Object> get props => [];
}

class GetListItem extends ListItemEvent {}
