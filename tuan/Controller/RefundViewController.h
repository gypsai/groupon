//
//  RefundViewController.h
//  tuan
//
//  Created by foolish on 13-4-20.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface RefundViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *selectReason;
@property(nonatomic,strong)Order *order;

@end
