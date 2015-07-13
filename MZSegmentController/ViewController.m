//
//  ViewController.m
//  MZSegmentController
//
//  Created by 邓文博 on 15/7/10.
//  Copyright (c) 2015年 邓文博. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
#import "MZSegmentController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNav];
    
    BaseViewController *tabViewVC1 = [[BaseViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    BaseViewController *tabViewVC2 = [[BaseViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    BaseViewController *tabViewVC3 = [[BaseViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    
    self.pager = [[MZSegmentController alloc] initWithControllers:tabViewVC1,tabViewVC2,tabViewVC3,nil];
    [self.view addSubview:_pager.view];

    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - loadNav and headView method
- (void)loadNav
{    
    _btnCity = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnCity.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [_btnCity addTarget:self action:@selector(changeCityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_btnCity setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnCity setFrame:CGRectMake(0, 0, 20+ 21 + 10, 21)];
    [_btnCity setImage:[UIImage imageNamed:@"location_pic"] forState:UIControlStateNormal];
    [_btnCity setTitle:@"深圳" forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_btnCity];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)changeCityBtnClicked:(UIButton *)sender
{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
