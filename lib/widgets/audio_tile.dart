import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/models/audio_model.dart';

import '../shared/theme.dart';

class AudioTile extends StatelessWidget {
  final bool isHistory;
  final bool isMostPlayed;
  final bool isSearch;
  final AudioModel audio;
  final int sequence;
  final bool isPlaying;

  const AudioTile({
    this.isHistory = false,
    this.isMostPlayed = false,
    this.isSearch = false,
    required this.audio,
    this.sequence = 0,
    required this.isPlaying,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Visibility(
            visible: isMostPlayed,
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              width: 30,
              child: Text(
                sequence < 10 ? "0$sequence" : sequence.toString(),
                style: primaryColorText.copyWith(
                    fontWeight: bold,
                    fontSize: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 0.1
                      ..color = primaryColor),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.only(right: 24),
            width: 60,
            child: audio.images.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/bg_song_example.png",
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: audio.images[0].url,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audio.title,
                  overflow: TextOverflow.ellipsis,
                  style:
                      primaryColorText.copyWith(fontSize: 16, fontWeight: bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Visibility(
                visible: isPlaying,
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 20),
              Visibility(
                visible: !isHistory,
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: primaryColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
