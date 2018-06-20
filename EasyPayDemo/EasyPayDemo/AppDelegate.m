//
//  AppDelegate.m
//  EasyPayDemo
//
//  Created by 毛宏鹏 on 2018/4/16.
//  Copyright © 2018年 sfbm. All rights reserved.
//

#import "AppDelegate.h"
//微信支付注册
#import "WXApi.h"
#import "WXApiManager.h"
//支付宝支付
#import <AlipaySDK/AlipaySDK.h>
//好易支付
#import <HaoEasyPaySDK/HaoEasyPaySDK.h>

#import "Commens.h"
#import "MostCommonIndicatorShow.h"
//微信支付appid
#define WEIXINPAY_appId  @"wxa833091477c207c2"//十分便民超市 app
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //导航栏 文字颜色 白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    

//    self.paySuccess = @"";
    //获取易支付appId
//    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
//    NSString * EasyPayId = [infoDic valueForKey:@"EasyPayId"];
//    NSLog(@"EasyPayId==%@",EasyPayId);

    //向微信注册
    [WXApi registerApp:WEIXINPAY_appId enableMTA:NO];
    
    return YES;
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
// 注意:iOS4.2 ~ 9.0使用的 API接口
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // 2、支付跳转支付宝钱包进行支付，支付结果回调
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result0 =2= %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:EASYPAYSUCCESSNOTIFICATION object:resultDic];
            
        }];
        
        return YES;
    }
    
    //3、微信支付 支付结果回调
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

// 注意:iOS 9.0以后使用（包括iOS 9.0）这个API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSLog(@"app端url0==%@",url);
    if ([url.host isEqualToString:@"safepay"]) {
        // 4、支付跳转支付宝钱包进行支付，支付结果回调
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result0 =2= %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:EASYPAYSUCCESSNOTIFICATION object:resultDic];
            
        }];
        
        return YES;
    }
    
    //5、微信支付 支付结果回调
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

@end
