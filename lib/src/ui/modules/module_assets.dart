part of craft_dynamic;

class MenuItemImage extends StatelessWidget {
  final String imageUrl;
  double iconSize;

  MenuItemImage({super.key, required this.imageUrl, this.iconSize = 54});

  @override
  Widget build(BuildContext context) => kIsWeb
      ? Image.network(
          imageUrl,
          height: iconSize,
          width: iconSize,
        )
      : CachedNetworkImage(
          imageUrl: imageUrl,
          height: iconSize,
          width: iconSize,
          placeholder: (context, url) => SpinKitPulse(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven
                      ? APIService.appPrimaryColor
                      : APIService.appSecondaryColor,
                ),
              );
            },
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: APIService.appPrimaryColor,
          ),
        );
}

class MenuItemTitle extends StatelessWidget {
  final String title;

  const MenuItemTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Text(
        title,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        softWrap: true,
      );
}
