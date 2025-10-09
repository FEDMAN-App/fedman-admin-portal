import 'package:bloc/bloc.dart';
import 'package:fedman_admin_app/core/utils/error_handler.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../data/models/fedman_user_model.dart';
import '../data/repositories/account_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AccountRepo accountRepo;

  UserBloc({required this.accountRepo}) : super(UserInitial()) {
    on<GetUserRequested>(_onGetUserRequested);
  }

  Future<void> _onGetUserRequested(
    GetUserRequested event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());

      final result = await accountRepo.getUser(event.userId);

      if (result.success && result.data != null) {
        emit(UserSuccess(
          user: result.data!,
          message: result.message ?? 'User loaded successfully',
        ));
      } else {
        emit(UserError(message: result.message ?? 'Failed to load user'));
      }
    } catch (e) {
      final error = ErrorHandler.handleError(e);
      GetIt.I.get<LoggerService>().e(error);
      emit(UserError(message: 'Error loading user: $error'));
    }
  }
}
