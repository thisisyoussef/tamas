import 'geometry.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class placeImage {
  final String reference;
  placeImage({
    this.reference,
  });

  placeImage.fromJson(Map<dynamic, dynamic> parsedJson)
      : reference = parsedJson['photos']['photo_reference'];

  Future<Image> image(String reference) async {
    int maxHeight = 1600;
    String link =
        "http://maps.googleapis.com/maps/api/place/photo?&maxheight=$maxHeight&photoreference=CmRaAAAAcCpmtP6qafdQGmi74pxQPw5DCZVQYyLzIwPHwzLdEg5AXK6KeyJgxDJ2fI6xeiRNkZNaLIDB1RdHSR5VrKPzQf2_mayQFh1u8RvzkDpU_I7hSSSbJ-HnozwvlhcOlP5MEhCT82OeUrdrDviee5Q2pbegGhTscVFuMZKLw2PdZL7n8UndbFU9lw&key=AIzaSyDX17qdVwFzMv1VGg6SezoVhnpQ2aL8zcw";
    var response = await http.get(link);
    return Image(image: NetworkImage(link));
  }
}
