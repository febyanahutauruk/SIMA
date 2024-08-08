import 'package:flutter/material.dart';

class NewsImage extends StatelessWidget {
  const NewsImage({
    super.key,
    this.newsId,
    this.imageUrl,
    this.width,
    this.height,
  });

  final int? newsId;
  final String? imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (newsId != null) {
      return Image.network(
        'https://apistrive.pertamina-ptk.com/api/News/$newsId/Image?isStream=true',
        width: width ?? MediaQuery.of(context).size.width * 1,
        height: height,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null) {
      return Container(
        width: width ?? MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl!),fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}