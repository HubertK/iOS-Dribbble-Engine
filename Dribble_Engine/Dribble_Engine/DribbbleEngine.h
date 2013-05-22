//
//  DribbbleEngine.h
//  Dribble_Engine
//
//  Copyright (c) 2013 Hubert Kunnemeyer. All rights reserved.
//

typedef enum {
    kShotTypePopular,
    kShotTypeDebuts,
    kShotTypeEveryone
}ShotTypes;



#import "HKConnection.h"
#import <Foundation/Foundation.h>
@class Shot;
@class DribbbleEngine;
@class Player;

typedef void (^CompletionBlock)(BOOL finished);


@protocol DribbbleEngineDelegate <NSObject>
@optional
    //Shots
- (void)dribbbleEngine:(DribbbleEngine*)engine didFinishGatheringShots:(NSArray*)shots ofType:(ShotTypes)shotType;
- (void)dribbbleEngine:(DribbbleEngine*)engine didFinishGatheringShotDetails:(Shot*)shot;
- (void)dribbbleEngine:(DribbbleEngine*)engine didFinishGatheringRebounds:(NSArray*)rebounds;
- (void)dribbbleEngine:(DribbbleEngine*)engine didFinishGatheringPlayersShots:(NSArray*)shots forPlayerID:(NSString*)playerID page:(NSInteger)page;
- (void)dribbbleEngine:(DribbbleEngine*)engine didFinishGatheringShotsForPlayersFollowingPlayer:(NSArray*)shots forPlayerID:(NSString*)playerID page:(NSInteger)page;
- (void)dribbbleEngine:(DribbbleEngine*)engine didFinishGatheringShotsThatPlayerLikes:(NSArray*)shots forPlayerID:(NSString*)playerID page:(NSInteger)page;


    //Players
- (void)dribbbleEngine:(DribbbleEngine *)engine didFinishGatheringPlayersID:(Player*)player;
- (void)dribbbleEngine:(DribbbleEngine *)engine didFinishGatheringPlayersFollowers:(NSArray*)followers forPlayerID:(NSString*)playerID;
- (void)dribbbleEngine:(DribbbleEngine *)engine didFinishGatheringPlayersFollowingPlayer:(NSArray*)PlayersFollowing forPlayerID:(NSString*)playerID;
- (void)dribbbleEngine:(DribbbleEngine *)engine didFinishGatheringDraftees:(NSArray*)draftees byPlayer:(NSString*)playerID;


    //Comments
- (void)dribbbleEngine:(DribbbleEngine*)engine didFinishGatheringComments:(NSArray*)comments;


    // If pagination is supported by the method, this method is invoked to give access to the pagination parameters
- (void)dribbbleEngine:(DribbbleEngine *)engine didSendPage:(NSInteger)pageSent of:(NSInteger)totalPages;


    //Called for any Errors encountered
- (void)dribbbleEngine:(DribbbleEngine*)engine didFailWithError:(NSError*)error;

#pragma mark-
    //TODO:Add "results per page" method
#pragma mark-

@end

@interface DribbbleEngine : NSObject

@property (strong, nonatomic) NSMutableArray *results;
@property (weak) id <DribbbleEngineDelegate> delegate;




    //====================================================================
    //             Shot Methods --  Returns an Array of Shot Objects
    //====================================================================

    //Returns the specified list of shots where :list has one of the following values: kShotTypeDebuts, kShotTypeEveryone, kShotTypePopular (Supports Pagination)
    //For situations where you want all shots of all types or more than one page of shots, you can use the completion block to know when you can start downloading the next set of shots without causing an error or memory warning.
- (void)getShotsForType:(ShotTypes)type page:(NSInteger)page;
- (void)getShotsForType:(ShotTypes)type page:(NSInteger)page complete:(CompletionBlock)finished;

    //Returns the set of rebounds (shots in response to a shot) for the shot specified by
- (void)getReboundsForShot:(NSString*)shotID;

    //Returns the most recent shots for the player specified by :id. (Supports Pagination)
- (void)getShotsForPlayer:(NSString*)playerID page:(NSInteger)pageNumber;

    //Returns the most recent shots published by those the player specified by :id is following (Supports Pagination)
- (void)getShotsForPlayersFollowingPlayer:(NSString*)playerID page:(NSInteger)pageNumber;

    // Returns details for a shot specified by :id.
- (void)getDetailsForShot:(NSString*)shotID;





    //====================================================================
    //           Coment Methods -- Returns an Array of Comment Objects
    //====================================================================

    //Returns the set of comments for the shot specified by :id.
- (void)getCommentsForShot:(Shot*)shot;





    //====================================================================
    //             Player Methods -- Returns an Array of Player Objects
    //====================================================================

    //Returns the list of followers for a player specified by :id.
- (void)getFollowersForPlayer:(NSString*)playerID;

    //Returns the list of players followed by the player specified by :id.
- (void)getPlayersFollowingPlayer:(NSString*)playerID;

    //Returns the list of players drafted by the player specified by :id.
- (void)getPlayersDraftedByPlayer:(NSString*)playerID;

    // Returns a single Player Object
- (void)getPlayerProfile:(NSString*)playerID;

@end

