//
//  FIInfoViewController.h
//  FourSquareInfo
//
//  Created by Nattapat Vongchinsri on 4/22/2558 BE.
//  Copyright (c) 2558 Nattapat Vongchinsri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AsyncImageView/AsyncImageView.h>

@interface FIInfoViewController : UIViewController

@property (strong, nonatomic) NSString *info_id;
@property (strong, nonatomic) NSString *info_address;
@property (strong, nonatomic) NSDictionary *landmark_info;

@property (strong, nonatomic) IBOutlet AsyncImageView *landmark_image;
@property (strong, nonatomic) IBOutlet UILabel *landmark_name;
@property (strong, nonatomic) IBOutlet UILabel *landmark_address;
@property (strong, nonatomic) IBOutlet UILabel *landmark_rating;
@property (strong, nonatomic) IBOutlet UILabel *landmark_likes;

@end
