//
//  Player.h
//  Dribble
//
//  Created by Hubert Kunnemeyer on 9/11/12.
//  Copyright (c) 2012 Hubert Kunnemeyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *playerID;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *URL;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) NSString *twitter_screen_name;
@property (strong, nonatomic) NSString *location;


@property (nonatomic, strong) NSNumber *shot_Count;
@property (nonatomic, strong) NSNumber *followers_count;
@property (nonatomic, strong) NSNumber *following_count;
@property (nonatomic, strong) NSNumber *draftees_count;
@property (nonatomic, strong) NSNumber *comments_count;
@property (nonatomic, strong) NSNumber *comments_received_count;

@property (nonatomic, strong) NSNumber *likes_count;
@property (nonatomic, strong) NSNumber *likes_received_count;
@property (nonatomic, strong) NSNumber *rebounds_count;
@property (nonatomic, strong) NSNumber *rebounds_received_count;

//+ (Player*)initWithDictionary:(NSDictionary*)dribblePersonAttrs;
- (id)initWithDictionary:(NSDictionary*)dribblePersonAttrs;



@end
