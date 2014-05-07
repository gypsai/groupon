//
//  CouponListController.h
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadStatusView.h"
#import "STableViewController.h"


@interface CouponListController :STableViewController

@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)LoadStatusView *lv;
@property(nonatomic,assign)NSInteger flag;
@end
