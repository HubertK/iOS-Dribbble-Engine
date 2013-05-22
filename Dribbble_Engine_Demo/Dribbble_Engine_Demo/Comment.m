//
//  Comment.m
//  Dribble_Engine
//
//  Copyright (c) 2013 Hubert Kunnemeyer. All rights reserved.
//

#import "Comment.h"
#import "Player.h"


@implementation Comment

- (id)initWithDictionary:(NSDictionary*)dribbleAttrs{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSArray *keys = [dribbleAttrs allKeys];
    for (NSString *key in keys) {
        if ([key isEqualToString:@"body"]) {
            _body = [dribbleAttrs valueForKey:@"body"];
        }
        if ([key isEqualToString:@"likes"]) {
            _likes = [NSNumber numberWithInt:[[dribbleAttrs valueForKey:@"body"]integerValue]];
        }
        if ([key isEqualToString:@"player"]) {
            NSDictionary *playerDict = [dribbleAttrs valueForKey:@"player"];
            Player *player = [[Player alloc]initWithDictionary:playerDict];
            _player = player;
        }
    }
    
    return self;
}

@end
