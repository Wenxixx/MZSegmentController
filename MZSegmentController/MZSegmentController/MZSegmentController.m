//
//  MZSegmentController.m
//  MZSegmentController
//
//  Created by 邓文博 on 15/7/10.
//  Copyright (c) 2015年 邓文博. All rights reserved.
//

#import "MZSegmentController.h"
#import "UIViewExt.h"

const void* _MZSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET = &_MZSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET;

@implementation MZSegmentController



-(instancetype)initWithControllers:(UIViewController<MZSegmentControllerDelegate> *)controller, ...
{
    self = [super init];
    if (self) {
        NSAssert(controller != nil, @"the first controller must not be nil!");
      
        self.segmentToInset = 0;
        self.topBarHeight = 64.f;
        self.controllers = [NSMutableArray array];
        UIViewController<MZSegmentControllerDelegate> *eachController;
        va_list argumentList;
        if (controller)
        {
            [self.controllers addObject: controller];
            va_start(argumentList, controller);
            while ((eachController = va_arg(argumentList, id)))
            {
                [self.controllers addObject:eachController];
            }
            va_end(argumentList);
        }
    }
    return self;
}

-(void)viewDidLoad
{
    // ContentScrollview setup
    _topBarHeight = 64.f;
    _contentScrollView = [[UIScrollView alloc] init];
    _contentScrollView.frame = CGRectMake(0,_topBarHeight, self.view.frame.size.width, self.view.frame.size.height-_topBarHeight);
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    //    _contentScrollView.scrollsToTop = NO;
    
    [self.view addSubview:_contentScrollView];
    _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * self.controllers.count, _contentScrollView.frame.size.height);
    
    // ContentViewController setup
    for (int i = 0; i < self.controllers.count; i++) {
        id obj = [self.controllers objectAtIndex:i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            CGFloat scrollWidth = _contentScrollView.frame.size.width;
            CGFloat scrollHeght = _contentScrollView.frame.size.height;
            controller.view.frame = CGRectMake(i * scrollWidth, 0, scrollWidth, scrollHeght);
            [_contentScrollView addSubview:controller.view];
        }
    }
    
    self.currentDisplayController = self.controllers[0];
    [self addObserverForPageController:self.currentDisplayController];
    
    //添加下拉刷新
    //    [self addTableViewHeader];
    
    // headerView
    _currentIndex = 0;
    _headerView = [[BannerHeaderView alloc]initWithFrame:CGRectMake(0, _topBarHeight, self.view.width, 92*RatioX)];
    _headerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_headerView];
    
    //segmentView
    _segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, self.view.width,39*RatioX)];
    _segmentView.delegate = self;
    [_segmentView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_segmentView];
    
    _headerHeight = _headerView.height;
    _segmentHeight = _segmentView.height;
}



#pragma mark -- private

- (void)setChildViewControllerWithCurrentIndex:(NSInteger)currentIndex
{
    for (int i = 0; i < self.controllers.count; i++) {
        id obj = self.controllers[i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            if (i == currentIndex) {
                [controller willMoveToParentViewController:self];
                [self addChildViewController:controller];
                [controller didMoveToParentViewController:self];
            } else {
                [controller willMoveToParentViewController:self];
                [controller removeFromParentViewController];
                [controller didMoveToParentViewController:self];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGFloat offsetY = [[self.currentDisplayController currentScrollView] contentOffset].y;
    //调整另外viewController contentOffSet
    for (int i = 0; i<[_controllers count]; i++) {
        if (i!=_currentIndex) {
            UIViewController <MZSegmentControllerDelegate> *vc = _controllers[i];
            [vc setTableContentOffSet:offsetY];
        }
    }
}

-(void)scrollToCurrentIndex:(NSInteger)currentIndex
{
    
    [_contentScrollView setContentOffset:CGPointMake(currentIndex * _contentScrollView.frame.size.width, 0.) animated:YES];
    //调整另外viewController contentOffSet
    CGFloat offsetY = [[self.currentDisplayController currentScrollView] contentOffset].y;
    for (int i = 0; i<[_controllers count]; i++) {
        if (i!=_currentIndex) {
            UIViewController <MZSegmentControllerDelegate> *vc = _controllers[i];
            [vc setTableContentOffSet:offsetY];
        }
    }
    //刷新首页导航条上选择
    [self.delegate refreshHomePageSegmentControl:currentIndex];
    //更新segmentView上选择
    [self.segmentView updateSegmentControl:currentIndex];
    //刷新视图
    [self setChildViewControllerWithCurrentIndex:currentIndex];
    //移除之前表KVO
    [self removeObseverForPageController:self.currentDisplayController];
    self.currentIndex = currentIndex;
    self.currentDisplayController = self.controllers[self.currentIndex];
    //给当前表添加KVO
    [self addObserverForPageController:self.currentDisplayController];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentIndex = scrollView.contentOffset.x / _contentScrollView.frame.size.width;
    if (currentIndex == self.currentIndex) { return; }
    [self scrollToCurrentIndex:currentIndex];
}


-(UIScrollView *)scrollViewInPageController:(UIViewController <MZSegmentControllerDelegate> *)controller
{
    if ([controller respondsToSelector:@selector(currentScrollView)]) {
        return [controller currentScrollView];
    }else if ([controller.view isKindOfClass:[UIScrollView class]]){
        return (UIScrollView *)controller.view;
    }else{
        return nil;
    }
}

#pragma mark - add / remove obsever for page scrollView

-(void)addObserverForPageController:(UIViewController <MZSegmentControllerDelegate> *)controller
{
    UIScrollView *scrollView = [self scrollViewInPageController:controller];
    if (scrollView != nil) {
        [scrollView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew context:&_MZSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET];
    }
}

-(void)removeObseverForPageController:(UIViewController <MZSegmentControllerDelegate> *)controller
{
    UIScrollView *scrollView = [self scrollViewInPageController:controller];
    if (scrollView != nil) {
        @try {
            [scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
        }
        @catch (NSException *exception) {
            NSLog(@"exception is %@",exception);
        }
        @finally {
            
        }
    }
}

#pragma mark - obsever delegate methods

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == _MZSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET) {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat offsetY = offset.y;
        
        if (offsetY < (self.segmentHeight + self.headerHeight + _topBarHeight)) {
            CGRect frame = _headerView.frame;
            frame.origin.y = -offsetY+_topBarHeight;
            _headerView.frame = frame;
            
            frame = _segmentView.frame;
            frame.origin.y = _headerView.bottom;
            _segmentView.frame = frame;
            [self.delegate showIvLogo:YES];
        }
        else {  //完全隐藏HeaderView
            
            CGRect frame = _headerView.frame;
            frame.origin.y = -(self.segmentHeight + self.headerHeight + _topBarHeight);
            _headerView.frame = frame;
            
            frame = _segmentView.frame;
            frame.origin.y = _headerView.bottom;
            _segmentView.frame = frame;
            
            [self.delegate showIvLogo:NO];
        }
    }
}


#pragma mark - SegmentViewDelegate
-(void)sengmentSelectedAtIndex:(NSInteger )index
{
    [self scrollToCurrentIndex:index];
}



@end
