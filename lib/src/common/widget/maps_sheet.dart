import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ln_studio/src/common/widget/overlay/modal_popup.dart';
import 'package:map_launcher/map_launcher.dart';

Future<void> showMapsSheet({
  required BuildContext context,
  required Coords coords,
  required String title,
}) =>
    MapLauncher.installedMaps.then(
      (availableMaps) => ModalPopup.show(
        context: context,
        child: ListView.builder(
          itemCount: availableMaps.length,
          itemBuilder: (context, index) {
            final map = availableMaps[index];
            return ListTile(
              onTap: () => map.showMarker(
                coords: coords,
                title: title,
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
            );
          },
        ),
      ),
    );
