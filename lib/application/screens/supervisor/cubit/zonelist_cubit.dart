import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:super_admin_app/data/models/zonelist.dart';


class ZoneSelectionCubit extends Cubit<ZoneSelectionState> {
  ZoneSelectionCubit() : super(ZoneSelectionInitial());
  void selectZone(Zone? zone) {
    emit(ZoneSelectedState(selectedZone: zone));
  }
}

@immutable
abstract class ZoneSelectionState {}

class ZoneSelectionInitial extends ZoneSelectionState {}

class ZoneSelectedState extends ZoneSelectionState {
  final Zone? selectedZone;

  ZoneSelectedState({required this.selectedZone});
}



