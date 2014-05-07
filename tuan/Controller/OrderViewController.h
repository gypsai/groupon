//
//  OrderViewController.h
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface OrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) Order *order;
@property(nonatomic,strong)UITextField *tfnum;
@property(nonatomic,strong)UILabel *totalpricelb;
@property(nonatomic,strong)NSMutableDictionary *param;
@property(nonatomic,strong)UITextField *textv;
@property(nonatomic,assign)NSInteger buynum;
@end
