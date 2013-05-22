iOS-Dribbble-Engine
======

An Un-Official iOS Dribbble Engine for iOS.

Keep in mind that the Dribbble API is still in Beta. And this is still very much a work in progress.

I love to browse the Dribbble website so I decided it was time to make an un-official dribble engine for iOS. The API doesnt support anything other than GET calls at this time, but it's enough to get us started.

The actual Dribbble Engine has only four classes:

1. DribbbleEngine - is the work-horse. It's used to 'GET' Shots, Players, and Comments.
2. Shot
3. Player
4. Comment


All results are returned via the DribbbleEngineDelegate. The delegate has many optional methods depending on your query.
Here is a list of all the DribbbleEngineDelegate Methods:
````
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

````

<H3>Now lets have a look at how we query for Shots, Players and Comments

Dribbble gives us three different kinds of shots we can GET, Popular, Debuts or Everyone.
The Engine has three corresponding "ShotTypes" kShotTypeDebuts, kShotTypeEveryone, kShotTypePopular
<h5>Each method returns and NSArray of "Shot" objects

```` 
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

````





<h5> Comment Methos, Returns an NSArray of "Comment" objects
````
- (void)getCommentsForShot:(Shot*)shot;

````





 Player Methods -- Returns an NSArray of Player Objects
````

    //Returns the list of followers for a player specified by :id.
- (void)getFollowersForPlayer:(NSString*)playerID;

    //Returns the list of players followed by the player specified by :id.
- (void)getPlayersFollowingPlayer:(NSString*)playerID;

    //Returns the list of players drafted by the player specified by :id.
- (void)getPlayersDraftedByPlayer:(NSString*)playerID;

    // Returns a single Player Object
- (void)getPlayerProfile:(NSString*)playerID;

````
