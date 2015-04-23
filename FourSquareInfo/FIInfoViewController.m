//
//  FIInfoViewController.m
//  FourSquareInfo
//
//  Created by Nattapat Vongchinsri on 4/22/2558 BE.
//  Copyright (c) 2558 Nattapat Vongchinsri. All rights reserved.
//

#import "FIInfoViewController.h"

@interface FIInfoViewController ()

@end

@implementation FIInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = @"Landmarks Info";
    
    [self getInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getInfo
{
    NSString *url = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?client_id=%@&client_secret=%@&v=20130815",self.info_id,FSCLIENT_ID,FSCLIENT_SECRET];
    NSLog(@"%@",url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject)
     {
         self.landmark_info = [NSDictionary dictionaryWithDictionary:[[responseObject objectForKey:@"response"] objectForKey:@"venue"]];
         [self displayInfo];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}

- (void)displayInfo
{
    NSArray *photos = [[[[self.landmark_info objectForKey:@"photos"] objectForKey:@"groups"] objectAtIndex:0]objectForKey:@"items"];
    int rand = arc4random() % [photos count];
    
    NSString *url = [NSString stringWithFormat:@"%@%dx%d%@",[[photos objectAtIndex:rand] objectForKey:@"prefix"],(int)self.landmark_image.frame.size.width,(int)self.landmark_image.frame.size.height,[[photos objectAtIndex:rand] objectForKey:@"suffix"]];
    
    self.landmark_image.imageURL = [NSURL URLWithString:url];
    self.landmark_name.text = [self.landmark_info objectForKey:@"name"];
    self.landmark_address.text = self.info_address;
    self.landmark_rating.text = [NSString stringWithFormat:@"%.1f",[[self.landmark_info objectForKey:@"rating"] floatValue]];
    self.landmark_likes.text = [NSString stringWithFormat:@"%d",[[[self.landmark_info objectForKey:@"likes"] objectForKey:@"count"] intValue]];
    
    [self.landmark_name sizeToFit];
    [self.landmark_address sizeToFit];
}

@end
