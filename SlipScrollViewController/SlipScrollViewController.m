//
//  SlipScrollViewController.m
//  SlipScrollViewController
//
//  Created by Jakey on 15/1/17.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "SlipScrollViewController.h"

@interface SlipScrollViewController ()

@end

@implementation SlipScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.decelerationRate= 10;
    [self.scrollView.panGestureRecognizer addTarget:self action:@selector(handlePan:)];
    self.offWidth = 150;
}
//滑动手势
- (void)handlePan: (UIPanGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan){
       
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        
        
    }
    
    //手势结束后修正位置
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (self.scrollView.contentOffset.x >75 && self.scrollView.contentOffset.x <=150 ) {
            [self showView:slipMain];
        }else{
            [self showView:slipLeft];
            
        }
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self buidViews];
}
-(void)buidViews{
    CGRect rect = [UIScreen mainScreen].bounds;

    [self.view insertSubview:self.leftViewController.view belowSubview:self.scrollView];
    self.leftViewController.view.frame = CGRectMake(0, 0, self.leftViewController.view.frame.size.width, rect.size.height);

    [self.scrollView addSubview:self.mainViewController.view];
    self.mainViewController.view.frame = CGRectMake(self.offWidth, 0, rect.size.width, rect.size.height);

    self.scrollView.contentSize = CGSizeMake(rect.size.width + self.offWidth, rect.size.height);
    _contentOldX = self.mainViewController.view.center.x;
    self.scrollView.contentOffset = CGPointMake(self.offWidth, 0);


}

#pragma mark

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // NSLog(@"scrollView.contentOffset.x%f",scrollView.contentOffset.x);
    
    CGFloat offX = -(scrollView.contentOffset.x - self.offWidth);
    NSLog(@"offX.x%f",offX);

    float rightScale = 1- offX/([UIScreen mainScreen].bounds.size.width/0.5);
  //  NSLog(@"rightScale:%f",rightScale);

    [UIView animateWithDuration:0 animations:^{
        self.mainViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,rightScale,rightScale);
        self.mainViewController.view.center = CGPointMake(_contentOldX + offX/4, self.mainViewController.view.center.y);
    } completion:^(BOOL finished) {
        if (scrollView.contentOffset.x == 0) {
            [self.view bringSubviewToFront:self.leftViewController.view];
        }else{
            [self.view bringSubviewToFront:self.scrollView];
        }
  
    }];
    [self shadowWithType:slipLeft];
    [self statusBarNeedsAppearanceUpdate];

}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //do something here
}
#pragma mark - 修改视图位置
-(void)showView:(SlipType)type{
    CGPoint scale;
    if (type == slipLeft) {
        scale = CGPointMake(0, 0);
    }else{
        scale = CGPointMake(self.offWidth, 0);
    }
    
    
   [UIView animateWithDuration:0.1 animations:^{
        self.scrollView.contentOffset = scale;
   } completion:^(BOOL finished) {
       if (type == slipLeft) {
            [self.view bringSubviewToFront:self.leftViewController.view];
       }else{
        [self.view bringSubviewToFront:self.scrollView];
       }


   }];
    [self statusBarNeedsAppearanceUpdate];
    
    
}
-(void)killScroll{
    self.scrollView.scrollEnabled = NO;
    self.scrollView.scrollEnabled = YES;
}
-(void)shadowWithType:(SlipType)type{
    CGFloat shadowWidth = 0;
    switch (type) {
        case slipLeft:
            shadowWidth = -3.0f;
            break;
        default:
            break;
    }
    self.mainViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainViewController.view.layer.shadowOffset = CGSizeMake(shadowWidth, 1.0f);
    self.mainViewController.view.layer.shadowOpacity = 0.8f;
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIStatusBarStyle statusBarStyle = UIStatusBarStyleDefault;
    if (self.mainViewController.view.frame.origin.y > 10) {
        statusBarStyle = UIStatusBarStyleLightContent;
    } else {
        statusBarStyle = self.mainViewController.preferredStatusBarStyle;
    }
    return statusBarStyle;
}

- (void)statusBarNeedsAppearanceUpdate
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [UIView animateWithDuration:0.3f animations:^{
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        }];
    }
}

@end
