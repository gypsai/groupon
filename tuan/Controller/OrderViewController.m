//
//  OrderViewController.m
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "OrderViewController.h"
#import "PhoneBindViewController.h"
#import "OrderEnsureViewController.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import "SVProgressHUD.h"
#define NUM_TAG 12121212
@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize order=_order;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)showView
{
    //tableview
    CGRect rec = self.view.bounds;
    //rec.size.height +=320.0f;
    rec.size.height -= 49;
    self.tableView = [[UITableView alloc] initWithFrame:rec style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    [self.view addSubview:self.tableView];
    
    self.buynum = 1;
    
    UIView *footerv = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    //footerv.backgroundColor = [UIColor greenColor];
    UIButton *btnbuy = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnbuy setImage:[UIImage imageNamed:@"btn_order"] forState:UIControlStateNormal];
    [btnbuy setFrame:CGRectMake(10.0f, 10.0f, 297.0f, 41.0f)];
    [btnbuy addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    [footerv addSubview:btnbuy];
    self.tableView.tableFooterView = footerv;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self showView];
    [self.tableView reloadData];
    

}


#pragma tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
            
        default:
            break;
    }
    
    return 0;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==2) {
        return 50;
    }
    return 44;
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 44;
    
}

-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    
    switch (section) {
        case 0:
            titlelb.text = _order.good.product;
            break;
        case 1:
            titlelb.text = @"    手机号码";
            break;
        case 2:
            titlelb.text = @"    订单留言";
            break;
        default:
            break;
    }
    
    return titlelb;
    
}

-(void)firstCell:(UITableViewCell *)cell index:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 60.0f, 21.0f)];
        lbtitle.backgroundColor = [UIColor clearColor];
        lbtitle.text = @"单价:";
        [cell.contentView addSubview:lbtitle];
        
        UILabel *lbcontent = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 10.0f, 100.0f, 21.0f)];
        lbcontent.backgroundColor = [UIColor clearColor];
        lbcontent.text =[NSString stringWithFormat:@"￥%.2f", _order.good.team_price];
        [cell.contentView addSubview:lbcontent];
        
        
    }
    if (indexPath.row==1) {
        UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 60.0f, 21.0f)];
        lbtitle.backgroundColor = [UIColor clearColor];
        lbtitle.text = @"数量:";
        [cell.contentView addSubview:lbtitle];
        
        UIButton *btnplus = [UIButton buttonWithType:UIButtonTypeCustom];
        btnplus.frame = CGRectMake(150.0f, 7.0f, 30.0f, 30.0f);
        [btnplus setImage:[UIImage imageNamed:@"plus_btn"] forState:UIControlStateNormal];
        btnplus.tag = 0;
        [btnplus addTarget:self action:@selector(countControll:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnsub = [UIButton buttonWithType:UIButtonTypeCustom];
        btnsub.frame = CGRectMake(200.0f, 7.0f, 30.0f, 30.0f);
        [btnsub setImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
        btnsub.tag = 1;
        [btnsub addTarget:self action:@selector(countControll:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tfnum = [[UITextField alloc] initWithFrame:CGRectMake(240.0f, 10.0f, 40.0f, 21.0f)];
        //self.tfnum.backgroundColor = [UIColor clearColor];
        self.tfnum.borderStyle = UITextBorderStyleLine;
        self.tfnum.delegate = self;
        self.tfnum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.tfnum.textAlignment = NSTextAlignmentCenter;
        self.tfnum.text = [NSString stringWithFormat:@"%d",self.buynum];
        self.tfnum.tag = NUM_TAG;
        [cell.contentView addSubview:self.tfnum];
        [cell.contentView addSubview:btnplus];
        [cell.contentView addSubview:btnsub];
    }
    if (indexPath.row==2) {
        UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 60.0f, 21.0f)];
        lbtitle.backgroundColor = [UIColor clearColor];
        lbtitle.text = @"总额:";
        [cell.contentView addSubview:lbtitle];
        
        self.totalpricelb = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 10.0f,100.0f, 21.0f)];
        self.totalpricelb.backgroundColor = [UIColor clearColor];
        self.totalpricelb.text = [NSString stringWithFormat:@"￥%.2f", _order.good.team_price];
        self.totalpricelb.textColor=[UIColor redColor];
        ;
        [cell.contentView addSubview:self.totalpricelb];
    }
    
}

-(void)countControll:(UIButton *)sender
{
    if (sender.tag == 0) {
        self.buynum += 1;
    }
    if (sender.tag == 1) {
        if (self.buynum>=2) {
            self.buynum -=1;
        }
    }
    self.totalpricelb.text = [NSString stringWithFormat:@"￥%.2f",_order.good.team_price*self.buynum];
    self.tfnum.text=[NSString stringWithFormat:@"%d",self.buynum];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellorder"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    switch (indexPath.section) {
        case 0:
            [self firstCell:cell index:indexPath];
            break;
        case 1:
            [self phoneCell:indexPath cell:cell];
            break;
        case 2:
            [self remarkCell:cell];
            break;
        default:
            break;
    }
    
    return cell;
    
}

