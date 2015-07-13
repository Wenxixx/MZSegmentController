//
//  MZSegmentControllerDelegate.h
//  MZSegmentController
//
//  Created by 邓文博 on 15/7/10.
//  Copyright (c) 2015年 邓文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MZSegmentControllerDelegate <NSObject>

@optional

// container 内 VC
- (UIScrollView *)currentScrollView;
- (void)setTableContentOffSet:(CGFloat)offset;
- (void)reloadData;

//首页HomePage代理
- (void) showIvLogo:(BOOL)flag;
- (void) refreshHomePageSegmentControl:(NSInteger) index;
- (void) containerViewItemIndex:(NSInteger)index currentController:(UIViewController <MZSegmentControllerDelegate> *)controller;

@end
