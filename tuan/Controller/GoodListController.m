//
//  GoodListController.m
//  tuan
//
//  Created by foolish on 13-4-15.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "GoodListController.h"
#import "SaleCell.h"
#import "SaleDetailViewController.h"
#import "NetOperation.h"

@interface GoodListController ()

@end

@implementation GoodListController
@synthesize delegate=_delegate;
@synthesize param=_param;
@synthesize data=_data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)reloadData
{
    self.data = nil;
    self.data = [[NSMutableArray alloc] init];
    [self loadData];
    
}

-(void)loadData
{
    
    
    self.lv.lbstatus.text = @"正在加载......";
    [self.lv.activityV startAnimating];
    
    [self.param setObject:[NSString stringWithFormat:@"%d",[self.data count]] forKey:@"index"];
    [self.param setObject:@"10" forKey:@"size"];
    
    [NetOperation getGoodListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
        NSLog(@"params|| index:%@,size:%@,title:%@,ordertype:%@,groupid:%@,cityid:%@",[self.param objectForKey:@"index"],[self.param objectForKey:@"size"],[self.param objectForKey:@"title"],[self.param objectForKey:@"orderType"],[self.param objectForKey:@"groupId"],[self.param objectForKey:@"cityId"]);
        NSLog(@"count:%d",[orderlist count]);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self loadMoreCompleted];
        if ([orderlist count]==0) {
            self.canLoadMore = NO;
            self.lv.lbstatus.text = @"没有更多了";
        }
        self.data = (NSMutableArray *)[self.data arrayByAddingObjectsFromArray:orderlist];
        if ([self.data count]==0) {
            self.lv.hidden = YES;
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
            lb.text = @"没找到商品~";
            lb.center = self.view.center;
            lb.textAlignment = NSTextAlignmentCenter;
            
            [self.view addSubview:lb];
        }
        [self.tableView reloadData];
    }];
    

}

#pragma stable

- (void) willBeginLoadingMore
{
    
    self.lv.lbstatus.text=@"释放开始加载......";
    self.lv.lbstatus.hidden = NO;
    
    
    
}

- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    self.lv.lbstatus.text = @"上拉加载更多......";
    [self.lv.activityV stopAnimating];
    
    if (!self.canLoadMore) {
        
    }
    
}

- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    self.lv.lbstatus.text = @"正在加载......";
    [self.lv.activityV startAnimating];
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:0.0];
    // DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    // fv.infoLabel.text = @"正在加载";
    // fv.infoLabel.hidden = NO;
    
    return YES;
}

-(void)dropLoadMore
{
    self.lv.lbstatus.text = @"上拉加载更多......";
    
}

- (void) addItemsOnBottom
{
    
    [self loadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pullToRefreshEnabled = NO;
    self.data = [[NSMutableArray alloc] init];
   // self.param = [[NSMutableDictionary alloc] init];
    
    self.lv= [[LoadStatusView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    self.lv.backgroundColor = [UIColor whiteColor];
    
    self.footerView = self.lv;
    
    
    [self loadData];
	// Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.data count];
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SaleCell *cell = [[SaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx00"];
    Good *good = [self.data objectAtIndex:indexPath.row];
    
    cell.titlelb.text = good.title;
    cell.truepricelb.text = [NSString stringWithFormat:@"%.1f",good.market_price];
    cell.discountlb.text = [NSString stringWithFormat:@"%.1f",good.team_price];
    cell.countlb.text = [NSString stringWithFormat:@"%d",good.per_number];
    cell.coverimg.image = [UIImage imageNamed:@"placeholder1"];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate didSelectGood:[self.data objectAtIndex:indexPath.row]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
