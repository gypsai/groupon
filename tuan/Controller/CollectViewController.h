//
//  StoreViewController.h
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaleCell.h"
#import "SaleDetailViewController.h"
#import "STableViewController.h"
#import "LoadStatusView.h"

@interface CollectViewController : STableViewController

@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)LoadStatusView *lv;

@end
