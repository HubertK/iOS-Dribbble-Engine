//
//  Shot.m
//  Dribbble
//
//  Copyright (c) 2013 Hubert Kunnemeyer. All rights reserved.
//

#import "Shot.h"

#import "Player.h"


@implementation Shot

@synthesize shotID = _shotID;
@synthesize title = _title;
@synthesize URL = _URL;
@synthesize short_url = _short_url;
@synthesize image_url = _image_url;
@synthesize image_teaser_url = _image_teaser_url;
@synthesize width = _width;
@synthesize height = _height;
@synthesize views_count = _views_count;
@synthesize likes_count = _likes_count;
@synthesize rebounds_count = _rebounds_count;
@synthesize rebound_source_id = _rebound_source_id;
@synthesize created_at = _created_at;
@synthesize player = _player;
@synthesize comments_count = _comments_count;

- (id)initWithDictionary:(NSDictionary*)dribbleShotsAttrs{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    NSArray *keys = [dribbleShotsAttrs allKeys];
    
    for (NSString *attr in keys) {
        
        
        id value = [dribbleShotsAttrs valueForKey:attr];
        
        if ([attr isEqualToString:@"id"]) {
            _shotID = value;
        }
        else if ([attr isEqualToString:@"title"]) {
            _title = value;
        }
        else if ([attr isEqualToString:@"url"]) {
            _URL = value;
        }
        else if ([attr isEqualToString:@"short_url"]) {
            _short_url = value;
        }
        else if ([attr isEqualToString:@"image_url"]) {
            _image_url = value;
        }
        else if ([attr isEqualToString:@"image_teaser_url"]) {
            _image_teaser_url = value;
        }
        else if ([attr isEqualToString:@"width"]) {
            
            _width = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"height"]) {
            _height = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"views_count"]) {
            _views_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"likes_count"]) {
            _likes_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"comments_count"]) {
            _comments_count = [NSNumber numberWithInt:[value integerValue]];
        }
        else if ([attr isEqualToString:@"rebounds_count"]) {
            _rebounds_count = [NSNumber numberWithInt:[value integerValue]];
        }else if ([attr isEqualToString:@"rebound_source_id"]) {
            _rebound_source_id = value;
        }else if ([attr isEqualToString:@"created_at"]) {
            _created_at = value;
        }else if ([attr isEqualToString:@"player"]) {
            NSDictionary *aPlayer = [dribbleShotsAttrs valueForKey:attr];
            _player = [[Player alloc]initWithDictionary:aPlayer];
        }
        
        
        
    }
    
    
    return self;
}

+ (Shot*)initWithDictionary:(NSDictionary*)dribbleShotsAttrs{
    return [self initWithDictionary:dribbleShotsAttrs];
}


@end
