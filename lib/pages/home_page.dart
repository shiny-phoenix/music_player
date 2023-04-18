import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/pages/audio_page.dart';
import 'package:music_player/pages/controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Its music time',
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Color.fromARGB(255, 77, 231, 187),
              ),
            ),
          ),
          body: FutureBuilder<List<SongModel>>(
              future: controller.audioQuery.querySongs(
                  ignoreCase: true,
                  orderType: OrderType.ASC_OR_SMALLER,
                  sortType: null,
                  uriType: UriType.EXTERNAL),
              builder: (BuildContext context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("no song found"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Obx(
                            () => ListTile(
                              title: Text(
                                snapshot.data![index].displayNameWOExt,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                              ),
                              subtitle: Text(
                                "${snapshot.data![index].artist}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.amber),
                              ),
                              leading: QueryArtworkWidget(
                                id: snapshot.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              trailing: controller.playIndex.value == index &&
                                      controller.isPlaying.value
                                  ? const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 26,
                                    )
                                  : null,
                              onTap: () {
                                Get.to(
                                  () => AudioPage(
                                    data: snapshot.data!,
                                  ),
                                  transition: Transition.downToUp,
                                );
                                controller.playSong(
                                    snapshot.data![index].uri, index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
        ));
  }
}
