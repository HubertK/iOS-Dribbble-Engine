//
//  Shot.h
//  Dribbble
//
//  Copyright (c) 2013 Hubert Kunnemeyer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Player;

@interface Shot : NSObject

@property (nonatomic, strong) NSString *shotID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *URL;
@property (nonatomic, strong) NSString *short_url;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *image_teaser_url;


@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *views_count;
@property (nonatomic, strong) NSNumber *likes_count;
@property (nonatomic, strong) NSNumber *comments_count;

@property (nonatomic, strong) NSNumber *rebounds_count;

@property (nonatomic, strong) NSString *rebound_source_id;
@property (nonatomic, strong) NSString *created_at;

@property (strong, nonatomic) Player *player;

- (id)initWithDictionary:(NSDictionary*)dribbleShotsAttrs;

@end
