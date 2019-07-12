import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:redux/redux.dart';
import 'models/app_state.dart';


class MapScreenViewModel {
  final List geoPoints;
  final List extendedGeofence;

  Function() displayGeoPoints;
  Function() getGeoPoints;
  Function() getExtendedGeofence;

  MapScreenViewModel({
    this.geoPoints,
    this.extendedGeofence,
    this.displayGeoPoints,
    this.getGeoPoints,
    this.getExtendedGeofence
  });
}
  /*factory MapScreenViewModel.fromStore(Store<AppState> store) {
    return MapScreenViewModel(
      geoPoints: store.state.mapScreenState.geoPoints,
      extendedGeofence: store.state.mapScreenState.extendedGeofence,
      getGeoPoints: () => store.dispatch(GetGeoPointsAction()),
      getExtendedGeofence: () => store.dispatch(GetExtendedGeofenceAction())
    );
  }
}

  */