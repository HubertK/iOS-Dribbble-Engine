//
//  Player.m
//  Dribble
//
//  Created by Hubert Kunnemeyer on 9/11/12.
//  Copyright (c) 2012 Hubert Kunnemeyer. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize name = _name;
@synthesize playerID = _playerID;
@synthesize userName = _userName;
@synthesize URL = _URL;
@synthesize avatarURL = _avatarURL;
@synthesize twitter_screen_name = _twitter_screen_name;
@synthesize location = _location;
@synthesize shot_Count = _shot_Count;
@synthesize followers_count = _followers_count;
@synthesize following_count = _following_count;
@synthesize draftees_count = _draftees_count;
@synthesize comments_count = _comments_count;
@synthesize comments_received_count = _comments_received_count;
@synthesize likes_count = _likes_count;
@synthesize likes_received_count = _likes_received_count;
@synthesize rebounds_count = _rebounds_count;
@synthesize rebounds_received_count = _rebounds_received_count;


- (id)initWithDictionary:(NSDictionary*)dribblePersonAttrs{
   
    self = [super init];
    if (!self) {
        return nil;
    }
    NSArray *keys = [dribblePersonAttrs allKeys];
    for (NSString *attr in keys) {
        id value = [dribblePersonAttrs valueForKey:attr];
        if ([attr isEqualToString:@"id"]) {
            _playerID = value;
        }
        else if ([attr isEqualToString:@"name"]){
            _name = value;
        }
        else if ([attr isEqualToString:@"username"]){
            _userName = value;
        }
        else if ([attr isEqualToString:@"url"]){
            _URL = value;
        }
        else if ([attr isEqualToString:@"avatar_url"]){
            _avatarURL = value;
        }
        else if ([attr isEqualToString:@"location"]){
            _location = value;
        }
        else if ([attr isEqualToString:@"twitter_screen_name"]){
            _twitter_screen_name = value;
        }
        
        //Integers
        else if ([attr isEqualToString:@"shots_count"]){
            _shot_Count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"draftees_count"]){
            _draftees_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"followers_count"]){
            _followers_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"following_count"]){
            _following_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"comments_count"]){
            _comments_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"comments_received_count"]){
            _comments_received_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"likes_count"]){
            _likes_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"likes_received_count"]){
            _likes_received_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"rebounds_count"]){
            _rebounds_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"rebounds_received_count"]){
            _rebounds_received_count = [NSNumber numberWithInt:[value integerValue]];
        }

    
    }
    
    
    return self;
 
}
+ (Player*)initWithDictionary:(NSDictionary*)dribblePersonAttrs{
    
    return [self initWithDictionary:dribblePersonAttrs];
}










@end
