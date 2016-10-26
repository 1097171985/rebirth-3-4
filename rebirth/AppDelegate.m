//
//  AppDelegate.m
//  rebirth
//
//  Created by 侯帅 on 16/7/11.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HomeVC.h"
#import "NewsVC.h"
#import "MyVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "LXNavigationController.h"
#import "UPPaymentControl.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "DownPayVC.h"
#import "DPAppIntroPanel.h"
#import "DPLaunchAnimationPanel.h"

const static NSString *APIKey = @"c822e9e86d82c9da13e1b37a00dfa8da";
//const static NSString *APIKey = @"4b6a5e514ecf283974badf8aed81b0d7";
@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate>

@end

@implementation AppDelegate

- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。???????"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [WXApi registerApp:@"wxe6c3d607aa9713bd"];
    [Common initGlobalValue];
    [self getNetWorkStates];
    [self configureAPIKey];
    
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];

     // [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
//    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:[[VC1 alloc] init]];
    
    RDVTabBarController  *tabBarController = [[RDVTabBarController alloc]init];
    
    tabBarController.viewControllers  = @[navigationController1];
    
//    LXNavigationController *leftnavigationController = [[LXNavigationController alloc] initWithRootViewController:[[MyVC alloc] init]];
//    
//    LXNavigationController *rightnavigationController = [[LXNavigationController alloc] initWithRootViewController:[[NewsVC alloc] init]];
    //    MyVC *leftMenuViewController = [[MyVC alloc] init];
    //    NewsVC *rightMenuViewController = [[NewsVC alloc] init];
    
//    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:tabBarController
//                                                                    leftMenuViewController:leftnavigationController
//                                                                   rightMenuViewController:rightnavigationController];
//    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
//    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
//    sideMenuViewController.delegate = self;
//    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
//    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
//    sideMenuViewController.contentViewShadowOpacity = 0.6;
//    sideMenuViewController.contentViewShadowRadius = 12;
//    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:@"0" forKey:@"number"];
    
    [user setObject:@"" forKey:@"午餐"];
    
    [user setObject:@"" forKey:@"下午茶"];
    
    [user setObject:@"" forKey:@"晚餐"];
    
    [user setObject:@"" forKey:@"car"];
    
    [user setObject:@"" forKey:@"hotel"];
    
    [user setObject:@"" forKey:@"foodDict"];
    
    [user setObject:@"" forKey:@"lunerDict"];
    [user setObject:@"" forKey:@"coffeDict"];
    [user setObject:@"" forKey:@"dinnerDict"];
    [user removeObjectForKey:@"foodArray"];
    
    [user setObject:@"" forKey:@"carNeirong"];
    
    [user setObject:@"" forKey:@"hotelNeirong"];
    
    [user removeObjectForKey:@"startTime"];
    
    [user removeObjectForKey:@"Rili"];

    
    //显示引导页
    //显示启动动画
    [DPLaunchAnimationPanel displayWithCompleteBlock:^{
        //显示引导页
        [DPAppIntroPanel displayIfNeeded];
        
    }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark-Methods
-(void)setuiViewControllers{
    UIViewController *homeViewController = [[HomeViewController alloc] init];
    UIViewController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
//    UIViewController *communityViewController = [[CommunityViewController alloc] init];
//    UIViewController *communityNavigationController = [[UINavigationController alloc] initWithRootViewController:communityViewController];
//    UIViewController *walletViewController = [[WalletViewController alloc] init];
//    UIViewController *walletNavigationController = [[UINavigationController alloc] initWithRootViewController:walletViewController];
//    UIViewController *myViewController = [[MyViewController alloc] init];
//    UIViewController *myNavigationController = [[UINavigationController alloc] initWithRootViewController:myViewController];
    RDVTabBarController *hsTabBarController = [[RDVTabBarController alloc] init];
//    [hsTabBarController setViewControllers:@[homeNavigationController,communityNavigationController,walletNavigationController,myNavigationController]];
   [hsTabBarController setViewControllers:@[homeNavigationController]];
    self.controller = hsTabBarController;
    [self customizeTabBarForController:hsTabBarController];
    
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController{
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third",@"four"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        if (index == 4) {
            return;
            
        }
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
    
}
- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}
-(void)onResp:(BaseResp *)resp{
    NSLog(@"resp======%d",resp.errCode);
    NSString *strTitle;
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if ([resp isKindOfClass:[PayResp class]]) {
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode){
        case WXSuccess:
            {
                NSLog(@"支付结果: 成功!");
                DownPayVC *down = [[DownPayVC alloc] init];
                [self.window.rootViewController.navigationController pushViewController:down animated:YES];
                //                PaymentFinishController *pfc = [PaymentFinishController new];
                //                [self.window.rootViewController.navigationController pushViewController:pfc animated:YES];
            }
            break;
        case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                
                NSLog(@"支付结果: 失败!");
            }
            break;
        case WXErrCodeUserCancel:
            { //用户点击取消并返回
                NSLog(@"111111");
            }
            break;
        case WXErrCodeSentFail:
            { //发送失败
                NSLog(@"发送失败");
            }
            break;
        case WXErrCodeUnsupport:
            { //微信不支持
                NSLog(@"微信不支持");
            }
            break;
        case WXErrCodeAuthDeny:
            { //授权失败
                NSLog(@"授权失败");
            }
            break;
        default:
            break;
        }
    }
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService]processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"AppDelegateResult = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                //支付成功
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"支付成功" object:self userInfo:nil];
                
                
            }
            // else if([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"6001"]){
            //                //支付取消
            //
            //                NSLog(@"支付取消");
            //                [[NSNotificationCenter defaultCenter]postNotificationName:@"支付取消" object:self userInfo:nil];
            //            }
            else{
                //支付失败
                NSLog(@"支付失败");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"支付失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }else{
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            
            //结果code为成功时，先校验签名，校验成功后做后续处理
            if([code isEqualToString:@"success"]) {
                [Common tipAlert:@"支付成功"];
                //数据从NSDictionary转换为NSString
               
              
                
                
                //验签证书同后台验签证书
                //此处的verify，商户需送去商户后台做验签
                           }
            else if([code isEqualToString:@"fail"]) {
                [Common tipAlert:@"交易失败"];
                //交易失败
            }
            else if([code isEqualToString:@"cancel"]) {
                //交易取消
            }
        }];

    }
    
    return YES;
    
}

