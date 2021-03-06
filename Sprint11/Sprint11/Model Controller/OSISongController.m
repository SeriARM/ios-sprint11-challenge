//
//  OSISongController.m
//  Sprint11
//
//  Created by Sergey Osipyan on 3/1/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import "OSISongController.h"
#import "OSISong.h"


@implementation OSISongController

static NSString * const baseURL = @"https://musixmatchcom-musixmatch.p.rapidapi.com/wsr/1.1/matcher.lyrics.get";
static NSString * const apiKey = @"70692b9171mshcb5f4b3a80503a7p191039jsn6d9be1aa176e";

- (instancetype)init {
    self = [super init];
    if (self) {
        _songs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)createSong:(NSString *)title artist:(NSString *)artist lyrics:(NSString *)lyrics rating:(NSString *)rating stepperValue:(int)stepperValue {
    
    OSISong *song = [[OSISong alloc] initWithTitle:title artist:artist lyrics:lyrics rating:rating stepperValue:(int)stepperValue];
    [[self songs] addObject:song];
}

- (void)updateSong:(OSISong *)song rating:(NSString *)rating stepperValue:(int)stepperValue{
    song.rating = rating;
    song.stepperValue = stepperValue;
}

- (void)searchForSong:(NSString *)artist trackName:(NSString *)trackName completion:(void (^)(NSDictionary *song, NSError * _Nullable))completion {
    
//    NSDictionary *headers = @{@"X-RapidAPI-Key": @"70692b9171mshcb5f4b3a80503a7p191039jsn6d9be1aa176e"};
//    NSURLConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
//        [request setUrl:@"https://musixmatchcom-musixmatch.p.rapidapi.com/wsr/1.1/artist.search?s_artist_rating=desc&q_artist=John&page=1&page_size=5"];
//        [request setHeaders:headers];
//    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
//        NSInteger code = response.code;
//        NSDictionary *responseHeaders = response.headers;
//        UNIJsonNode *body = response.body;
//        NSData *rawBody = response.rawBody;
//    }];
    
    NSURL *url = [NSURL URLWithString:baseURL];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *queryItemArtist = [NSURLQueryItem queryItemWithName:@"q_artist" value:artist];
    NSURLQueryItem *queryItemTrack = [NSURLQueryItem queryItemWithName:@"q_track" value:trackName];
    [urlComponents setQueryItems:@[queryItemTrack, queryItemArtist]];
    NSURL *requestURL = [urlComponents URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    [request setValue:apiKey forHTTPHeaderField:@"X-Mashape-Key"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if (error) {
              NSLog(@"Error fetching data: %@", error);
              completion(nil, error);
              return;
          }
          if (!data) {
              NSLog(@"Data is missing");
              completion(nil, [[NSError alloc] init]);
              return;
          }
          
          NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
          if (![dict isKindOfClass:[NSDictionary class]]) {
              NSLog(@"JSON error, not dictinary");
              completion(nil, error);
              
              return;
          }
          
          NSString *dataAsStrig =[[NSString alloc]
                                  initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"encoded to %@", dataAsStrig);
          NSString *lyrics = dict[@"lyrics_body"];
          NSLog(lyrics);
          completion(dict, error);
          
          
      }]resume];

    
}

@end
