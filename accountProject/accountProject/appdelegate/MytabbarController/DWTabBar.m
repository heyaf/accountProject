//
//  DWTabBar.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWTabBar.h"


#define ButtonNumber 5


@interface DWTabBar ()


@end

@implementation DWTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
    }
    
    return self;
}



-(void)layoutSubviews{
    
    
    
    [super layoutSubviews];
    
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    
    CGFloat buttonW = barWidth / 3;
    CGFloat buttonH = barHeight - 1;
    if (ISIPHONEX) {
        buttonH = barHeight - 30;
    }
    CGFloat buttonY = 1;
    
    NSInteger buttonIndex = 0;
    
    
    
    for (UIView *view in self.subviews) {
        
        NSString *viewClass = NSStringFromClass([view class]);
        if (![viewClass isEqualToString:@"UITabBarButton"]) continue;

        CGFloat buttonX = buttonIndex * buttonW;
        
        
        view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        
        buttonIndex ++;
        
        
    }
}


@end
