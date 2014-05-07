//
//  MineViewController.m
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "GPUserManager.h"
#import "OrderListViewController.h"
#import "UserProfileViewController.h"
#import "NetOperation.h"
#import "LocalDB.h"
#import "UserOperation.h"
#import "CouponStatusController.h"
#import "EditAddressController.h"
#import "CouponListController.h"

@interface MineViewController ()

@end

@implementation MineViewController
@synthesize collectNum=_collectNum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadCollectNum
{
    [NetOperation getMyCollectNumberWithUid:[GPUserManager sharedClient].user.userid key:[GPUserManager sharedClient].user.userkey withblock:^(NSInteger number, NSError *error) {
        self.collectNum = number;
        self.lbcollectnum.text = self.lbcollectnum.text = [NSString stringWithFormat:@"%d",self.collectNum];
        ;
    }];
    
    
}

-(void)loadCountInfo
{

    [NetOperation getCountInfoWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey withblock:^(NSDictionary *countinf, NSError *error) {
        
        if (!error) {
            self.lb_unpayed.text = [NSString stringWithFormat:@"%@",[countinf objectForKey:@"wfkCount"]];
            self.lb_payed.text = [NSString stringWithFormat:@"%@",[countinf objectForKey:@"yfkCount"]];
            self.lb_unconsume.text = [NSString stringWithFormat:@"%@",[countinf objectForKey:@"wxfCount"]];
            self.lb_consume.text = [NSString stringWithFormat:@"%@",[countinf objectForKey:@"yxfCount"]];
        
        }
        
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectNum = 0;
    
    //tableview
    CGRect rec=self.view.bounds;
    rec.size.height -= 88;
    self.tableView = [[UITableView alloc] initWithFrame:rec style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    [self.view addSubview:self.tableView];
    
    [self setLoginView];
    
    // Do any additional setup after loading the view.
}

-(void)setLoginView
{

    //cover image view
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 80.0f)];
    UIImageView *coverimg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 80.0f)];
    [coverimg setImage:[UIImage imageNamed:@"minheader"]];
    [headerview addSubview:coverimg];
    
    self.notice = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 10.0f, 140.0f, 21.0f)];
    self.notice.backgroundColor = [UIColor clearColor];
    self.notice.textColor = [UIColor whiteColor];
    self.notice.text = @"您还没有登录喔~";
    [headerview addSubview:self.notice];
    
    self.btnlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnlogin setTitle:@"马上登录" forState:UIControlStateNormal];
    [self.btnlogin setFrame:CGRectMake(108.0f, 36.0f, 102.0f, 30.0f)];
    [self.btnlogin setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [self.btnlogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:self.btnlogin];
    
    
    
    self.usernick = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 20.0f, 250.0f, 21.0f)];
    self.usernick.backgroundColor = [UIColor clearColor];
    self.usernick.textColor = [UIColor whiteColor];
    [headerview addSubview:self.usernick];
    
    self.usermoney = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 40.0f, 250.0f, 21.0f)];
    self.usermoney.backgroundColor = [UIColor clearColor];
    self.usermoney.textColor = [UIColor whiteColor];
    self.usermoney.font=[UIFont fontWithName:@"Helvetica" size:14.0f];
    [headerview addSubview:self.usermoney];
    
    self.arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    self.arrow.frame = CGRectMake(280.0f, 30.0f, 13.0f, 22.0f);
    [headerview addSubview:self.arrow];
    
    self.usericon = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 15.0f, 48.0f, 48.0f)];
    self.usericon.image = [UIImage imageNamed:@"usericon"];
    [headerview addSubview:self.usericon];
    
    self.moneyicon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"money_icon"]];
    self.moneyicon.frame = CGRectMake(70.0f, 45.0f, 15.0f, 11.0f);
    [headerview addSubview:self.moneyicon];
    
    
    self.btngoprofile = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btngoprofile.frame = CGRectMake(0.0f, 0.0f, 320.0f, 80.0f);
    [self.btngoprofile addTarget:self action:@selector(goProfile:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:self.btngoprofile];
    
    
    [self.tableView setTableHeaderView:headerview];

}


-(void)goProfile:(id)sender
{

    UserProfileViewController *upv = [[UserProfileViewController alloc] init];
    upv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:upv animated:YES];
    

}

