import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:provider/provider.dart';

import '../providers/audio_player_provider.dart';
import '../shared/theme.dart';

class AddAudioPlaylistTile extends StatelessWidget {
  final AudioModel audio;
  final bool isAdded;
  final int playlistId;

  const AddAudioPlaylistTile({
    required this.audio,
    required this.isAdded,
    required this.playlistId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);

    return StreamBuilder<SequenceState?>(
        stream: audioPlayerProvider.audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          bool isSelect = false;
          if (state?.sequence.isNotEmpty ?? false) {
            AudioModel curraudio = state!.currentSource!.tag;
            isSelect = curraudio.id == audio.id;
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            color: backgroundUserColor,
            child: Row(
              children: [
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
                  child: Text(
                    audio.title,
                    overflow: TextOverflow.ellipsis,
                    style:
                        (isSelect ? secondaryColorText : primaryUserColorText)
                            .copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    StreamBuilder<PlayerState>(
                        stream:
                            audioPlayerProvider.audioPlayer.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final playing = playerState?.playing;
                          return Visibility(
                            visible: isSelect && (playing ?? false),
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: secondaryColor,
                              size: 24,
                            ),
                          );
                        }),
                    const SizedBox(width: 20),
                    isAdded
                        ? GestureDetector(
                            onTap: () async {
                              await playlistProvider.deleteAudio(
                                audio: audio,
                                playlistId: playlistId,
                              );
                            },
                            child: Icon(
                              Icons.check_circle,
                              color: secondaryColor,
                              size: 28,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await playlistProvider.addAudio(
                                audio: audio,
                                playlistId: playlistId,
                              );
                            },
                            child: Icon(
                              Icons.add_circle_outline,
                              color: primaryUserColor,
                              size: 28,
                            ),
                          ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
