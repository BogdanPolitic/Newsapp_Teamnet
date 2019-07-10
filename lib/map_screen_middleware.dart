import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'map_screen_actions.dart';
import 'models/app_state.dart';

/*
List<Middleware<AppState>> mapScreenMiddleware () => [
  TypedMiddleware<AppState, GetGeoPointsAction>(_getGeoPoints),
  TypedMiddleware<AppState, GetExtendedGeofenceAction>(_getExtendedGeofence),
];

void _goToMaps(Store<AppState> store, LaunchMapsAction action, NextDispatcher next) async {

  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${action.lat},${action.long}';
  if (await canLaunch(googleUrl)) {

    final bool nativeAppLaunchSucceeded = await launch(googleUrl, forceSafariVC: false, universalLinksOnly: true);

    if(!nativeAppLaunchSucceeded){
      await launch(googleUrl, forceSafariVC: true);
    }
  } else {
    throw 'Could not open the map.';
  }
}
*/