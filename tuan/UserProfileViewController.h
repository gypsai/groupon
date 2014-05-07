//
//  UserProfileViewController.h
//  tuan
//
//  Created by foolish on 13-4-4.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineCell.h"
#import "ChangeNickController.h"

@interface UserProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ChangeNickDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UILabel *usernick;
@property(nonatomic,strong)UILabel *usermoney;
@property(nonatomic,strong)UIImageView *usericon;

@end
