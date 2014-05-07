//
//  NearbyViewController.h
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaleCell.h"
#import "BMapKit.h"
#import "HTableViewController.h"
#import "LoadStatusView.h"

@interface NearbyViewController : HTableViewController<BMKMapViewDelegate>

@property(nonatomic,strong)BMKMapView *mapview;
@property(nonatomic,assign)NSInteger lat;
@property(nonatomic,assign)NSInteger lng;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)LoadStatusView *lv;
@property(nonatomic,strong)LoadStatusView *hv;
@property(nonatomic,assign)BOOL isLoading;
@property(nonatomic,strong)NSMutableDictionary *param;
@property(nonatomic,strong)UILabel *nonlb;
@end
