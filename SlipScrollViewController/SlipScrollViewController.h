//
//  SlipScrollViewController.h
//  SlipScrollViewController
//
//  Created by Jakey on 15/1/17.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    slipLeft,
    slipMain
}SlipType;

@interface SlipScrollViewController : UIViewController<UIScrollViewDelegate>
{
    CGFloat _contentOldX;

}
@property (strong,nonatomic) UIViewController *leftViewController;
@property (strong,nonatomic) UIViewController *mainViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (assign, nonatomic)  CGFloat offWidth;

-(void)showView:(SlipType)type;
@end
