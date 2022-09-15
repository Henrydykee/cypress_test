

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget(this.imageUrl, {Key? key}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 150,
      width: 150,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: imageProvider),
        ),
      ),
      ///Can replace with simmer
      placeholder: (context, url) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: 68,
            height: 68,
            child: Image.asset("assets/images/placholder.png",)),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: 68,
            height: 68,
            child: Image.asset("assets/images/placholder.png")),
      ),
    );
  }
}