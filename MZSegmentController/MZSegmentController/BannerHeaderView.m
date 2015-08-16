//
//  BannerHeaderView.m
//  MZSegmentController
//
//  Created by 邓文博 on 15/7/11.
//  Copyright (c) 2015年 邓文博. All rights reserved.
//

#import "BannerHeaderView.h"
#import "UIViewExt.h"

@implementation BannerHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         self.bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bannerScrollView.backgroundColor = [UIColor clearColor];
        _bannerScrollView.pagingEnabled = YES;
        _bannerScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_bannerScrollView];
        [_bannerScrollView setBackgroundColor:[UIColor redColor]];
        
        self.pagControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,80 , self.width, 10)];
        _pagControl.defersCurrentPageDisplay = YES;
        _pagControl.hidesForSinglePage = YES; //一个图片则影藏点
        _pagControl.pageIndicatorTintColor = [UIColor grayColor];
        _pagControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pagControl];
        
        _bannerArray = [[NSMutableArray alloc] init];
        
        [self refreshBannerViewWithBannerList:_bannerArray];
    }
    return self;
}

-(void)refreshBannerViewWithBannerList:(NSMutableArray *)bannerList
{
    self.bannerArray = bannerList;
    _pagControl.numberOfPages = bannerList.count;

    if (_bannerArray.count == 1 || _bannerArray.count == 0) {
        _bannerScrollView.contentSize = CGSizeMake(self.width, 0);
    } else {
        _bannerScrollView.contentSize = CGSizeMake((_bannerArray.count+1) * self.width, 0);
    }
    if (_bannerURLArrary.count != 0) {
        if (_bannerURLArrary.count+1 <= _currentBannerCount) {
            for (int i=0; i<_currentBannerCount; i++) {
                if (i < _bannerImgArray.count) {
                    UIButton *button = (UIButton *)[self viewWithTag:10000+i];
                    [((UIImageView *)button.subviews[0]) setImage:[UIImage imageNamed:@"icon_bannerInfoImg"]];
                } else if (i == _bannerImgArray.count) {
                    UIButton *button = (UIButton *)[self viewWithTag:10000+i];
                    ;
                    [((UIImageView *)button.subviews[0]) setImage:[UIImage imageNamed:@"icon_bannerInfoImg"]];
                    
                } else {
                    UIButton *button = (UIButton *)[self viewWithTag:10000+i];
                    [button removeFromSuperview];
                }
            }
        } else {
            for (int i=0; i<=_bannerImgArray.count; i++) {
                if (i<_currentBannerCount) {
                    UIButton *button = (UIButton *)[self viewWithTag:10000+i];
                    ((UIImageView *)button.subviews[0]).image = _bannerImgArray[i];
                    
                } else  {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.width, self.height )];
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
                    button.tag = 10000 + i;
                    [button addSubview:imgView];
                    button.userInteractionEnabled = YES;
                    [button addTarget:self action:@selector(pushToInlineWeb:) forControlEvents:UIControlEventTouchUpInside];
                    [_bannerScrollView addSubview:button];
                }
            }
        }
        _currentBannerCount = _bannerImgArray.count+1;
        if (!_timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScrollBanner) userInfo:nil repeats:YES];
        }
    } else {
        _bannerScrollView.contentSize = CGSizeMake(self.width, 0);
        _currentBannerCount = _bannerImgArray.count+0;
        UIImage *img = [UIImage imageNamed:@"icon_bannerInfoImg"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
        imageView.frame = CGRectMake(0, 0, self.width, self.height);
        [_bannerScrollView addSubview:imageView];
        
    }

}

-(void)pushToInlineWeb:(UIButton *)sender
{

}

-(void)autoScrollBanner
{
    CGFloat page = _bannerScrollView.contentOffset.x / self.frame.size.width;
    if (_bannerImgArray.count != 1) {      //当到最后一张图时迅速切换到第一张图
        if (page == _bannerImgArray.count) {
            page = -1;
            _bannerScrollView.contentOffset = CGPointMake(((page+1) *self.frame.size.width) , 0);
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                _bannerScrollView.contentOffset = CGPointMake(((page+1) *self.frame.size.width) , 0);
            }];
        }
    }
}


@end
