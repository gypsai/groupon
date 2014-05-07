//
//  DiscountTicketViewController.h
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STableViewController.h"
#import "LoadStatusView.h"
@interface MyCouponController : STableViewController

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)LoadStatusView *lv;

@end
