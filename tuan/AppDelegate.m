//
//  AppDelegate.m
//  tuan
//
//  Created by foolish on 13-3-31.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "AppDelegate.h"
#import "Test.h"
#import "Category.h"
#import "GPUserManager.h"
#import "AlixPay.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import <sys/utsname.h>
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "DayNewController.h"
#import "Util.h"

@implementation AppDelegate
@synthesize cat=_cat;
@synthesize paydelegate=_paydelegate;
@synthesize notifydelegate=_notifydelegate;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   // [Test test];
    
    [self notify];
    
    
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in notifications ) {
//       if( [[notification.userInfo objectForKey:@"source"] isEqualToString:@"dailyReminder"] ) {
//            [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            break;
//      }
        
        NSLog(@"notis %@",notification.userInfo);
    }
    

    
    
    [self reqCat];
    [self userOption];
    [ShareSDK registerApp:@"520520test"];
    [self initializePlat];
   [ShareSDK connectWeChatWithAppId:@"wx6dd7a9b94f3dd72a"
                           wechatCls:[WXApi class]];
    
    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
	BOOL ret = [_mapManager start:@"D1bc794e2ed18487483bee68ec6a547a" generalDelegate:nil];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    self.mapView = [[BMKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D loc = {35.01144,110.996075};
    [GPUserManager sharedClient].l = loc;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self setTab];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.tab];
    
    self.navController.navigationBar.hidden = YES;
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    NSLog(@"Icon num is:%d",application.applicationIconBadgeNumber);
    if((application.applicationIconBadgeNumber) > 0)
    {
        application.applicationIconBadgeNumber=0;
        DayNewController *dc = [[DayNewController alloc] init];
        [self.navController pushViewController:dc animated:YES];
        
    }
    
    return YES;
}

-(void)notify
{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *setNoti = [defaults objectForKey:@"setNoti"];  //是否设置了配置文件
    NSString *isNoti;
    NSString *notiTime;
   // NSString *isSendNoti;
  
    //在已经设置了本配置文件的情况下
    if ([setNoti isEqualToString:@"YES"]) {
        
//        isNoti = [defaults objectForKey:@"isNoti"];
//        if ([isNoti isEqualToString:@"YES"]) {
//            UIApplication *app = [UIApplication sharedApplication];
//            [app cancelAllLocalNotifications];
//            
//            
//        }
//        notiTime = [defaults objectForKey:@"NotiTime"];
        
    }else
    //第一次创建此配置文件
    {
        [defaults setObject:@"YES" forKey:@"isNoti"];
        [defaults setObject:@"YES" forKey:@"setNoti"];
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"M/d/yyy"];
        NSDate *date = [NSDate date];
        NSString *datestr = [formatter stringFromDate:date];
        datestr = [datestr stringByAppendingFormat:@"%@",@" 09:00"];
        
        NSLog(@"date str is:%@",datestr);
        notiTime = datestr;
        [self sendNoti:notiTime];
        [defaults setObject:datestr forKey:@"NotiTime"];
        [defaults setObject:@"YES" forKey:@"isSend"];
        [defaults synchronize];
    }
    
    NSLog(@"real time is:%@",[defaults objectForKey:@"NotiTime"]);
    
    
}

-(void)sendNoti:(NSString *)notiTime
{

    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // 设置notification的属性
    localNotification.fireDate = [Util parseFromString:notiTime]; //出发时间
    
    NSLog(@"send time is:%@",notiTime);
    
    localNotification.alertBody = @"运城搜搜每日新单"; // 消息内容
    localNotification.repeatInterval = NSDayCalendarUnit; // 重复的时间间隔,每天
    localNotification.soundName = UILocalNotificationDefaultSoundName; // 触发消息时播放的声音
    localNotification.applicationIconBadgeNumber = 1; //应用程序Badge数目
    
    // 设置随Notification传递的参数
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"key", @"abcdefg", @"phone", @"hahah", nil];
    localNotification.userInfo = infoDict;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification]; //注册
    
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ( application.applicationIconBadgeNumber>0) {
        application.applicationIconBadgeNumber=0;
        DayNewController *dc = [[DayNewController alloc] init];
        [self.navController pushViewController:dc animated:YES];
        
    }

}


- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    self.mapView.showsUserLocation =  NO;
    [GPUserManager sharedClient].l = userLocation.coordinate;
    
    NSLog(@"the pos is:%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
	
}

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	 CLLocationCoordinate2D loc = {35.01144,110.996075};
    [GPUserManager sharedClient].l = loc;

}



-(void)userOption
{
    [LocalDB loadUser];
    
    [NetOperation getMyAccountWithUid:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey withblock:^(User *user, NSError *error) {
        if (!error) {
            User *tempus = [[User alloc] init];
            tempus = user;
            tempus.userkey = [GPUserManager sharedClient].user.userkey;
            tempus.userid = [GPUserManager sharedClient].user.userid;
            [GPUserManager sharedClient].user = tempus;
            [LocalDB storeUserInfo:tempus];
        }else
        {
            [[GPUserManager sharedClient] logOut];
        }
    }];

}

