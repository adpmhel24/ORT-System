import 'dart:async';
import 'dart:convert';

import 'package:admin_app/shared/custom_text_form_box.dart';
import 'package:admin_app/shared/widgets/custom_button.dart';
import 'package:admin_app/shared/widgets/custom_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../utils/utils.dart';

class DesktopMapPage extends StatefulWidget {
  const DesktopMapPage({
    super.key,
    this.title = 'OpenStreetMap Example',
    this.onLocationSelected,
    this.initialLatLang,
  });

  final String title;
  final LatLng? initialLatLang;
  final Function(LatLng? latLng, String? address)? onLocationSelected;

  @override
  State<DesktopMapPage> createState() => _DesktopMapPageState();
}

class _DesktopMapPageState extends State<DesktopMapPage> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  LatLng? tappedPoint;
  LatLng initialPoint = const LatLng(14.5995, 120.9842); // Manila
  double _zoom = 13;
  String? address;

  Future<String?> getAddressFromLatLng(LatLng latlng) async {
    final uri = Uri.parse(
      "https://nominatim.openstreetmap.org/reverse?format=json&lat=${latlng.latitude}&lon=${latlng.longitude}",
    );

    final response = await http.get(uri, headers: {
      'User-Agent': 'flutter_map_app/1.0',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      address = data["display_name"];
      setState(() {});
      return data["display_name"];
    }

    return null;
  }

  @override
  void initState() {
    if (widget.initialLatLang != null) {
      initialPoint = widget.initialLatLang!;
      tappedPoint = widget.initialLatLang!;
    }
    getAddressFromLatLng(initialPoint);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _onSearch() async {
    final query = _searchController.text;
    if (query.isEmpty) return;

    final latLng = await searchAddress(query);
    if (latLng != null) {
      setState(() {
        initialPoint = latLng;
        tappedPoint = latLng;
        _zoom = 13;
      });
      getAddressFromLatLng(latLng);

      _mapController.move(latLng, _zoom);
    } else {
      CustomDialogBox.errorMessage(
        context,
        message: "No results found for the given address.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text(widget.title)),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomTextFormBox(
                    label: "Search Location",
                    controller: _searchController,
                    onFieldSubmitted: (_) => _onSearch(),
                  ),
                ),
                Constant.widthSpacer,
                CustomFilledButton(
                    onPressed: () {
                      widget.onLocationSelected?.call(
                        tappedPoint,
                        address ?? "",
                      );
                      context.pop();
                    },
                    child: const Text("Submit")),
              ],
            ),
          ),
          if (address != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Address: $address"),
            ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: initialPoint,
                initialZoom: 13,
                onTap: (tapPosition, latlng) {
                  setState(() => tappedPoint = latlng);
                  getAddressFromLatLng(latlng);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                if (tappedPoint != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: tappedPoint!,
                        width: 80,
                        height: 80,
                        child: Icon(
                          m.Icons.location_on,
                          color: Colors.red,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<LatLng?> searchAddress(String query) async {
  final url = Uri.parse(
    'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1',
  );

  final response =
      await http.get(url, headers: {'User-Agent': 'your-app-name/1.0'});

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    if (data.isNotEmpty) {
      final lat = double.parse(data[0]['lat']);
      final lon = double.parse(data[0]['lon']);
      return LatLng(lat, lon);
    }
  }
  return null;
}
