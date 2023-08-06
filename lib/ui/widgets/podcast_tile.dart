// Copyright 2020 Ben Hills and the project contributors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:anytime/bloc/podcast/podcast_bloc.dart';
import 'package:anytime/entities/podcast.dart';
import 'package:anytime/ui/podcast/podcast_details.dart';
import 'package:anytime/ui/widgets/tile_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class PodcastTile extends StatelessWidget {
  final Podcast podcast;

  const PodcastTile({
    super.key,
    required this.podcast,
  });

  @override
  Widget build(BuildContext context) {
    final podcastBloc = Provider.of<PodcastBloc>(context);

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
              settings: const RouteSettings(name: 'podcastdetails'),
              builder: (context) => PodcastDetails(podcast, podcastBloc)),
        );
      },
	  onLongPress: () {
	  	//ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(podcast.url),));
		ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Podcast URL copied to clipboard"),));
		Clipboard.setData(ClipboardData(text: podcast.url));
	  },
      minVerticalPadding: 9,
      leading: Hero(
        key: Key('tilehero${podcast.imageUrl}:${podcast.link}'),
        tag: '${podcast.imageUrl}:${podcast.link}',
        child: TileImage(
          url: podcast.imageUrl!,
          size: 60,
        ),
      ),
      title: Text(
        podcast.title,
        maxLines: 1,
      ),

      /// A ListTile's density changes depending upon whether we have 2 or more lines of text. We
      /// manually add a newline character here to ensure the density is consistent whether the
      /// podcast subtitle spans 1 or more lines. Bit of a hack, but a simple solution.
      subtitle: Text(
        '${podcast.copyright ?? ''}\n',
        maxLines: 2,
      ),
      isThreeLine: false,
    );
  }
}