-(void)reqCat
{
    self.cat = [[NSMutableDictionary alloc] init];
    [NetOperation getRegion:^(NSArray *reg, NSError *error) {
        
        if (!error) {
            [self.cat setObject:reg forKey:@"region"];
                    }
        
    }];
    
    [NetOperation getAllCatgoryWithCityID:@"0" withblock:^(NSArray *cat, NSError *error) {
        
        if (!error) {
            /*
            for (Category *xcat in cat) {
                
                NSLog(@"{(%@)(",xcat.name);
                if (xcat.hasChild) {
                    for (Category *ccat in xcat.childCategoryList) {
                        
                        NSLog(@"%@",ccat.name);
                    }
                }
                NSLog(@")}");
            }
            */
            [self.cat setObject:cat forKey:@"category"];
        }
    }];

}

-(void)setTab
{

    TuanViewController *view1 = [[TuanViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:view1];
    
    NearbyViewController *view2 = [[NearbyViewController alloc] init];
     UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:view2];
    
    MineViewController *view3 = [[MineViewController alloc] init];
     UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:view3];
    
    MoreViewController *view4 = [[MoreViewController alloc] init];
     UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:view4];
    
    self.tab = [[UITabBarController alloc] init];
    self.tab.viewControllers = @[nav1,nav2,nav3,nav4];
    
    
    //添加tab的icon
    [nav1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_1_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_1_un"]];
    [nav2.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_2_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_2_un"]];
    [nav3.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_3_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_3_un"]];
    [nav4.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_4_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_4_un"]];
    
    [self.tab.tabBar setBackgroundImage:[UIImage imageNamed:@"tab"]];

}

- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
	if (result) {
		//是否支付成功
		if (9000 == result.statusCode) {
			/*
			 *用公钥验证签名
			 */
			id<DataVerifier> verifier = CreateRSADataVerifier([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA public key"]);
			if ([verifier verifyString:result.resultString withSign:result.signString]) {
                
                [_paydelegate paySuccess];
                
               
//				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//																	 message:@"恭喜您，支付成功！"
//																	delegate:nil
//														   cancelButtonTitle:@"确定"
//														   otherButtonTitles:nil];
//				[alertView show];
			}//验签错误
			else {
				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																	 message:@"签名错误"
																	delegate:nil
														   cancelButtonTitle:@"确定"
														   otherButtonTitles:nil];
				[alertView show];
			}
		}
		//如果支付失败,可以通过result.statusCode查询错误码
		else {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																 message:result.statusMessage
																delegate:nil
													   cancelButtonTitle:@"确定"
													   otherButtonTitles:nil];
			[alertView show];
		}
		
	}
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    if ([sourceApplication isEqualToString:@"com.alipay.safepayclient"]) {
//        return [ShareSDK handleOpenURL:url
//                     sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
//        
//    }else if([sourceApplication isEqualToString:@"com.sina.weibo"])
//    {
//        return [ShareSDK handleOpenURL:url
//                            wxDelegate:self];
//    }
//    else
//    {
//       
//    }
   // [self parseURL:url application:application];
    NSLog(@"application url is:%@,%@",sourceApplication,url);
    
    NSString *openurlis = [NSString stringWithFormat:@"%@",sourceApplication];
    if ([openurlis isEqualToString:@"com.alipay.safepayclient"]) {
        [self parseURL:url application:application];
    }
    else
    {
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    }
 
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    if ( application.applicationIconBadgeNumber>0) {
        application.applicationIconBadgeNumber=0;
        DayNewController *dc = [[DayNewController alloc] init];
        [self.navController pushViewController:dc animated:YES];
        
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initializePlat {
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"3201194191"
                               appSecret:@"0334252914651e8f76bad63337b3b78f" redirectUri:@"http://appgo.cn"];
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c" redirectUri:@"http://www.sharesdk.cn"];
    //添加QQ空间应用
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"];
    //添加网易微博应用
    [ShareSDK connect163WeiboWithAppKey:@"T5EI7BXe13vfyDuy"
                              appSecret:@"gZxwyNOvjFYpxwwlnuizHRRtBRZ2lV1j" redirectUri:@"http://www.shareSDK.cn"];
    //添加开心网应用
    [ShareSDK connectKaiXinWithAppKey:@"358443394194887cee81ff5890870c7c"
                            appSecret:@"da32179d859c016169f66d90b6db2a23"
                          redirectUri:@"http://www.sharesdk.cn/"]; //添加Instapaper应用
    [ShareSDK connectInstapaperWithAppKey:@"4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc 61FA"
                                appSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"]; //添加有道云笔记应用
    [ShareSDK connectYouDaoNoteWithConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
                                consumerSecret:@"d98217b4020e7f1874263795f44838fe"
                                   redirectUri:@"http://www.sharesdk.cn/"]; //添加Facebook应用
    [ShareSDK connectFacebookWithAppKey:@"107704292745179" appSecret:@"38053202e1a5fe26c80c753071f0b573"];
    //添加Twitter应用
    [ShareSDK connectTwitterWithConsumerKey:@"mnTGqtXk0TYMXYTN7qUxg"
                             consumerSecret:@"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc" redirectUri:@"http://www.sharesdk.cn"];
}

@end
