//
//  Comment.h
//  Dribble_Engine
//
//  Copyright (c) 2013 Hubert Kunnemeyer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Player;

@interface Comment : NSObject

@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSNumber *likes;
@property (strong, nonatomic) Player *player;

- (id)initWithDictionary:(NSDictionary*)dribbleAttrs;

@end
