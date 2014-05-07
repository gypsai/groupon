//
//  StoreViewController.m
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "CollectViewController.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import "Good.h"
#import "UIImageView+AFNetworking.h"

@interface CollectViewController ()

@end

@implementation CollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadData
{
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.lv.lbstatus.text = @"正在加载......";
    [self.lv.activityV startAnimating];
    
    [NetOperation getMyCollectWithUid:[GPUserManager sharedClient].user.userid key:[GPUserManager sharedClient].user.userkey offset:[self.data count] size:10 withblock:^(NSArray *rest, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self loadMoreCompleted];
        if ([rest count]==0) {
            self.canLoadMore = NO;
            self.lv.lbstatus.text = @"没有更多了";
        }
        [self.data addObjectsFromArray:rest];
        if ([self.data count]==0) {
            self.lv.hidden = YES;
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
            lb.text = @"您还没有收藏商品哦~";
            lb.center = self.view.center;
            lb.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:lb];
        }
        [self.tableView reloadData];
      //  NSLog(@"orderlist count:%d",[rest count]);
        
    }];
    
   
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [[NSMutableArray alloc] init];
    
    self.pullToRefreshEnabled = NO;
    self.data = [[NSMutableArray alloc] init];
    
    self.lv= [[LoadStatusView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    self.lv.backgroundColor = [UIColor whiteColor];
    
    self.footerView = self.lv;
    
 	
    
    // Do any additional setup after loading the view.
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
    self.lv.lbstatus.text = @"正在加载";
    [self.lv.activityV startAnimating];
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:0.0];
    
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
    
    cell.titlelb.text = good.partnerTitle;
    cell.discriplb.text = good.product;
    cell.truepricelb.text = [NSString stringWithFormat:@"%.2f", good.team_price];
    cell.discountlb.text = [NSString stringWithFormat:@"%.2f", good.market_price];
    cell.countlb.text = good.buy_number_str;
    
    UIButton *removebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [removebtn setFrame:CGRectMake(260.0f, 10.0f, 20.0f, 20.0f)];
    [removebtn addTarget:self action:@selector(decollectAction:) forControlEvents:UIControlEventTouchUpInside];
    [removebtn setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
    removebtn.tag = indexPath.row;
    [cell addSubview:removebtn];
    
    [cell.coverimg setImageWithURL:[NSURL URLWithString:good.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)decollectAction:(UIButton *)sender
{
    Good *good = [self.data objectAtIndex:sender.tag];
    [NetOperation decollectWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey teamid:[NSString stringWithFormat:@"%d",good.team_id] withblock:^(BOOL success, NSError *error) {
        if (success) {
        
            [self.data removeObjectAtIndex:sender.tag];
            [self.tableView reloadData];
        }
    }];

    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SaleDetailViewController *salev = [[SaleDetailViewController alloc] init];
    salev.hidesBottomBarWhenPushed = YES;
    salev.good = [self.data objectAtIndex:indexPath.row];
    salev.good.gid = salev.good.team_id;
    [self.navigationController pushViewController:salev animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    self.data = nil;
    self.data=[[NSMutableArray alloc] init];
    [self loadData];

    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"我的收藏";
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titlelb;
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *bk = [UIButton buttonWithType:UIButtonTypeCustom];
    bk.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [bk setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [bk addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:bk];
    self.navigationItem.leftBarButtonItem = mp;
    
}

-(void)goMap:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
