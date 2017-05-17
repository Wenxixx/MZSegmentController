# MZSegmentController

# Description
  类似AppStore详情页结构，左右视图可滑动，可tab切换
  可自定义segmentHeaderView，多视图共用，header纵向可滑动
  
  
# <a id="Examples"></a> Examples

* init初始化

```
    BaseViewController *tabViewVC1 = [[BaseViewController alloc] initWithNibName:@"BaseViewController"   bundle:nil];
    BaseViewController *tabViewVC2 = [[BaseViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    BaseViewController *tabViewVC3 = [[BaseViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    
    self.pager = [[MZSegmentController alloc] initWithControllers:tabViewVC1,tabViewVC2,tabViewVC3,nil];
    
    [self.view addSubview:_pager.view];
```    

* BaseViewController都带有UITableView（UIScrollview）
  
   *  给tableview设置一个跟SegmentController中HeaderView一样高度的headerView，
   *  保证滑动tableView时SegmentController中HeaderView的frame.origin.y的值与tableView.contentOffSet.y改变保持一致(障眼法)
   *  @return UIView
      
    
   ```
    	 -(UIView *)setTableHeaderView
    	 {
         
    	 }
  ```
     
   
   
   
* `#pragma mark - MZSegmentControllerDelegate`

```
      /**
 	*  确保MZSegmentController的scrollView上的多个controller实现同步隐藏headerView，或露出的高度一致
  	*
   	*  @param offset visiable controller contentOffset.y的值
  	*/
  
       - (void)setTableContentOffSet:(CGFloat)offset
       {
      
       }
```

*  `#pragma mark - obsever delegate methods`
  
  ```
  //headerView  跟随当前显示tableView滑动而滑动
    
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
  ```




  

