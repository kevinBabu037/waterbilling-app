import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:super_admin_app/data/models/subzone.dart';
import 'package:super_admin_app/data/repositories/sub%20zone/subzone_service.dart';

part 'subzone_event.dart';
part 'subzone_state.dart';

class SubZoneBloc extends Bloc<ZoneEvent, SubZoneState> {
  SubZoneBloc() : super(SubZoneInitial()) {

   AddSubZoneService service = AddSubZoneService();


    on<GetAllSubZonesEvent>((event, emit)async {
       emit(SubZoneLoadingState());

       List<SubZone> zones = await service.getAllSubZone(event.id);

        if (zones.isNotEmpty) {
           emit(SubZoneSucessState( zones:zones ));
        }
        else if(zones.isEmpty){
          emit(SubZoneEmptyState());
        }else{
          emit(SubZoneErrorState());
        }
    });
  }
}
