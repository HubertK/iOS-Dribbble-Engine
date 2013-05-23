iOS-Dribbble-Engine
======

An Un-Official iOS Dribbble Engine for iOS.

Keep in mind that the Dribbble API is still in Beta. And this is still very much a work in progress.

I love to browse the Dribbble website so I decided it was time to make an un-official dribble engine for iOS. The API doesnt support anything other than GET calls at this time, but it's enough to get us started.

The actual Dribbble Engine has only four classes, they are:

 *   DribbbleEngine
 *   Shot
 *   Player
 *   Comment
 


<h3>Now lets have a look at how we query for Shots, Players and Comments.</h3>
Dribbble gives us three different kinds of shots we can GET: Popular, Debuts or Everyone.
The Engine has three corresponding "ShotTypes" that can be passed to the  getShotsForType:page: method. The values are as follows:

1. kShotTypePopular = Popular
2. kShotTypeDebut = Debuts
3. kShotTypeEveryone = Everyone


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





<h5> Comment Method, Returns an NSArray of "Comment" objects
````
- (void)getCommentsForShot:(Shot*)shot;

````





<h5> Player Methods -- Returns an NSArray of Player Objects
````

    //Returns the list of followers for a player specified by playerID.
- (void)getFollowersForPlayer:(NSString*)playerID;

    //Returns the list of players followed by the player specified by playerID.
- (void)getPlayersFollowingPlayer:(NSString*)playerID;

    //Returns the list of players drafted by the player specified by playerID.
- (void)getPlayersDraftedByPlayer:(NSString*)playerID;

    // Returns a single Player Object
- (void)getPlayerProfile:(NSString*)playerID;

````

* * *
All results are returned via the DribbbleEngineDelegate. All the delegate methods are optional. It depends on your query which ones you'll want to use. 
<h3>DribbbleEngineDelegate methods</h3>
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
<h3>Installation</h3>
Just drag all of the files from the "DribbbleEngine" folder into your project. The only files you need are:

1. DribbbleEngine.h, DribbbleEngine.m
2. Shot.h, Shot.m
3. Player.h, Player.m
4. Comment.h, Comment.m
5. 
That's it for the installation.

* * * *
<h3>Example</h3>
Lets say you wanted to get a list of todays most popular shots. First thing youd have to do is import DribbbleEngine.h and make sure your controller conforms to the DribbbleEngine protocol. Like so:
<h5>
````
#import <UIKit/UIKit.h>
#import "DribbbleEngine.h"

@interface ViewController : UITableViewController<DribbbleEngineDelegate>

@end
````
The next thing we gotta do is create an instance of DribbbleEngine, set ourself as it's delegate, and query for one of the three different *ShotTypes*, in this case we're after the popular shots :
````
    DribbbleEngine *dribbbleEngine = [[DribbbleEngine alloc]init];
    dribbbleEngine.delegate = self;

    [dribbbleEngine getShotsForType:kShotTypePopular page:0];

````
When the DribbbleEngine is done one of two delegate methods will be invoked. If your interested in using pagination, a third method will be invoked with that info also:
````
- (void)dribbbleEngine:(DribbbleEngine *)engine didFailWithError:(NSError *)error{
    NSLog("Whoops an Error occured during our query!");
}

- (void)dribbbleEngine:(DribbbleEngine *)engine didFinishGatheringShots:(NSArray *)shots ofType:(ShotTypes)shotType{
    NSLog(@"Hurray we got back a list of Shot objects:%@",shots);
}

- (void)dribbbleEngine:(DribbbleEngine *)engine didSendPage:(NSInteger)pageSent of:(NSInteger)totalPages{
        NSLog(@"Displaying page %d of %d",pageSent,totalPages);
}
````
Each Shot Object has quite a bit of information such as it's ID, title, image URL's, Player, and much more. 
Have a look at Shot.h, Player.h, and Comment.h for all of the available variables.

Please have a look at the demo project to get an idea of how things work. And have a little fun! 

The demo included uses [Olivier Poitrey's](https://github.com/rs) extraordinarily useful [SDWebImage](https://github.com/rs/SDWebImage) library for image downloading and caching.


