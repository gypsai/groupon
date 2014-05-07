//
//  DiscountTicketViewController.m
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "MyCouponController.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import "SaleCell.h"
#import "Order.h"
#import "SSQCell.h"
#import "UIImageView+AFNetworking.h"
#import "SaleDetailViewController.h"
#import "SVProgressHUD.h"

@interface MyCouponController ()

@end

@implementation MyCouponController

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
    
    [SVProgressHUD show];
    [NetOperation getMyCouponWithUid:[GPUserManager sharedClient].user.userid key:[GPUserManager sharedClient].user.userkey isused:ALL_COUPON index:[self.data count] size:10 withblock:^(NSArray *couplist, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self loadMoreCompleted];
        if ([couplist count]==0) {
            self.canLoadMore = NO;
            self.lv.lbstatus.text = @"没有更多了";
        }
        self.data = (NSMutableArray *)[self.data arrayByAddingObjectsFromArray:couplist];
        if ([self.data count]==0) {
            self.lv.hidden = YES;
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
            lb.text = @"对不起，没有相关数据~";
            lb.center = self.view.center;
            lb.textAlignment = NSTextAlignmentCenter;
            
            [self.view addSubview:lb];
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
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
    
    
    [self loadData];
	
    
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
    return 135;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SSQCell *cell = [[SSQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx00"];
    
    Coupon *coupon = [self.data objectAtIndex:indexPath.row];
    
    cell.titlelb.text = coupon.product;
    cell.pricecount.text = [NSString stringWithFormat:@"总价:%.2f元",coupon.team_price];
    [cell.coverimg setImageWithURL:[NSURL URLWithString:coupon.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    UILabel *secret = [[UILabel alloc] initWithFrame:CGRectMake(32.0f, 105, 120.0f, 21.0f)];
    secret.font = [Util parseFont:22];
    secret.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
    secret.text=coupon.cid;
    
    UILabel *expirelb = [[UILabel alloc] initWithFrame:CGRectMake(124.0f, 105, 280.0f, 21.0f)];
    expirelb.font = [Util parseFont:22];
    expirelb.text = coupon.exp_time;
    expirelb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
    [cell.contentView addSubview:secret];
    [cell.contentView addSubview:expirelb];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Coupon *coupon = [self.data objectAtIndex:indexPath.row];
    SaleDetailViewController *sd = [[SaleDetailViewController alloc] init];
    
    sd.good = [[Good alloc] init];
    sd.good.gid = coupon.team_id;
    [self.navigationController pushViewController:sd animated:YES];
   
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"我的搜搜券";
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
