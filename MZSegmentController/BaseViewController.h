//
//  BaseViewController.h
//  MZSegmentController
//
//  Created by 邓文博 on 15/7/13.
//  Copyright (c) 2015年 邓文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZSegmentControllerDelegate.h"

#define Screen_Width    [UIScreen mainScreen].bounds.size.width
#define Screen_Height   [UIScreen mainScreen].bounds.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define RatioX         (MIN(Screen_Width,Screen_Height))/320.0
#define ORANGE_COLOR  RGBACOLOR(245, 101, 0, 1)

@interface BaseViewController : UIViewController<MZSegmentControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
