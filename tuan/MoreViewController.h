//
//  MoreViewController.h
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UILabel *lbnotitime;
@end
