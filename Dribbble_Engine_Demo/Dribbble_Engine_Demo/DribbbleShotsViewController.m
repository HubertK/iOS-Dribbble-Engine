//
//  DribbbleShotsViewController.m
//  Dribble_Engine
//
//  Copyright (c) 2013 Hubert Kunnemeyer. All rights reserved.
//

#import "DribbbleShotsViewController.h"
#import "UIImageView+WebCache.h"
#import "DribbbleEngine.h"

#import "Player.h"
#import "Shot.h"

#import "ShotCell.h"


@interface DribbbleShotsViewController ()<DribbbleEngineDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *shotTypeControl;
@property (strong, nonatomic) NSMutableArray *shots;
- (IBAction)didChangeShotType:(id)sender;
@end

@implementation DribbbleShotsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadShotsOfType:kShotTypePopular];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_shots count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShotCell";
    ShotCell *cell = (ShotCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Shot *shot = _shots[indexPath.row];
    cell.shotTitle.text = shot.title;
    [cell.shotImage setImageWithURL:[NSURL URLWithString:shot.image_teaser_url] placeholderImage:[UIImage imageNamed:@"dribbble-icon.png"]];
    
    Player *player = shot.player;
    cell.playerName.text = player.name;
    return cell;
}
- (void)dribbbleEngine:(DribbbleEngine *)engine didFailWithError:(NSError *)error{
    
}

- (void)dribbbleEngine:(DribbbleEngine *)engine didFinishGatheringShots:(NSArray *)shots ofType:(ShotTypes)shotType{
   
   
        _shots = [NSMutableArray arrayWithArray:shots];
        
        [self.tableView reloadData];
}


- (IBAction)didChangeShotType:(id)sender {
   
    [self loadShotsOfType:_shotTypeControl.selectedSegmentIndex];
  
}



- (void)loadShotsOfType:(ShotTypes)type{
    
    DribbbleEngine *dribbbleEngine = [[DribbbleEngine alloc]init];
    dribbbleEngine.delegate = self;

    [dribbbleEngine getShotsForType:type page:0];
    NSString *title = [NSString string];
    switch (type) {
        case kShotTypePopular:
            title = @"Dribbble Popular";
            break;
        case kShotTypeDebuts:
            title = @"Dribbble Debuts";
            break;
        case kShotTypeEveryone:
            title = @"Dribbble Everyone";
            break;
            
        default:
            break;
    }
    [self setTitle:title];
}



    // Example of how you could use the completionBlock to load all shots at one after another
/*
- (void)loadAllShots{
   
    DribbbleEngine *dribbbleEngine = [[DribbbleEngine alloc]init];
    dribbbleEngine.delegate = self;
    
        // Use the completion block to load the next set of shots
    [dribbbleEngine getShotsForType:kShotTypePopular page:0 complete:^(BOOL finished) {
        
        [dribbbleEngine getShotsForType:kShotTypeDebuts page:0 complete:^(BOOL finished) {
            
            [dribbbleEngine getShotsForType:kShotTypeEveryone page:0 complete:nil];
        }];
    }];
}

*/




@end
