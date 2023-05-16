import 'package:advisory_api/advisory_api.dart';
import 'package:advisoryapps/authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_item_event.dart';
part 'list_item_state.dart';

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  ListItemBloc({
    required this.itemApi,
    required this.authenticationBloc,
  }) : super(ListItemState.initial()) {
    on<GetListItem>(_onGetListItem);
  }

  final AuthenticationBloc authenticationBloc;
  final ItemApi itemApi;

  Future<void> _onGetListItem(
    GetListItem event,
    Emitter<ListItemState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ListItemStatus.loading));

      final items = await itemApi.getItems(
        authenticationBloc.state.credential.id,
        authenticationBloc.state.credential.token,
      );

      emit(state.copyWith(status: ListItemStatus.completed, items: items));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: ListItemStatus.error,
          error: e,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        state.copyWith(
          status: ListItemStatus.error,
          error: CustomError(
            statusCode: 500,
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
