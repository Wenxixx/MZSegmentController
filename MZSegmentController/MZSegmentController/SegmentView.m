//
//  SegmentView.m
//  MZSegmentController
//
//  Created by 邓文博 on 15/7/11.
//  Copyright (c) 2015年 邓文博. All rights reserved.
//

#import "SegmentView.h"
#import "UIViewExt.h"

@implementation SegmentView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20*RatioX, 10*RatioX, self.width-40*RatioX, 29*RatioX)];
        _backGroundImageView.userInteractionEnabled = YES;
        [_backGroundImageView setImage: [UIImage imageNamed:@"nemuBcg_pic"]];
        [self addSubview:_backGroundImageView];
        CGFloat btnWidth = _backGroundImageView.frame.size.width / 3;
        
        self.selectedIndex = 0;
        
        for (int i=0; i<3; i++) {
            UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMenu.frame = CGRectMake(i*btnWidth, 0, btnWidth, _backGroundImageView.frame.size.height);
            btnMenu.backgroundColor = [UIColor clearColor];
            [btnMenu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btnMenu setTitleColor:ORANGE_COLOR forState:UIControlStateSelected];
            [btnMenu.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            
            btnMenu.tag = i+1;
            [btnMenu addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                [btnMenu setTitle:@"推荐" forState:UIControlStateNormal];
                btnMenu.selected = YES;
            }
            else {
                NSString *title = i==1?@"热映影片":@"即将上映";
                [btnMenu setTitle:title forState:UIControlStateNormal];
            }
            [_backGroundImageView addSubview:btnMenu];
        }
    }
    return self;
}



- (void)buttonPress:(UIButton *)sender
{
    if (self.selectedIndex == sender.tag-1)
        return;
    [self updateSegmentControl:sender.tag-1];
    
    if ([self.delegate respondsToSelector:@selector(sengmentSelectedAtIndex:)]) {
        [self.delegate sengmentSelectedAtIndex:sender.tag-1];
    }
}

-(void) updateSegmentControl:(NSInteger) index
{
    self.selectedIndex = index;
    for (int i = 0;i<3;i++) {
        UIButton *button = (UIButton *)[_backGroundImageView viewWithTag:i+1];
        if (index == i) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}



@end
