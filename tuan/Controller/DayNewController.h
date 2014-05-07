//
//  DayNewController.h
//  tuan
//
//  Created by foolish on 13-6-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Good.h"
#import "CommentListController.h"

@interface DayNewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)Good *good;
@property(nonatomic,assign)BOOL isLoading;
@property(nonatomic,assign)NSInteger lat;
@property(nonatomic,assign)NSInteger lng;
@property(nonatomic,strong)UIButton *collect;
@property(nonatomic,strong)NSData *imagedata;

@end
