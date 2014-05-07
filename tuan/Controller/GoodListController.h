//
//  GoodListController.h
//  tuan
//
//  Created by foolish on 13-4-15.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "STableViewController.h"
#import "LoadStatusView.h"
#import "Good.h"

@protocol GoodListDelegate <NSObject>

-(void)didSelectGood:(Good *)good;

@end

@interface GoodListController : STableViewController

@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,retain)NSMutableDictionary *param;
@property(nonatomic,strong)LoadStatusView *lv;
@property(nonatomic,assign)id<GoodListDelegate>delegate;

-(void)reloadData;


@end
