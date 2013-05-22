//
//  DribbbleEngine.m
//  Dribble_Engine
//
//  Copyright (c) 2013 Hubert Kunnemeyer. All rights reserved.
//
typedef enum {
    kRequestTypeRebounds,
    kRequestTypePlayerShots,
    kRequestTypeFollowing,
    kRequestTypeFollowers,
    kRequestTypeLikes,
    kRequestTypeDrafts
}RequestType;


    //URL's
#define DRIBBLE_ENDPOINT @" http://api.dribbble.com/"
#define DRIBBLE_SHOT @"http://api.dribbble.com/shots/%@"
#define DRIBBLE_SHOTS_FOR_TYPE @"http://api.dribbble.com/shots/%@"
#define DRIBBLE_COMMENTS @"http://api.dribbble.com/shots/%@/comments"
#define DRIBBLE_SHOT_DETAILS @"http://api.dribbble.com/shots/%@"
#define DRIBBLE_SHOT_REBOUNDS @"http://api.dribbble.com/shots/%@/rebounds"
#define DRIBBLE_SHOTS_FOR_PLAYER @"http://api.dribbble.com/players/%@/shots"
#define DRIBBLE_SHOTS_FOR_PLAYERS_FOLLOWING @"http://api.dribbble.com/players/%@/shots/following"
#define DRIBBLE_SHOTS_LIKED_BY_PLAYER @"http://api.dribbble.com/players/%@/shots/likes"
#define DRIBBLE_PLAYER_PROFILE @"http://api.dribbble.com/players/%@"
#define DRIBBLE_PLAYERS_FOLLOWERS @"http://api.dribbble.com/players/%@/followers"
#define DRIBBLE_PLAYERS_DRAFTEES @"http://api.dribbble.com/players/%@/draftees"
#define DRIBBLE_PLAYERS_FOLLOWING @"http://api.dribbble.com/players/%@/following"

#import "DribbbleEngine.h"
#import "Player.h"
#import "Shot.h"
#import "Comment.h"

@implementation DribbbleEngine
@synthesize results = _results;
@synthesize delegate = _delegate;




- (id)init{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    
    return self;
}


#pragma mark -
#pragma mark Shots
#pragma mark -

- (void)getShotsForType:(ShotTypes)type page:(NSInteger)page complete:(CompletionBlock)finished{
    
    NSString *theType;
    switch (type) {
        case kShotTypeEveryone:
            theType = @"everyone";
            break;
        case kShotTypeDebuts:
            theType = @"debuts";
            break;
        case kShotTypePopular:
            theType = @"popular";
            break;
            
        default:
            break;
    }
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_SHOTS_FOR_TYPE,theType];
    HKConnection *connection;
    
    connection = [[HKConnection alloc]initWithURL:[NSURL URLWithString:URLString] callback:^(NSData *resultData, NSError *error) {
        if (error) {
            NSLog(@"ERROR WITH CALL TO GET ALL SHOTS");
            [_delegate dribbbleEngine:self didFailWithError:error];
        }
        else{
            NSError *jsonError;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&jsonError];
            if (!jsonError) {
                
                _results = [self parseShots:JSON];
                
                [_delegate dribbbleEngine:self didFinishGatheringShots:_results ofType:type];
                if (finished) {
                    finished(YES);
                }
            }
            if (jsonError) {
                [_delegate dribbbleEngine:self didFailWithError:jsonError];
                if (finished) {
                    finished(YES);
                }
            }
        }
        
    }];
}

- (void)getShotsForType:(ShotTypes)type page:(NSInteger)page {
    NSString *theType;
    switch (type) {
        case kShotTypeEveryone:
            theType = @"everyone";
            break;
        case kShotTypeDebuts:
            theType = @"debuts";
            break;
        case kShotTypePopular:
            theType = @"popular";
            break;
            
        default:
            break;
    }
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_SHOTS_FOR_TYPE,theType];
    HKConnection *connection;
    
    connection = [[HKConnection alloc]initWithURL:[NSURL URLWithString:URLString] callback:^(NSData *resultData, NSError *error) {
        if (error) {
            NSLog(@"ERROR WITH CALL TO GET ALL SHOTS");
            [_delegate dribbbleEngine:self didFailWithError:error];
        }
        else{
            NSError *jsonError;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&jsonError];
            if (!jsonError) {
                
                _results = [self parseShots:JSON];
                
                [_delegate dribbbleEngine:self didFinishGatheringShots:_results ofType:type];
                
            }
            if (jsonError) {
                [_delegate dribbbleEngine:self didFailWithError:jsonError];
                
            }
        }
        
    }];

}

