//
//  CouponStatusController.h
//  tuan
//
//  Created by foolish on 13-5-14.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadStatusView.h"
#import "STableViewController.h"

@interface CouponStatusController : STableViewController

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)LoadStatusView *lv;
@property(nonatomic,assign)NSInteger flag;

@end
