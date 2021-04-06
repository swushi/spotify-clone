//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Sam on 4/5/21.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [TrackResponse]
}

//{
//    seeds =     (
//                {
//            afterFilteringSize = 251;
//            afterRelinkingSize = 251;
//            href = "<null>";
//            id = "progressive-house";
//            initialPoolSize = 1000;
//            type = GENRE;
//        },
//                {
//            afterFilteringSize = 251;
//            afterRelinkingSize = 251;
//            href = "<null>";
//            id = emo;
//            initialPoolSize = 1000;
//            type = GENRE;
//        },
//                {
//            afterFilteringSize = 251;
//            afterRelinkingSize = 251;
//            href = "<null>";
//            id = "drum-and-bass";
//            initialPoolSize = 1000;
//            type = GENRE;
//        },
//                {
//            afterFilteringSize = 251;
//            afterRelinkingSize = 251;
//            href = "<null>";
//            id = samba;
//            initialPoolSize = 256;
//            type = GENRE;
//        },
//                {
//            afterFilteringSize = 251;
//            afterRelinkingSize = 251;
//            href = "<null>";
//            id = country;
//            initialPoolSize = 999;
//            type = GENRE;
//        }
//    );
//    tracks =     (
//                {
//            album =             {
//                "album_type" = COMPILATION;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0LyfQWJT6nXafLPZqxe9Of";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0LyfQWJT6nXafLPZqxe9Of";
//                        id = 0LyfQWJT6nXafLPZqxe9Of;
//                        name = "Various Artists";
//                        type = artist;
//                        uri = "spotify:artist:0LyfQWJT6nXafLPZqxe9Of";
//                    }
//                );
//                "available_markets" =                 (
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/1fryN3XKR8SswZZow6bakf";
//                };
//                href = "https://api.spotify.com/v1/albums/1fryN3XKR8SswZZow6bakf";
//                id = 1fryN3XKR8SswZZow6bakf;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b273e9c99f09da528d92a3814fdb";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e02e9c99f09da528d92a3814fdb";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d00004851e9c99f09da528d92a3814fdb";
//                        width = 64;
//                    }
//                );
//                name = "DJ Kenny Ken & DJ SS : World Dance/The Album";
//                "release_date" = 1997;
//                "release_date_precision" = year;
//                "total_tracks" = 37;
//                type = album;
//                uri = "spotify:album:1fryN3XKR8SswZZow6bakf";
//            };
//            artists =             (
//                                {
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/artist/5Kliv7k24uN67SWkOajyrx";
//                    };
//                    href = "https://api.spotify.com/v1/artists/5Kliv7k24uN67SWkOajyrx";
//                    id = 5Kliv7k24uN67SWkOajyrx;
//                    name = Aphrodite;
//                    type = artist;
//                    uri = "spotify:artist:5Kliv7k24uN67SWkOajyrx";
//                }
//            );
//            "available_markets" =             (
//            );
//            "disc_number" = 1;
//            "duration_ms" = 260399;
//            explicit = 0;
//            "external_ids" =             {
//                isrc = USA370505434;
//            };
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/track/4BzwuxZRf7JsMgixkmzGLt";
//            };
//            href = "https://api.spotify.com/v1/tracks/4BzwuxZRf7JsMgixkmzGLt";
//            id = 4BzwuxZRf7JsMgixkmzGLt;
//            "is_local" = 0;
//            name = "Dub Moods";
//            popularity = 0;
//            "preview_url" = "<null>";
//            "track_number" = 18;
//            type = track;
//            uri = "spotify:track:4BzwuxZRf7JsMgixkmzGLt";
//        }
//    );
//}
