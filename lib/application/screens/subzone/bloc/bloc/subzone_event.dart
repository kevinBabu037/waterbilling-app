part of 'subzone_bloc.dart';

@immutable
sealed class ZoneEvent {}


class GetAllSubZonesEvent extends ZoneEvent{
 final String id;

  GetAllSubZonesEvent({required this.id});
}