-(void)refreshStatus
{

    if ([[GPUserManager sharedClient] isLogin]) {
        [self.usernick setHidden:NO];
        [self.usericon setHidden:NO];
        [self.moneyicon setHidden:NO];
        [self.arrow setHidden:NO];
        [self.usermoney setHidden:NO];
        [self.btnlogin setHidden:YES];
        [self.notice setHidden:YES];
        [self.btngoprofile setHidden:NO];
        
        self.usernick.text = [GPUserManager sharedClient].user.username;
        
        
    }else
    {
        [self.btnlogin setHidden:NO];
        [self.notice setHidden:NO];
        [self.usernick setHidden:YES];
        [self.usermoney setHidden:YES];
        [self.moneyicon setHidden:YES];
        [self.usericon setHidden:YES];
        [self.arrow setHidden:YES];
        [self.btngoprofile setHidden:YES];
    }
    [self.tableView reloadData];

}



#pragma tableview delegate and datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    return 6;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 48;
    
}



-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        return 60;
    }
    return 10;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *iconstr = @[@"payed_icon",@"minicon",@"minicon",@"min_unpay",@"return_icon",@"min_address"];
    
    MineCell *cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"minecell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.coverimg.image = [UIImage imageNamed:[iconstr objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
        {
            cell.titlelb.text = @"未消费";
            self.lb_unconsume = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 10.0f, 30.0f, 21.0f)];
            [cell.contentView addSubview:self.lb_unconsume];
            self.lb_unconsume.backgroundColor = [UIColor clearColor];
            
        }
            break;
        case 1:
        {
            cell.titlelb.text = @"已消费";
            self.lb_consume = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 10.0f, 30.0f, 21.0f)];
            [cell.contentView addSubview:self.lb_consume];
            self.lb_consume.backgroundColor = [UIColor clearColor];
        }
            break;
        case 2:
        {
            cell.titlelb.text = @"已付款";
            self.lb_payed = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 10.0f, 30.0f, 21.0f)];
            [cell.contentView addSubview:self.lb_payed];
            self.lb_payed.backgroundColor = [UIColor clearColor];
        }
            break;
            
        case 3:
        {
            cell.titlelb.text = @"未付款";
            self.lb_unpayed = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 10.0f, 30.0f, 21.0f)];
            [cell.contentView addSubview:self.lb_unpayed];
            self.lb_unpayed.backgroundColor = [UIColor clearColor];
        }
            break;
        case 4:
            cell.titlelb.text = @"申请退款";
            break;
        case 5:
            cell.titlelb.text = @"收货地址管理";
            
        default:
            break;
    }
    
    
    
    return cell;
    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        
        UIView *sheader = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
        
       // sheader.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"minsecheader"]];
        
        
        
        UIButton *distkt = [UIButton buttonWithType:UIButtonTypeCustom];
        distkt.frame = CGRectMake(0.0f, 0.0f, 160.0f, 60.0f);
        [distkt addTarget:self action:@selector(distAction:) forControlEvents:UIControlEventTouchUpInside];
        [sheader addSubview:distkt];
        
        UIButton *storebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        storebtn.frame = CGRectMake(160.0f, 0.0f, 160.0f, 60.0f);
        [storebtn addTarget:self action:@selector(storeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([GPUserManager sharedClient].isLogin) {
            [distkt setImage:[UIImage imageNamed:@"my_coupon_login"] forState:UIControlStateNormal];
            [storebtn setImage:[UIImage imageNamed:@"my_collect_login"] forState:UIControlStateNormal];
            
        }else
        {
            [distkt setImage:[UIImage imageNamed:@"my_coupon_unlog"] forState:UIControlStateNormal];
            [storebtn setImage:[UIImage imageNamed:@"my_collect_unlog"] forState:UIControlStateNormal];
        
        }
        [sheader addSubview:storebtn];
        
        self.lbcollectnum = [[UILabel alloc] initWithFrame:CGRectMake(225.0f, 10.0f, 100.0f, 21.0f)];
        self.lbcollectnum.textAlignment = NSTextAlignmentCenter;
        self.lbcollectnum.backgroundColor = [UIColor clearColor];
        self.lbcollectnum.text = [NSString stringWithFormat:@"%d",self.collectNum];
        [sheader addSubview:self.lbcollectnum];
        
        
        if ([GPUserManager sharedClient].isLogin) {
            self.lbcollectnum.hidden = NO;
        }else
        {
            self.lbcollectnum.hidden = YES;
        }
        
        return sheader;
        
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
//        CouponStatusController *unconsumed = [[CouponStatusController alloc] init];
//        unconsumed.hidesBottomBarWhenPushed = YES;
//        unconsumed.flag = UNCONSUMED;
//        [self.navigationController pushViewController:unconsumed animated:YES];
//        
        CouponListController *unconsumed = [[CouponListController alloc] init];
        unconsumed.hidesBottomBarWhenPushed = YES;
        unconsumed.flag = UNCONSUMED;
        [self.navigationController pushViewController:unconsumed animated:YES];
        

    }
    
    if (indexPath.row==1) {
//        CouponStatusController *consumed = [[CouponStatusController alloc] init];
//        consumed.hidesBottomBarWhenPushed = YES;
//       consumed.flag = CONSUMED;
//        [self.navigationController pushViewController:consumed animated:YES];
        
        CouponListController *unconsumed = [[CouponListController alloc] init];
        unconsumed.hidesBottomBarWhenPushed = YES;
        unconsumed.flag = CONSUMED;
        [self.navigationController pushViewController:unconsumed animated:YES];
        
    }
    
    if (indexPath.row==2) {
        OrderListViewController *pav = [[OrderListViewController alloc] init];
        pav.flag = PAYED;
        pav.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pav animated:YES];
        
        
    }
    if (indexPath.row==3) {
        OrderListViewController *upv = [[OrderListViewController alloc] init];
        upv.flag = UNPAY;
        upv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:upv animated:YES];
    }
    if (indexPath.row==4) {
        OrderListViewController *rt = [[OrderListViewController alloc] init];
        rt.flag = RETURN;
        rt.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rt animated:YES];
    }
    
    if (indexPath.row==5) {
        EditAddressController *eac = [[EditAddressController alloc] init];
        eac.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:eac animated:YES];
    }

   

}

