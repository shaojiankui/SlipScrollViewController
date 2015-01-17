//
//  AppDelegate.h
//  SlipScrollViewController
//
//  Created by Jakey on 15/1/17.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlipScrollViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SlipScrollViewController *rooViewController;
@property (strong, nonatomic) UINavigationController *navgationController;
@end

