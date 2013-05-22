//
//  HKConnection.h
//
//  Created by Hubert Kunnemeyer on 4/26/12.
//  Copyright (c) 2012 Hubert Kunnemeyer. All rights reserved.
//

typedef void (^HKConnectionBlock)(NSData* resultData, NSError *error);

#import <Foundation/Foundation.h>
@interface HKConnection : NSObject

@property (strong, nonatomic) NSMutableData *requestdata;
@property (copy, nonatomic) HKConnectionBlock callBackBlock;


- (id)initWithURL:(NSURL *)URL callback:(HKConnectionBlock)block;
@end