-(void)remarkCell:(UITableViewCell *)cell
{
    self.textv = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 260.0f, 30.0f)];
    self.textv.placeholder = @"订单附言";
    self.textv.backgroundColor = [UIColor clearColor];
    self.textv.delegate = self;
    self.textv.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textv.tag = 1000;
    [cell.contentView addSubview:self.textv];

}



-(void)phoneCell:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{

    
    UITextField *tfcontent = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 270.0f, 21.0f)];
    tfcontent.delegate = self;
    tfcontent.backgroundColor = [UIColor clearColor];
    tfcontent.placeholder = _order.bind_mobile;
    tfcontent.tag = 999;
    
    [cell.contentView addSubview:tfcontent];
}

-(void)buy:(id)sender
{
    
    self.param = [[NSMutableDictionary alloc] init];
    [self.param setObject:[GPUserManager sharedClient].user.userid forKey:@"userid"];
    [self.param setObject:[GPUserManager sharedClient].user.userkey forKey:@"userkey"];
    
    NSInteger num = [self.tfnum.text integerValue];
    if ((_order.good.per_number>0)&&(_order.good.per_number<num)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"超过最大购买限制%d个",_order.good.per_number] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    if ((_order.good.permin_number>0)&&(_order.good.permin_number>num)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"至少买%d个",_order.good.permin_number] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    
    [self.param setObject:self.tfnum.text forKey:@"buyCount"];
    
    [self.param setObject:[NSNumber numberWithInteger:_order.good.gid] forKey:@"teamid"];
    [self.param setObject:_order.bind_mobile forKey:@"mobile"];
    [self.param setObject:[GPUserManager sharedClient].user.realname forKey:@"shouhuoren"];
    [self.param setObject:@"ios" forKey:@"referer"];
    if (self.textv.text == nil) {
        self.textv.text = @" ";
    }
    [self.param setObject:self.textv.text forKey:@"remark"];
  
    [SVProgressHUD show];
    [NetOperation CreateOrderWithParam:self.param withblock:^(Order *order, NSError *error) {
        [SVProgressHUD dismiss];
        NSArray *arr1 = [self.param allKeys];
        NSArray *arr2 = [self.param allValues];
        
        for (NSInteger i=0; i<[arr2  count]; i++) {
            NSLog(@"%@:%@",[arr1 objectAtIndex:i],[arr2 objectAtIndex:i]);
        }
        
        if (!error) {
            Order *temporder = [[Order alloc] init];
            temporder = order;
            temporder.good = self.order.good;
            temporder.bind_mobile = self.order.bind_mobile;
            self.order = temporder;
            
            OrderEnsureViewController *odev = [[OrderEnsureViewController alloc] init];
            odev.order = self.order;
            [self.navigationController pushViewController:odev animated:YES];
            
        }else
        {
            NSLog(@"error is:%@",error);
        }
        
    }];
  
}

-(void)gotobind:(id)sender
{

    PhoneBindViewController *pbv = [[PhoneBindViewController alloc] init];
    [self.navigationController pushViewController:pbv animated:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"提交订单";
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField.tag==1000) {
//        NSIndexPath *idp = [NSIndexPath indexPathForRow:0 inSection:2];
//        
//        [self.tableView scrollToRowAtIndexPath:idp atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        
        // CGPoint point = self.tableView.contentOffset;
        // point .y -= self.tableView.rowHeight;
        CGSize size = self.tableView.contentSize;
        size.height +=300;
        self.tableView.contentSize = size;
        self.tableView.contentOffset = CGPointMake(0.0f, size.height-500);
    }
    if (textField.tag==999) {
        NSIndexPath *idp = [NSIndexPath indexPathForRow:0 inSection:2];
        
        [self.tableView scrollToRowAtIndexPath:idp atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        // CGPoint point = self.tableView.contentOffset;
        // point .y -= self.tableView.rowHeight;
        CGSize size = self.tableView.contentSize;
        size.height +=300;
        self.tableView.contentSize = size;
        self.tableView.contentOffset = CGPointMake(0.0f, size.height-600);
    }
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
    [textField resignFirstResponder];
    return YES;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==1000) {
        CGSize size = self.tableView.contentSize;
        size.height -=300;
        self.tableView.contentSize = size;
    }
    if (textField.tag==999) {
        CGSize size = self.tableView.contentSize;
        size.height -=300;
        self.tableView.contentSize = size;
    }
    if (textField.tag==NUM_TAG) {
        
        self.buynum = [self.tfnum.text integerValue];
        self.totalpricelb.text = [NSString stringWithFormat:@"￥%.2f",_order.good.team_price*self.buynum];
        
    }

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
