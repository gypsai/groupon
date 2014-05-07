//
//  OrderListViewController.m
//  tuan
//
//  Created by foolish on 13-4-18.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "OrderListViewController.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import "SaleCell.h"
#import "PayedCell.h"
#import "UnpayCell.h"
#import "RTCell.h"
#import "RefundViewController.h"
#import "UIImageView+AFNetworking.h"
#import "NetOperation.h"
#import "Coupon.h"
#import "OrderEnsureViewController.h"
#import "SVProgressHUD.h"
#import "SaleDetailViewController.h"

@interface OrderListViewController ()

@end

@implementation OrderListViewController

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
    
    [NetOperation getUserOrderWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey type:self.flag offset:[self.data count] size:10 withblock:^(NSArray *orders, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self loadMoreCompleted];
        if ([orders count]==0) {
            self.canLoadMore = NO;
            self.lv.lbstatus.text = @"没有更多了";
        }
        [self.data addObjectsFromArray:orders];
        if ([self.data count]==0) {
            self.lv.hidden = YES;
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
            lb.text = @"没有相关数据~";
            lb.center = self.view.center;
            lb.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:lb];
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        //  NSLog(@"orderlist count:%d",[rest count]);
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pullToRefreshEnabled = NO;
    self.lv= [[LoadStatusView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    self.lv.backgroundColor = [UIColor whiteColor];
    
    self.footerView = self.lv;
    self.data = [[NSMutableArray alloc] init];
    
    [SVProgressHUD show];
   
	
    
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
//    if ([self.data count]==0) {
//        return 10;
//    }
  return [self.data count];
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Order *order = [self.data objectAtIndex:indexPath.row];
    
    if (self.flag==PAYED) {
        NSInteger cont = [order.couponlist count];
        return 120+cont*21;
    }
    if (self.flag==UNPAY) {
        return 140.0f;
    }
    if (self.flag == RETURN) {
        NSInteger cont = [order.couponlist count];
        return 170.0f+cont*21;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.flag == PAYED) {
        PayedCell *pcell = [[PayedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx00"];
        Order *order = [self.data objectAtIndex:indexPath.row];
        pcell.titlelb.text = order.product;
        pcell.pricecount.text = [NSString stringWithFormat:@"总价:%.2f元",order.origin];
        pcell.countlb.text = [NSString stringWithFormat:@"总数:%d个",order.totalnumb];
       [pcell.coverimg setImageWithURL:[NSURL URLWithString:order.good.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        pcell.btnreturn.tag = indexPath.row;
        
        if ([order.couponlist count]>0) {
            for (NSInteger i=0;i<[order.couponlist count];i++) {
                Coupon *coupon = [order.couponlist objectAtIndex:i];
                
                UILabel *secret = [[UILabel alloc] initWithFrame:CGRectMake(32.0f, 105.0f+i*21, 56.0f, 21.0f)];
                secret.font = [Util parseFont:22];
                secret.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
                secret.text=coupon.secret;
                
                 UILabel *expirelb = [[UILabel alloc] initWithFrame:CGRectMake(124.0f, 105+i*21.0f, 280.0f, 21.0f)];
                expirelb.font = [Util parseFont:22];
                expirelb.text = coupon.exp_time;
                expirelb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
                [pcell.contentView addSubview:secret];
                [pcell.contentView addSubview:expirelb];
            }
        }
        
        if (order.canfund) {
          [pcell.btnreturn addTarget:self action:@selector(goReturnMoney:) forControlEvents:UIControlEventTouchUpInside];   
        }else
        {
          [pcell.btnreturn setTitle:@"该订单不允许退款" forState:UIControlStateNormal];
        }
       
        [pcell.btndetail addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        pcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return pcell;
    }
    
    if (self.flag== UNPAY) {
        UnpayCell *upc = [[UnpayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"unpay"];
        Order *order = [self.data objectAtIndex:indexPath.row];
        upc.titlelb.text = order.product;
        upc.pricecount.text = [NSString stringWithFormat:@"总价:%.2f元",order.origin];
        upc.countlb.text = [NSString stringWithFormat:@"总数:%d个",order.totalnumb];
        [upc.coverimg setImageWithURL:[NSURL URLWithString:order.good.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [upc.paybtn addTarget:self action:@selector(goPay:) forControlEvents:UIControlEventTouchUpInside];
        upc.paybtn.tag = indexPath.row;
        
        [upc.removebtn addTarget:self action:@selector(removeActoin:) forControlEvents:UIControlEventTouchUpInside];
        upc.removebtn.tag = indexPath.row;
        
        upc.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return upc;
    }
    
    if (self.flag == RETURN) {
        
        RTCell *rcell = [[RTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx00"];
        Order *order = [self.data objectAtIndex:indexPath.row];
        
        rcell.titlelb.text = order.product;
        rcell.pricecount.text = [NSString stringWithFormat:@"总价:%.2f元",order.origin];
        rcell.countlb.text = [NSString stringWithFormat:@"总数:%d个",order.totalnumb];
        
        
        if ([order.couponlist count]>0) {
            for (NSInteger i=0;i<[order.couponlist count];i++) {
                Coupon *coupon = [order.couponlist objectAtIndex:i];
                
                UILabel *secret = [[UILabel alloc] initWithFrame:CGRectMake(32.0f, 105.0f+i*21, 56.0f, 21.0f)];
                secret.font = [Util parseFont:22];
                secret.textColor = [UIColor colorWithRed:191.0f/255 green:191.0f/255 blue:191.0f/255 alpha:1.0f];
                secret.text=coupon.secret;
                
                UILabel *expirelb = [[UILabel alloc] initWithFrame:CGRectMake(124.0f, 105+i*21.0f, 280.0f, 21.0f)];
                expirelb.font = [Util parseFont:22];
                expirelb.text = coupon.exp_time;
                expirelb.textColor = [UIColor colorWithRed:191.0f/255 green:191.0f/255 blue:191.0f/255 alpha:1.0f];
                [rcell.contentView addSubview:secret];
                [rcell.contentView addSubview:expirelb];
            }
        }

        rcell.btnreturn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rcell.btnreturn addTarget:self action:@selector(goReturnMoney:) forControlEvents:UIControlEventTouchUpInside];
        rcell.btnreturn.frame = CGRectMake(16.0f, 131.0f+(21*[order.couponlist count]), 286.0f, 35.0f);
        rcell.btnreturn.tag = indexPath.row;
        
        if (order.canfund) {
            
            [rcell.btnreturn setTitle:@"申请退款" forState:UIControlStateNormal];
            
            [rcell.btnreturn setBackgroundImage:[UIImage imageNamed:@"pay_btn"] forState:UIControlStateNormal];
            rcell.btnreturn.enabled = YES;
       
        }else
        {
            [rcell.btnreturn setTitle:order.rstate forState:UIControlStateNormal];
            [rcell.btnreturn setBackgroundImage:[UIImage imageNamed:@"btn_refunding"] forState:UIControlStateNormal];
            rcell.btnreturn.enabled = NO;
        }
        
        
        [rcell.coverimg setImageWithURL:[NSURL URLWithString:order.good.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [rcell addSubview:rcell.btnreturn];
        
       
        rcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return rcell;
        
    }
    
    
    return nil;
    
}

-(void)goReturnMoney:(UIButton *)sender
{
    Order *morder = [self.data objectAtIndex:sender.tag];
    
    NSLog(@"Orider id is:%@",morder.order_id);
    
    for (Order *order in self.data) {
        NSString *str = nil;
        if (order.canfund) {
            str=@"Y";
        }else
        {
            str=@"N";
        }
        
        NSLog(@"order details:%@,%@,%@,%d",order.product,order.order_id,str,sender.tag);
    }
    
    [NetOperation OrderCanRefundWithOrderID:morder.order_id withblock:^(Order *order, NSError *error) {
        if (!error) {
            RefundViewController *rfv = [[RefundViewController alloc] init];
            rfv.order=morder;
            [self.navigationController pushViewController:rfv animated:YES];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起，该订单不允许退款" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
}
-(void)goDetail:(id)sender
{

    NSLog(@"godetail");

}

-(void)goPay:(UIButton *)sender
{
    Order *order = [self.data objectAtIndex:sender.tag];
    [SVProgressHUD show];
    [NetOperation ReadyPayWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey orderid:order.order_id withblock:^(Order *order, NSError *error) {
        [SVProgressHUD dismiss];
        if (!error) {
            OrderEnsureViewController *oec = [[OrderEnsureViewController alloc] init];
            oec.order=order;
            [self.navigationController pushViewController:oec animated:YES];
        }
    }];
}

-(void)removeActoin:(UIButton *)sender
{
    Order *order = [self.data objectAtIndex:sender.tag];
    [SVProgressHUD show];
    [NetOperation removeOrderWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey orderid:order.order_id withblock:^(BOOL success, NSError *error) {
        [SVProgressHUD dismiss];
        if (!error) {
            [self.data removeObjectAtIndex:sender.tag];
            [self.tableView reloadData];
        }
      
    }];
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Order *order = [self.data objectAtIndex:indexPath.row];
    SaleDetailViewController *sd = [[SaleDetailViewController alloc] init];
    sd.good = order.good;
    sd.good.gid = [order.team_id integerValue];
    [self.navigationController pushViewController:sd animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [self loadData];
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titlelb;
    
    switch (self.flag) {
        case PAYED:
            titlelb.text = @"已付款";
            break;
        case UNPAY:
            titlelb.text = @"未付款";
            break;
        case RETURN:
            titlelb.text = @"申请退款";
            break;
            
        default:
            break;
    }
    
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