- (void)getDetailsForShot:(NSString*)shotID{
    
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_SHOT_DETAILS,shotID];
    HKConnection *connection;
    connection = [[HKConnection alloc]initWithURL:[NSURL URLWithString:URLString] callback:^(NSData *resultData, NSError *error) {
        
        if (resultData) {
            NSError *jsonError;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&jsonError];
            
            if (JSON) {
                Shot *shot = [[Shot alloc]initWithDictionary:JSON];
                [_delegate dribbbleEngine:self didFinishGatheringShotDetails:shot];
            }
            if (jsonError) {
                [_delegate dribbbleEngine:self didFailWithError:error];
            }
            
        }
        if (error) {
            [_delegate dribbbleEngine:self didFailWithError:error];
        }
        
    }];
    
}



- (void)getReboundsForShot:(NSString*)shotID{
    
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_SHOT_REBOUNDS,shotID];
    [self getShotsForShotRequest:kRequestTypeRebounds URL:URLString parameter:shotID page:0];
}

- (void)getShotsForPlayer:(NSString*)playerID page:(NSInteger)pageNumber{
    
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_SHOTS_FOR_PLAYER,playerID];
    [self getShotsForShotRequest:kRequestTypePlayerShots URL:URLString parameter:playerID page:pageNumber];
    
}
- (void)getShotsForPlayersFollowingPlayer:(NSString*)playerID page:(NSInteger)pageNumber{
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_SHOTS_FOR_PLAYERS_FOLLOWING,playerID];
    [self getShotsForShotRequest:kRequestTypePlayerShots URL:URLString parameter:playerID page:pageNumber];
}
- (void)getShotsThatPlayerLikes:(NSString*)playerID page:(NSInteger)pageNumber{
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_SHOTS_LIKED_BY_PLAYER,playerID];
    [self getShotsForShotRequest:kRequestTypePlayerShots URL:URLString parameter:playerID page:pageNumber];
}


#pragma mark -
#pragma mark Player
#pragma mark -
- (void)getPlayerProfile:(NSString *)playerID{
    
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_PLAYER_PROFILE,playerID];
    HKConnection *connection;
    connection = [[HKConnection alloc]initWithURL:[NSURL URLWithString:URLString] callback:^(NSData *resultData, NSError *error) {
        if (resultData) {
            NSError *jsonError;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&jsonError];
            
            if (JSON) {
                
                Player *player = [[Player alloc]initWithDictionary:JSON];
                if (player) {
                    [_delegate dribbbleEngine:self didFinishGatheringPlayersID:player];
                }
                else{
                    NSLog(@"Failed to create a player object. Make sure the Player ID you entered is valid");
                    abort();
                }
                
                
            }
            if (error) {
                [_delegate dribbbleEngine:self didFailWithError:error];
            }
            
        }
        
    }];
    
}
- (void)getFollowersForPlayer:(NSString *)playerID{
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_PLAYERS_FOLLOWERS,playerID];
    [self getPlayersForRequest:kRequestTypeFollowers playerID:playerID URL:URLString];
}
- (void)getPlayersDraftedByPlayer:(NSString *)playerID{
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_PLAYERS_DRAFTEES,playerID];
    [self getPlayersForRequest:kRequestTypeDrafts playerID:playerID URL:URLString];
}
- (void)getPlayersFollowingPlayer:(NSString *)playerID{
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_PLAYERS_FOLLOWING,playerID];
    [self getPlayersForRequest:kRequestTypeFollowing playerID:playerID URL:URLString];
}


#pragma mark -
#pragma mark Comments
#pragma mark -

- (void)getCommentsForShot:(Shot*)shot{
    [_results removeAllObjects];
    
    NSString *URLString = [NSString stringWithFormat:DRIBBLE_COMMENTS,shot.shotID];
    HKConnection *connection;
    connection = [[HKConnection alloc]initWithURL:[NSURL URLWithString:URLString] callback:^(NSData *resultData, NSError *error) {
        
        if (resultData) {
            NSError *jsonError;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&jsonError];
            
            if (JSON) {
                
                _results = [self parseComments:JSON];
                [_delegate dribbbleEngine:self didFinishGatheringComments:_results];
            }
            
        }
        
    }];
}






#pragma mark -
#pragma mark Private
#pragma mark -

