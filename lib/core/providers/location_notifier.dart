import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/model/location_model.dart';

part 'location_notifier.g.dart';

@Riverpod(keepAlive: true)
class LocationNotifier extends _$LocationNotifier {
  @override
  Future<LocationModel?> build() async {
    return await _getCurrentLocation();
  }

  Future<LocationModel> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    final position = await Geolocator.getCurrentPosition();

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = placemarks.first;

    final address =
        '${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );
  }

  Future<void> refreshLocation() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _getCurrentLocation());
  }
}
