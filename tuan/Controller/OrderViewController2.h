//
//  OrderViewController2.h
//  tuan
//
//  Created by foolish on 13-4-24.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderViewController2 : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *delivery_1;
@property(nonatomic,strong)UIButton *delivery_2;
@property(nonatomic,strong)UIButton *selectDevlivery;
@property(nonatomic,strong)Order *order;
@property(nonatomic,strong)UIButton *selectedDay;
@property(nonatomic,assign)NSInteger selectDaytag;
@property(nonatomic,strong)UITextField *tfnum;
@property(nonatomic,strong)UILabel *totalpricelb;
@property(nonatomic,strong)NSMutableDictionary *param;
@property(nonatomic,strong)NSArray *expressTime;
@property(nonatomic,assign)NSInteger selexpressType;
@property(nonatomic,strong)UITextField *textv;
@property(nonatomic,assign)NSInteger buynum;

@end
