//
//  AppDelegate.h
//  tuan
//
//  Created by foolish on 13-3-31.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreViewController.h"
#import "MineViewController.h"
#import "NearbyViewController.h"
#import "TuanViewController.h"
#import "BMKMapManager.h"
#import "NetOperation.h"
#import "LocalDB.h"
#import "UserOperation.h"
#import "NotifyDelegate.h"

@protocol AlipayStatus <NSObject>
-(void)paySuccess;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKMapViewDelegate>

{
    
    BMKMapManager *_mapManager;
    
}

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) UITabBarController *tab;
@property(nonatomic,strong) UINavigationController *navController;
@property(nonatomic,strong)NSMutableDictionary *cat;
@property(nonatomic,assign)id<AlipayStatus>paydelegate;
@property(nonatomic,assign)id<NotifyDelegate> notifydelegate;
@property(nonatomic,strong)BMKMapView *mapView;

@end
