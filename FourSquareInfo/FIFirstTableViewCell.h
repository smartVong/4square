//
//  FIFirstTableViewCell.h
//  FourSquareInfo
//
//  Created by Nattapat Vongchinsri on 4/21/2558 BE.
//  Copyright (c) 2558 Nattapat Vongchinsri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncImageView/AsyncImageView.h>

@interface FIFirstTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *landmark_name;
@property (strong, nonatomic) IBOutlet UILabel *landmark_address;

@end
