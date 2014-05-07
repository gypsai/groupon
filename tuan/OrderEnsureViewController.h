//
//  OrderEnsureViewController.h
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "AppDelegate.h"

@interface OrderEnsureViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AlipayStatus,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)Order *order;

-(void)alipaySuccess:(id)sender;
@end
