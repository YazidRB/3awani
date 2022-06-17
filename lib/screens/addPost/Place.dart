import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/screens/Category/CategoryChose.dart';
import 'package:aawani/screens/addPost/FeedPost.dart';
import 'package:aawani/screens/addPost/addPost.dart';
import 'package:aawani/screens/home/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class Place extends StatefulWidget {
  final text;
  final category;
  Place({Key? key, required this.text, required this.category})
      : super(key: key);

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  Position? cl;
  final fposition = GlobalKey<FormState>();
  String? position;
  TextEditingController? controller = TextEditingController();

  getPostion(BuildContext context) async {
    bool sercives = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (sercives == false) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                  child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: [
                    ListTile(
                      leading: Icon(
                        Icons.location_off_outlined,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        "Location Services may not enable ",
                        style:
                            TextStyle(color: Color.fromARGB(172, 244, 67, 54)),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ])));
    } else {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else {
        return getLatAndLang();
      }
    }
  }

  getLatAndLang() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  MapController? mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(latitude: 36.7538, longitude: 3.0588),
      areaLimit: BoundingBox(
        east: 10.4922941,
        north: 47.8084648,
        south: 45.817995,
        west: 5.9559113,
      ),
    );

    mapController!.listenerMapSingleTapping.addListener(() async {
      if (mapController!.listenerMapSingleTapping.value != null) {
        if (cl != null) {
          mapController!.removeMarker(
              GeoPoint(latitude: cl!.latitude, longitude: cl!.longitude));
        }

        await mapController!
            .changeLocation(mapController!.listenerMapSingleTapping.value!);

        setState(() {
          cl = Position(
              longitude:
                  mapController!.listenerMapSingleTapping.value!.longitude,
              latitude: mapController!.listenerMapSingleTapping.value!.latitude,
              timestamp: DateTime.now(),
              accuracy: 0,
              altitude: 0,
              heading: 0,
              speed: 0,
              speedAccuracy: 0);
        });
      }
    });
  }

  post(double lat, double long) async {
    await getPostion(context);

    GeoPoint p = GeoPoint(latitude: lat, longitude: long);
    mapController!.changeLocation(p);

    mapController!.setZoom(zoomLevel: 12.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Text('add location',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                if (cl != null) {
                  await postImage(globals.uid!, globals.userName!,
                      globals.profImage!, cl!.latitude, cl!.longitude);
                  globals.file = null;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('you must enter a valide location first !')));
                  // 213699035104
                }
              },
              child: Text('Post',
                  style: GoogleFonts.quicksand(
                      color: Color.fromARGB(255, 12, 22, 12),
                      fontWeight: FontWeight.bold,
                      fontSize: 27)))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: OSMFlutter(
            staticPoints: [],
            mapIsLoading: Center(
              child: CircularProgressIndicator(),
            ),
            controller: mapController!,
            trackMyPosition: false,
            initZoom: 5,
            minZoomLevel: 8,
            maxZoomLevel: 14,
            stepZoom: 1.0,
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            roadConfiguration: RoadConfiguration(
              startIcon: MarkerIcon(
                icon: Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.brown,
                ),
              ),
              roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.green,
                size: 120,
              ),
            )),
          )),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Form(
                    key: fposition,
                    child: TextFormField(
                      onSaved: (newValue) {
                        position = newValue;
                      },
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'wilaya of this post',
                          icon: Icon(Icons.place_sharp)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 8),
                child: ElevatedButton(
                    onPressed: () async {
                      if (controller!.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('enter a location')));
                      } else {
                        try {
                          List<Location> locations =
                              await locationFromAddress(controller!.text);
                          post(locations[0].latitude, locations[0].longitude);
                          setState(() {
                            if (locations.isNotEmpty) {
                              if (cl != null) {
                                mapController!.removeMarker(GeoPoint(
                                    latitude: cl!.latitude,
                                    longitude: cl!.longitude));
                              }
                              cl = Position(
                                  longitude: locations[0].longitude,
                                  latitude: locations[0].latitude,
                                  timestamp: DateTime.now(),
                                  accuracy: 0,
                                  altitude: 0,
                                  heading: 0,
                                  speed: 0,
                                  speedAccuracy: 0);
                            }
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('something didnt work correctly !')));
                        }
                      }
                    },
                    child: Text('Go')),
              ),
              Container(
                margin: EdgeInsets.only(right: 8),
                child: ElevatedButton(
                    onPressed: () async {
                      final c = await getPostion(context);
                      setState(() {
                        if (cl != null) {
                          mapController!.removeMarker(GeoPoint(
                              latitude: cl!.latitude,
                              longitude: cl!.longitude));
                        }
                        cl = c;
                      });
                      await post(cl!.latitude, cl!.longitude);
                      try {
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                cl!.latitude, cl!.longitude);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(placemarks[0].administrativeArea!)));
                        setState(() {
                          controller!.text =
                              placemarks[0].administrativeArea.toString();
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('something not working correctly')));
                      }
                    },
                    child: Text('Your Location')),
              )
            ],
          ),
        ],
      ),
    );
  }

  postImage(String uid, String username, String profImage, double lat,
      double long) async {
    try {
      String res = await FireStoreFunctions().uploadPost(widget.text,
          globals.file!, uid, username, profImage, widget.category, lat, long);

      if (res == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Posted !')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
