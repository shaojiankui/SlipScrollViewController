//
//  MainViewController.m
//  SideSlipViewController
//
//  Created by Jakey on 15/1/14.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "SlipScrollViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)showLeftTouched:(id)sender {
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
   SlipScrollViewController *slip =  (SlipScrollViewController*)app.rooViewController;
    [slip showView:slipLeft];
}

- (IBAction)showMain:(id)sender {
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    SlipScrollViewController *slip =  (SlipScrollViewController*)app.rooViewController;
    [slip showView:slipMain];
}
@end
