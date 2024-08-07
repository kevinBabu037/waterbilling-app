part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class TenantLoginEvent extends LoginEvent {
  final String tenantID;
  final String password;

  TenantLoginEvent({required this.tenantID, required this.password});
  
}