import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nize_gallery/utils/components.dart';

class MyGallery extends ConsumerStatefulWidget {
  const MyGallery({super.key});

  @override
  ConsumerState<MyGallery> createState() => _MyGalleryState();
}

GlobalKey<ScaffoldState> _key = GlobalKey();

//  final Directot=ry
class _MyGalleryState extends ConsumerState<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: drawer(),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.more_vert_outlined, color: Colors.white),
            onPressed: () => _key.currentState!.openDrawer(),
          ),
          title: const Text('Gallery'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ));
  }
}
