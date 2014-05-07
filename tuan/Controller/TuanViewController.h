//
//  TuanViewController.h
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSelectView.h"
#import "SearchViewController.h"
#import "MapViewController.h"
#import "GoodListController.h"
#import "HTableViewController.h"
#import "LoadStatusView.h"
#import "XLCycleScrollView.h"
#import "AppDelegate.h"
#import "NotifyDelegate.h"


@interface TuanViewController : HTableViewController<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,NotifyDelegate>

@property(nonatomic,strong)UISegmentedControl *seg;
@property(nonatomic,strong)GoodListController *listv;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,retain)NSMutableDictionary *param;
@property(nonatomic,strong)LoadStatusView *lv;
@property(nonatomic,strong)LoadStatusView *hv;
@property(nonatomic,assign)BOOL isLoading;
@property(nonatomic,strong)NSArray *adds;
@property(nonatomic,strong)XLCycleScrollView *csView;
@property(nonatomic,strong)UILabel *nonlb;

@end
