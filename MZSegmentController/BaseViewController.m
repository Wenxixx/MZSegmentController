//
//  BaseViewController.m
//  MZSegmentController
//
//  Created by 邓文博 on 15/7/13.
//  Copyright (c) 2015年 邓文博. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewExt.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableHeaderView:[self setTableHeaderView]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view from its nib.
}

-(UIView *)setTableHeaderView
{
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 131*RatioX)];
    View.backgroundColor = [UIColor clearColor];
    return View;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MZSegmentControllerDelegate
- (void)setTableContentOffSet:(CGFloat)offset
{
    if (offset >= self.tableView.tableHeaderView.height) {
        if (self.tableView.contentOffset.y < self.tableView.tableHeaderView.height) {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.tableHeaderView.height)];
            if (self.tableView.contentSize.height<(self.tableView.height+self.tableView.tableHeaderView.height)) {
                [self.tableView setContentSize:CGSizeMake(Screen_Width, self.tableView.height+self.tableView.tableHeaderView.height)];
            }
        }
    }
    else{
        [self.tableView setContentOffset:CGPointMake(0, offset)];
    }
    
}

-(UIScrollView *)currentScrollView
{
    return self.tableView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell %ld",indexPath.row];
    return cell;
}

//#pragma mark - UITableViewDelegate
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
