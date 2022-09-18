import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagesExample extends StatelessWidget {
  const ImagesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Without cacheImg
        Image.network(
          "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/hM2fUVWViGIJT0Twz2BTXOBEYLM.jpg",
          height: 50,
          width: 50,
          fit: BoxFit.contain,
        ),

        //With CachedImage
        CachedNetworkImage(
            imageUrl:
                "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/hM2fUVWViGIJT0Twz2BTXOBEYLM.jpg",
            progressIndicatorBuilder:
                (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                        value: downloadProgress.progress),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error),
            height: 50,
            width: 50,
            fit: BoxFit.contain),
      ],
    );
  }
}