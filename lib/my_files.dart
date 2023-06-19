import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nize_gallery/controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyFiles extends ConsumerStatefulWidget {
  const MyFiles({super.key});

  @override
  ConsumerState<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends ConsumerState<MyFiles> {
  @override
  @override
  void didChangeDependencies() {
    getFiles();
    super.didChangeDependencies();
  }

  List<FileSystemEntity> file = [];
  bool nextPage = false;
  bool showHidden = false;
  String rootDir = '';

  void getFiles() async {
    rootDir = ref.watch(dirProvider);
    Directory dir = Directory(rootDir);
    final permission = await _promptPermissionSetting();
    if (permission) {
      //Get all directory on the device internal Storage
      setState(() {
        file = dir.listSync();
      });

      log(rootDir);
      log(file.length.toString());
    } else {
      log('Permission Denied');
    }
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          await Permission.manageExternalStorage.request().isGranted ||
          await Permission.photos.request().isGranted &&
              await Permission.videos.request().isGranted) {
        log('Permission requested');
        return true;
      }
    }
    log('Permission Denied');
    return false;
  }

  String dirName = '';
  String folderName = '';
  List<String> routePath = [];

  @override
  Widget build(BuildContext context) {
    folderName = ref.watch(dirNameProvider);
    return WillPopScope(
      onWillPop: () async {
        if (nextPage) {
          routePath.removeLast();
          setState(() {
            ref.read(dirProvider.notifier).changeDirectory(
                  routePath.isEmpty
                      ? '/storage/emulated/0'
                      : routePath[routePath.length - 1],
                );
            ref.read(dirNameProvider.notifier).changeFolder(
                  routePath.isEmpty
                      ? 'root Directory'
                      : routePath[routePath.length - 1].split('/').last,
                );
            // folderName = routePath[routePath.length - 1].split('/').last;
            nextPage = false;
          });
          getFiles();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: routePath.isNotEmpty
              ? BackButton(
                  onPressed: () {
                    routePath.removeLast();
                    ref.read(dirProvider.notifier).changeDirectory(
                          routePath.isEmpty
                              ? '/storage/emulated/0'
                              : routePath[routePath.length - 1],
                        );
                    setState(() {
                      folderName =
                          routePath.isEmpty ? 'root Directory' : 'Fortune';
                      // routePath[routePath.length - 1].split('/').last;
                      print(folderName);
                      log(routePath.toString());
                      nextPage = false;
                    });
                    getFiles();
                  },
                )
              : null,
          title: Text(
            nextPage
                ?
                // routePath.isNotEmpty
                //     ? routePath[routePath.length - 1].split('/').last
                //     : 'root Directory'
                // :
                folderName
                : 'root Directory',
          ),
        ),
        body: ListView.builder(
          itemCount: file.length,
          itemBuilder: (context, index) {
            if (file.isEmpty) {
              return Center(
                  child: Text(
                'No files found',
                style: TextStyle(color: Colors.black, fontSize: 45),
              ));
            }
            dirName = file[index].path.split('/').last;
            return Card(
              child: ListTile(
                onTap: () {
                  //Open directory
                  if (file[index] is Directory) {
                    setState(() {
                      ref
                          .read(dirProvider.notifier)
                          .changeDirectory(file[index].path);
                      routePath.add(file[index].path);
                      log(routePath.toString());
                      folderName = file[index].path.split('/').last;

                      nextPage = true;
                    });
                    getFiles();
                  }
                },
                leading: file[index].path.contains('.')
                    ? Icon(Icons.feed_outlined)
                    : Icon(Icons.folder),
                title: Text(
                  dirName,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                // subtitle: Text(
                //   file[index].path.split('/').first,
                //   style: TextStyle(color: Colors.green, fontSize: 12),
                // ),
              ),
            );
          },

          // ),
        ),
      ),
    );
  }
}
