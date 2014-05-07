//
//  OrderListViewController.h
//  tuan
//
//  Created by foolish on 13-4-18.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "STableViewController.h"
#import "LoadStatusView.h"

@interface OrderListViewController : STableViewController

@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)LoadStatusView *lv;
@property(nonatomic,assign)NSInteger flag;

@end
