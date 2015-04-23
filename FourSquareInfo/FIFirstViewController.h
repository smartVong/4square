//
//  FIFirstViewController.h
//  FourSquareInfo
//
//  Created by Nattapat Vongchinsri on 4/20/2558 BE.
//  Copyright (c) 2558 Nattapat Vongchinsri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <CoreLocation/CoreLocation.h>
#import "FIFirstTableViewCell.h"
#import "FIInfoViewController.h"

@interface FIFirstViewController : UIViewController
<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) CLLocationManager *CLmanager;
@property (strong, nonatomic) NSArray *result;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