- (void)getShotsForShotRequest:(RequestType)requestType URL:(NSString*) URLString parameter:(NSString*)param page:(NSInteger)page{
    
    NSMutableString *URL = [NSMutableString stringWithString:URLString];
    if (page > 0) {
        NSString *pagination = [NSString stringWithFormat:@"?page=%d",page];
        [URL appendString:pagination];
    }
    
    HKConnection *connection;
    
    connection = [[HKConnection alloc]initWithURL:[NSURL URLWithString:URL] callback:^(NSData *resultData, NSError *error) {
        if (error) {
            
            [_delegate dribbbleEngine:self didFailWithError:error];
        }
        else{
            NSError *jsonError;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&jsonError];
            if (!jsonError) {
                NSLog(@"RAW JSON RESULT:%@",JSON);
                _results = [self parseShots:JSON];
                switch (requestType) {
                    case kRequestTypePlayerShots:
                        [_delegate dribbbleEngine:self didFinishGatheringPlayersShots:_results forPlayerID:param page:page];
                        break;
                        
                    case kRequestTypeRebounds:
                        [_delegate dribbbleEngine:self didFinishGatheringRebounds:_results];
                        break;
                        
                    case kRequestTypeFollowing:
                        [_delegate dribbbleEngine:self didFinishGatheringShotsForPlayersFollowingPlayer:_results forPlayerID:param page:page];
                        break;
                    case kRequestTypeLikes:
                        [_delegate dribbbleEngine:self didFinishGatheringShotsThatPlayerLikes:_results forPlayerID:param page:page];
                        break;
                        
                    default:
                        break;
                        
                }
                
                    //If pagination is supported
                if ([JSON valueForKey:@"pages"]) {
                    NSInteger pageSent = page;
                    NSInteger pages = [[JSON valueForKey:@"pages"]integerValue];
                    if (pageSent == 0) {
                        pageSent = 1;
                    }
                    [_delegate dribbbleEngine:self didSendPage:pageSent of:pages];
                }
                
                
            }
            if (jsonError) {
                [_delegate dribbbleEngine:self didFailWithError:jsonError];
            }
        }
        
    }];
    
}

- (void)getPlayersForRequest:(RequestType)requestType playerID:(NSString*)playerID URL:(NSString*)URLString{
    
    HKConnection *connection;
    
    connection = [[HKConnection alloc]initWithURL:[NSURL URLWithString:URLString] callback:^(NSData *resultData, NSError *error) {
        if (error) {
            
            [_delegate dribbbleEngine:self didFailWithError:error];
        }
        else{
            NSError *jsonError;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:&jsonError];
            if (!jsonError) {
                NSLog(@"RAW JSON RESULT:%@",JSON);
                _results = [self parsePlayers:JSON];
                switch (requestType) {
                    case kRequestTypeFollowers:
                        [_delegate dribbbleEngine:self didFinishGatheringPlayersFollowers:_results forPlayerID:playerID];
                        break;
                        
                    case kRequestTypeFollowing:
                        [_delegate dribbbleEngine:self didFinishGatheringPlayersFollowingPlayer:_results forPlayerID:playerID];
                        break;
                        
                    case kRequestTypeDrafts:
                        [_delegate dribbbleEngine:self didFinishGatheringDraftees:_results byPlayer:playerID];
                        break;
                        
                    default:
                        break;
                        
                }
                if (jsonError) {
                    [_delegate dribbbleEngine:self didFailWithError:jsonError];
                }
            }}
        
        
    }];
    
    
    
}

- (NSMutableArray*)parseShots:(NSDictionary*)shots{
    NSArray *array = [shots valueForKey:@"shots"];
    NSMutableArray *allshots = [NSMutableArray array];
    
    for (NSDictionary *shot in array) {
        Shot *aShot = [[Shot alloc]initWithDictionary:shot];
        [allshots addObject:aShot];
    }
    
    return allshots;
}

- (NSMutableArray*)parseComments:(NSDictionary*)comments{
    NSArray *array = [comments valueForKey:@"comments"];
    NSMutableArray *allComments = [NSMutableArray array];
    
    for (NSDictionary *aCom in array) {
        Comment *coms = [[Comment alloc]initWithDictionary:aCom];
        [allComments addObject:coms];
    }
    
    return allComments;
}

- (NSMutableArray*)parsePlayers:(NSDictionary*)players{
    
    NSArray *array = [players valueForKey:@"players"];
    NSMutableArray *allPlayers = [NSMutableArray array];
    
    for (NSDictionary *player in array) {
        Player *aPlayer = [[Player alloc]initWithDictionary:player];
        [allPlayers addObject:aPlayer];
    }
    
    return allPlayers;
    
}










@end

