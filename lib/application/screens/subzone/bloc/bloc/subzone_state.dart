part of 'subzone_bloc.dart';

@immutable
sealed class SubZoneState {}

final class SubZoneInitial extends SubZoneState {}

final class SubZoneLoadingState extends SubZoneState {}

final class SubZoneSucessState extends SubZoneState {
 final List<SubZone>zones ;

  SubZoneSucessState({required this.zones});
}

final class SubZoneEmptyState extends SubZoneState {}

final class SubZoneErrorState extends SubZoneState {}


