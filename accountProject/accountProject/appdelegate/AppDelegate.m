//
//  AppDelegate.m
//  accountProject
//
//  Created by 弘鼎 on 2017/12/29.
//  Copyright © 2017年 贺亚飞. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Serve.h"
#import <BUAdSDK/BUAdSDKManager.h>
#import <BUAdSDK/BUAdSDK.h>

#define BUAID @"5122983"
#define normal_splash_ID @"887407551" //开屏广告位ID
#define un_splash_ID @"945641252" //插屏广告位ID
@interface AppDelegate ()<BUSplashAdDelegate>
@property (nonatomic, strong) BUSplashAdView *splashAdView;
@property (nonatomic, assign) CFTimeInterval startTime;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [self initWindow];
    [BUAdSDKManager setAppID:BUAID];
    [self addSplashAD];
    [self check];
    return YES;
}
-(void)check{
    [[HttpRequest sharedInstance] getWithURLString:@"https://mock.yonyoucloud.com/mock/16479/path" parameters:nil success:^(id responseObject) {
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([Dic[@"canshow"] integerValue]==1) {
            
        }else{
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            self.window.backgroundColor = KWhiteColor;
            [self.window makeKeyAndVisible];
            [[UIButton appearance] setExclusiveTouch:YES];
            self.window.rootViewController = [[UIViewController alloc] init];;
        }
        } failure:^(NSError *error) {
            
        }];
}
#pragma mark - Splash
- (void)addSplashAD {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.splashAdView = [[BUSplashAdView alloc] initWithSlotID:normal_splash_ID frame:frame];
    // tolerateTimeout = CGFLOAT_MAX , The conversion time to milliseconds will be equal to 0
    self.splashAdView.tolerateTimeout = 5;
    self.splashAdView.delegate = self;
    //optional
    self.splashAdView.needSplashZoomOutAd = YES;


    UIWindow *keyWindow = self.window;
    self.startTime = CACurrentMediaTime();
    [self.splashAdView loadAdData];
    [keyWindow.rootViewController.view addSubview:self.splashAdView];
    self.splashAdView.rootViewController = keyWindow.rootViewController;
}

- (void)removeSplashAdView {
    if (self.splashAdView) {
        [self.splashAdView removeFromSuperview];
        self.splashAdView = nil;
    }
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
    } else{
        // Be careful not to say 'self.splashadview = nil' here.
        // Subsequent agent callbacks will not be triggered after the 'splashAdView' is released early.
        [splashAd removeFromSuperview];
    }
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
        [splashAd.zoomOutView removeFromSuperview];
    }
    // Be careful not to say 'self.splashadview = nil' here.
    // Subsequent agent callbacks will not be triggered after the 'splashAdView' is released early.
    [splashAd removeFromSuperview];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    if (splashAd.zoomOutView) {
    } else{
        // Click Skip, there is no subsequent operation, completely remove 'splashAdView', avoid memory leak
        [self removeSplashAdView];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
