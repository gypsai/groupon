//
//  MineViewController.h
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "MyCouponController.h"
#import "CollectViewController.h"
#import "PhoneBindViewController.h"

@interface MineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,LoginViewDelegate,bindDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *btnlogin;
@property(nonatomic,strong)UILabel *usernick;
@property(nonatomic,strong)UILabel *usermoney;
@property(nonatomic,strong)UIImageView *usericon;
@property(nonatomic,strong)UIImageView *moneyicon;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UIButton *btngoprofile;
@property(nonatomic,strong)UILabel *notice;
@property(nonatomic,assign)NSInteger collectNum;
@property(nonatomic,strong)UILabel *lbcollectnum;

@property(nonatomic,strong)UILabel *lb_unconsume;
@property(nonatomic,strong)UILabel *lb_consume;
@property(nonatomic,strong)UILabel *lb_unpayed;
@property(nonatomic,strong)UILabel *lb_payed;


@end
