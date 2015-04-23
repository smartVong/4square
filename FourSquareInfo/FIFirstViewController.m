//
//  FIFirstViewController.m
//  FourSquareInfo
//
//  Created by Nattapat Vongchinsri on 4/20/2558 BE.
//  Copyright (c) 2558 Nattapat Vongchinsri. All rights reserved.
//

#import "FIFirstViewController.h"

@interface FIFirstViewController ()

@end

@implementation FIFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = @"Landmarks Around You";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.CLmanager = [[CLLocationManager alloc] init];
    self.CLmanager.delegate = self;
    [self.CLmanager requestWhenInUseAuthorization];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - 4square API caller
- (void)getInfo:(CLLocationCoordinate2D)locations
{
    NSString *url = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20130815&ll=%f,%f&radius=10000&limit=50",FSCLIENT_ID,FSCLIENT_SECRET,locations.latitude,locations.longitude];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject)
     {
         self.result = [NSArray arrayWithArray:[[responseObject objectForKey:@"response"] objectForKey:@"venues"]];
         [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma  mark - UITableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.result count];
}

- (FIFirstTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"FirstViewCell";
    
    FIFirstTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        [self.tableView registerNib:[UINib nibWithNibName:@"FIFirstTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    NSDictionary *row = [self.result objectAtIndex:indexPath.row];
    NSArray *location = [[row objectForKey:@"location"] objectForKey:@"formattedAddress"];
    cell.landmark_name.text = [row objectForKey:@"name"];
    NSString* address = @"";
    for (int i=0;i<[location count];i++)
    {
        if(i==0)
        {
            address = [address stringByAppendingFormat:@"%@",[location objectAtIndex:i]];
        }
        else
        {
            address = [address stringByAppendingFormat:@", %@",[location objectAtIndex:i]];
        }
    }
    cell.landmark_address.text = address;
    [cell.landmark_address sizeToFit];
    [cell.landmark_name sizeToFit];
    
    return cell;
}

#pragma  mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(FIFirstTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, cell.frame.size.height);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FIInfoViewController *infoVC = [[FIInfoViewController alloc] initWithNibName:@"FIInfoViewController" bundle:nil];
    infoVC.info_id = [[self.result objectAtIndex:indexPath.row] objectForKey:@"id"];
    infoVC.info_address = ((FIFirstTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath]).landmark_address.text;
    [self.navigationController pushViewController:infoVC animated:YES];
}

#pragma  mark - CLLocation Delegates
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self getInfo:manager.location.coordinate];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        self.CLmanager.distanceFilter = kCLDistanceFilterNone;
        self.CLmanager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.CLmanager startUpdatingLocation]; // if real device will use monitor-significant-update
    }
}

@end
