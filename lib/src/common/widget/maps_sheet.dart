import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ln_studio/src/common/widget/overlay/modal_popup.dart';
import 'package:map_launcher/map_launcher.dart';

Future<void> showMapsSheet({
  required BuildContext context,
  required Coords coords,
  String? title,
  String? description,
}) =>
    MapLauncher.installedMaps.then(
      (availableMaps) => ModalPopup.show(
        context: context,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              for (var map in availableMaps)
                ListTile(
                  onTap: () => map.showMarker(
                    coords: Coords(45.019641, 39.025248),
                    title: title ?? 'Oko lashes',
                    description: 'Уход за ресницами',
                  ),
                  title: Text(map.mapName),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SvgPicture.asset(
                      map.icon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