-(void)distAction:(id)sender
{
    if ([[GPUserManager sharedClient] isLogin]) {
        MyCouponController *disv = [[MyCouponController alloc] init];
        [self.navigationController pushViewController:disv animated:YES];

    }
    else
    {
    
        [self login:nil];
    
    }

}

-(void)storeAction:(id)sender
{

    if ([[GPUserManager sharedClient] isLogin]) {
   
        CollectViewController *stv = [[CollectViewController alloc] init];
        [self.navigationController pushViewController:stv animated:YES];

    }
    else
    {
    
        [self login:nil];
    
    }
   
}



-(void)login:(id)sender
{

    LoginViewController *loginv = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginv];
    loginv.delegate = self;
    [self presentViewController:nav animated:YES completion:^{
        
        
        
    }];
}




-(void)autoLogin
{

    self.view.userInteractionEnabled = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [UserOperation loginWithUserName:[GPUserManager sharedClient].user.email password:[GPUserManager sharedClient].user.password withblock:^(User *user, NSError *error) {
        
        self.view.userInteractionEnabled = YES;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (!error) {
            [LocalDB storeUserInfo:user];
            [GPUserManager sharedClient].user = user;
            [GPUserManager sharedClient].accessToken = user.userkey;
            [GPUserManager sharedClient].needAutoLogin = NO;
            [self refreshStatus];
           
        }
        else
        {
            
        }
        
        
    }];

}



-(void)loadMoney
{
    [NetOperation getUserMoneyWithUID:[GPUserManager sharedClient].user.userid userkdy:[GPUserManager sharedClient].user.userkey withblock:^(float money, NSError *error) {
        if (!error) {
            self.usermoney.text = [NSString stringWithFormat:@"账户余额：%.2f元",money];
        }else
        {
            self.usermoney.text = [NSString stringWithFormat:@"账户余额：%.2f元",0.0f];
        }
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"我的";
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titlelb;
    
    if ([GPUserManager sharedClient].needAutoLogin) {
        [self autoLogin];
    }
    
    [self refreshStatus];
    
    [self loadCollectNum];
    [self loadMoney];
    [self loadCountInfo];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
