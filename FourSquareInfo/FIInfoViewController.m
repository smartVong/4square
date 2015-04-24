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
    NSString *string = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?client_id=%@&client_secret=%@&v=20130815",self.info_id,FSCLIENT_ID,FSCLIENT_SECRET];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         self.landmark_info = [NSDictionary dictionaryWithDictionary:[[responseObject objectForKey:@"response"] objectForKey:@"venue"]];
         [self displayInfo];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    [operation start];
}

- (void)displayInfo
{
    if([[[self.landmark_info objectForKey:@"photos"] objectForKey:@"groups"] count]>0)
    {
        NSArray *photos = [[[[self.landmark_info objectForKey:@"photos"] objectForKey:@"groups"] objectAtIndex:0]objectForKey:@"items"];
        
        int rand = arc4random() % [photos count];
        
        NSString *url = [NSString stringWithFormat:@"%@%dx%d%@",[[photos objectAtIndex:rand] objectForKey:@"prefix"],(int)self.landmark_image.frame.size.width,(int)self.landmark_image.frame.size.height,[[photos objectAtIndex:rand] objectForKey:@"suffix"]];
        
        self.landmark_image.imageURL = [NSURL URLWithString:url];
    }
    else
    {
        self.landmark_image.backgroundColor = [UIColor blackColor];
    }
    self.landmark_name.text = [self.landmark_info objectForKey:@"name"];
    self.landmark_address.text = self.info_address;
    if([self.landmark_info objectForKey:@"rating"]!=nil)
    {
        self.landmark_rating.text = [NSString stringWithFormat:@"%.1f",[[self.landmark_info objectForKey:@"rating"] floatValue]];
    }
    else
    {
        self.landmark_rating.text = @"N/A";
    }
    self.landmark_likes.text = [NSString stringWithFormat:@"%d",[[[self.landmark_info objectForKey:@"likes"] objectForKey:@"count"] intValue]];
    
    [self.landmark_name sizeToFit];
    [self.landmark_address sizeToFit];
}

@end
