//
//  MZSegmentController.h
//  MZSegmentController
//
//  Created by 邓文博 on 15/7/10.
//  Copyright (c) 2015年 邓文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZSegmentControllerDelegate.h"
#import "BannerHeaderView.h"
#import "SegmentView.h"

@interface MZSegmentController : UIViewController<UIScrollViewDelegate,SegmentViewDelegate>

@property (nonatomic, assign) CGFloat topBarHeight;

@property (nonatomic, assign) CGFloat segmentHeight;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat segmentToInset;

@property (nonatomic, strong) BannerHeaderView *headerView;
@property (nonatomic, strong) SegmentView *segmentView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray *controllers;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIViewController <MZSegmentControllerDelegate> *delegate;
@property (nonatomic, strong) UIViewController <MZSegmentControllerDelegate> *currentDisplayController;


-(instancetype)initWithControllers:(UIViewController<MZSegmentControllerDelegate> *)controller,... NS_DESIGNATED_INITIALIZER NS_REQUIRES_NIL_TERMINATION;

@end
