import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:super_admin_app/data/models/zonelist.dart';
import 'package:super_admin_app/data/repositories/zone/add_zone_service.dart';

part 'zone_event.dart';
part 'zone_state.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  ZoneBloc() : super(ZoneInitial()) {

   AddZoneService service = AddZoneService();


    on<GetAllZonesEvent>((event, emit)async {
       emit(ZoneLoadingState());

       List<Zone> zones = await service.getAllZone();

        if (zones.isNotEmpty) {
           emit(ZoneSucessState( zones: zones));
        }
        else if(zones.isEmpty){
          emit(ZoneEmptyState());
        }else{
          emit(ZoneErrorState());
        }
    });
  }
}
