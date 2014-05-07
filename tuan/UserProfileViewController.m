//
//  UserProfileViewController.m
//  tuan
//
//  Created by foolish on 13-4-4.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "UserProfileViewController.h"
#import "GPUserManager.h"
#import "ChangeNickController.h"
#import "ChangePasswordController.h"
#import "EditAddressController.h"
#import "UserOperation.h"
#import "LocalDB.h"
#import "NetOperation.h"
#import "PhoneBindViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController
@synthesize usermoney=_usermoney;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //tableview
    CGRect rec = self.view.bounds;
    rec.size.height -= 49;
    self.tableView = [[UITableView alloc] initWithFrame:rec style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    [self.view addSubview:self.tableView];
    
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 80.0f)];
    UIImageView *coverimg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 80.0f)];
    [coverimg setImage:[UIImage imageNamed:@"minheader"]];
    [headerview addSubview:coverimg];
    
    self.usernick = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 20.0f, 250.0f, 21.0f)];
    self.usernick.backgroundColor = [UIColor clearColor];
    self.usernick.textColor = [UIColor whiteColor];
    [headerview addSubview:self.usernick];
    
    self.usermoney = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 40.0f, 250.0f, 21.0f)];
    self.usermoney.backgroundColor = [UIColor clearColor];
    self.usermoney.textColor = [UIColor whiteColor];
    self.usermoney.font=[UIFont fontWithName:@"Helvetica" size:15.0f];
    [headerview addSubview:self.usermoney];

    
    self.usericon = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 15.0f, 48.0f, 48.0f)];
    self.usericon.image = [UIImage imageNamed:@"usericon"];
    [headerview addSubview:self.usericon];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
    logout.frame = CGRectMake(22.0f, 2.0f, 257.0f, 32.0f);
    [logout setImage:[UIImage imageNamed:@"logout_btn"] forState:UIControlStateNormal];
    [logout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:logout];
    self.tableView.tableFooterView = footer;
    
    [self.tableView setTableHeaderView:headerview];

	// Do any additional setup after loading the view.
}

-(void)logout:(id)sender
{
        [[GPUserManager sharedClient] logOut];
        [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma tableview delegate and datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 48;
    
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MineCell *cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"minecell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.coverimg.image = [UIImage imageNamed:@"minicon"];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"账户设置";
            break;
        case 1:
            cell.titlelb.text = [GPUserManager sharedClient].user.username;
            cell.functoinlb.text = @"修改";
            break;
            
        case 2:
            cell.titlelb.text = @"修改用户密码";
            cell.functoinlb.text = @"更改";
            break;
        case 3:
            cell.titlelb.text = [NSString stringWithFormat:@"绑定手机%@",[GPUserManager sharedClient].user.mobile];
            cell.functoinlb.text = @"更改";
            
            break;
           
        case 4:
         
            cell.titlelb.text = @"修改收货地址";
            cell.functoinlb.text = @"修改";
            break;
        default:
            break;
    }
    
    
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
      
    }
    if (indexPath.row==1) {
        ChangeNickController *cnc = [[ChangeNickController alloc] init];
        cnc.username = [GPUserManager sharedClient].user.username;
        [self.navigationController pushViewController:cnc animated:YES];
    }
    if (indexPath.row==2) {
        ChangePasswordController *cpc = [[ChangePasswordController alloc] init];
        [self.navigationController pushViewController:cpc animated:YES];
   }
    if (indexPath.row==3) {
        PhoneBindViewController *pb = [[PhoneBindViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pb];
        
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    
    }

}

-(void)changeSuccess
{
    
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
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"我的资料";
    self.navigationItem.titleView = titlelb;
    

    
    self.usernick.text = [GPUserManager sharedClient].user.username;
    [self.tableView reloadData];
    [self loadMoney];

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
