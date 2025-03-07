import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/pages/controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPage extends StatelessWidget {
  //const AudioPage({Key? key}) : super(key: key);

  final List<SongModel> data;
  const AudioPage({super.key, required this.data});

  String formatDuration(double seconds) {
    Duration duration = Duration(seconds: seconds.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 250,
                  width: 250,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(42),
                    bottom: Radius.circular(42),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        data[controller.playIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.amber),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              //formatDuration(double.parse(controller.position.value)),
                              controller.duration.value,
                              style: const TextStyle(color: Colors.amber),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: Colors.cyan,
                                inactiveColor: Colors.blue,
                                activeColor: Colors.cyan,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: //double.parse(controller.position.value),
                                controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDurationToSeconds(
                                      newValue.toInt());
                                  //newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              //controller.max.value - controller.position.value,
                              controller.position.value,
                              style: const TextStyle(color: Colors.amber),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.playSong(
                                  data[controller.playIndex.value - 1].uri,
                                  controller.playIndex.value - 1);
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 50,
                              color: Colors.cyan,
                            ),
                          ),
                          Obx(
                            () => CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.cyan,
                                child: Transform.scale(
                                  scale: 1.75,
                                  child: IconButton(
                                    onPressed: () {
                                      if (controller.isPlaying.value) {
                                        controller.audioPlayer.pause();
                                        controller.isPlaying(false);
                                      } else {
                                        controller.audioPlayer.play();
                                        controller.isPlaying(true);
                                      }
                                    },
                                    icon: controller.isPlaying.value
                                        ? const Icon(
                                            Icons.pause,
                                            size: 30,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.play_arrow_rounded,
                                            size: 33,
                                            color: Colors.white,
                                          ),
                                  ),
                                )),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.playSong(
                                  data[controller.playIndex.value + 1].uri,
                                  controller.playIndex.value + 1);
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: 50,
                              color: Colors.cyan,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
