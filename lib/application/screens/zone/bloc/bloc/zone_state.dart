part of 'zone_bloc.dart';

@immutable
sealed class ZoneState {}

final class ZoneInitial extends ZoneState {}

final class ZoneLoadingState extends ZoneState {}

final class ZoneSucessState extends ZoneState {
 final List<Zone>zones ;

  ZoneSucessState({required this.zones});
}

final class ZoneEmptyState extends ZoneState {}

final class ZoneErrorState extends ZoneState {}


