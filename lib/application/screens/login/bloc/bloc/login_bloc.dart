import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:super_admin_app/data/repositories/login/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {


    on<TenantLoginEvent>((event, emit)async {
      emit(LoginLoadingState());
      
      bool res = await LoginService().tenantLogin(event.tenantID, event.password);

      if (res) {
        emit(LoginSucessState());
      }else{
        emit(LoginErrorState());
      }
    
    });
  }
}
