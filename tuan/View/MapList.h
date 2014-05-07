//
//  MapList.h
//  tuan
//
//  Created by foolish on 13-7-5.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Good.h"
@interface MapList : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)UINavigationController *nav;

@end
