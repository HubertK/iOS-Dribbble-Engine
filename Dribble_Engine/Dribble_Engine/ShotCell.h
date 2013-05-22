//
//  ShotCell.h
//  Dribble_Engine
//
//  Copyright (c) 2013 Hubert Kunnemeyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShotCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shotImage;
@property (weak, nonatomic) IBOutlet UILabel *shotTitle;
@property (weak, nonatomic) IBOutlet UILabel *playerName;

@end
