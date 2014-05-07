//
//  SearchViewController.h
//  tuan
//
//  Created by foolish on 13-4-4.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"
#import "GCell.h"
#import "STableViewController.h"
#import "LoadStatusView.h"

@interface SearchViewController : STableViewController<UISearchBarDelegate>

@property(nonatomic,strong)UIGridView *gridView;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)LoadStatusView *lv;
@property(nonatomic,strong)NSMutableDictionary *param;
@property(nonatomic,assign)BOOL isLoading;
@property(nonatomic,strong)UIView *tagv;
@property(nonatomic,strong)UILabel *nonlb;

@end