-(void)VersionButton{
    //获取发布版本的Version
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id="] encoding:NSUTF8StringEncoding error:nil];
    if (string!=nil&&[string length]>0&&[string rangeOfString:@"version"].length==7) {
        [self checkAppUpdate:string];
    }
}
#pragma mark----比较当前版本与新上线版本做比较
-(void)checkAppUpdate:(NSString *)appInfo{
    //获取当前版本
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *appInfo1 = [appInfo substringFromIndex:[appInfo rangeOfString:@"\"version\":"].location+10];
    appInfo1 = [[appInfo1 substringToIndex:[appInfo1 rangeOfString:@","].location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    /**
    *判断，如果当前版本与发布的版本不相同，则进入更新，如果相等，那么当前就是最高版本
     */
    if (![appInfo1 isEqualToString:version]) {
        NSLog(@"新版本:%@,当前版本%@",appInfo1,version);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString  stringWithFormat:@"新版本 %@ 已发布!",appInfo1] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        alert.delegate =self;
        [alert addButtonWithTitle:@"前往更新"];
        [alert show];
        alert.tag = 20;
    }
    
}
//-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex==1&alertView.tag ==20) {
//        NSString *url = @"https://itunes.apple.com/cn/app"
//    }
//}
//判断app是否为WiFi
- (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state =  @"2G";
                    break;
                case 2:
                    state =  @"3G";
                    break;
                case 3:
                    state =   @"4G";
                    break;
                case 5:
                {
                    state =  @"wifi";
                    break;
                default:
                    break;
                }
            }
        }
    }
        //根据状态选择
        return state;
    }

@end
