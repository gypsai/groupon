//
//  RefundViewController.m
//  tuan
//
//  Created by foolish on 13-4-20.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "RefundViewController.h"
#import "SVProgressHUD.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import "Coupon.h"
@interface RefundViewController ()

@end

@implementation RefundViewController
@synthesize order=_order;

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
    
    CGRect rec = self.view.bounds;
    rec.size.height -= 49;
    self.tableView = [[UITableView alloc] initWithFrame:rec style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithRed:160.0f/255 green:160.0f/255 blue:160.0f/255 alpha:0.8];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    [self.view addSubview:self.tableView];
    
    self.selectReason = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
    UIButton *refundbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refundbtn setBackgroundImage:[UIImage imageNamed:@"btn_refund"] forState:UIControlStateNormal];
    [refundbtn setTitle:@"申请退款" forState:UIControlStateNormal];
    [refundbtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    refundbtn.frame = CGRectMake(10.0f, 5.0f, 300.0f, 49.0f);
    self.tableView.tableFooterView = footer;
    
    [footer addSubview:refundbtn];
    
	// Do any additional setup after loading the view.
}

-(void)sure:(id)sender
{
    [SVProgressHUD show];
    NSArray *str = @[@"预约不上",@"去过了，不太满意",@"网友/网上评价不好",@"买多了/买错了",@"计划有变，没时间消费",@"后悔了，不想要了",@"其他原因"];
    NSString *strreason = @"退款原因：";
    for (NSInteger i=0; i<[str count]; i++) {
        if ([[self.selectReason objectAtIndex:i] integerValue]==1) {
            strreason = [strreason stringByAppendingFormat:@"%@",[str objectAtIndex:i]];
        }
    }
    
    [NetOperation OrderRefundWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey orderid:_order.order_id reason:strreason withblock:^(BOOL success, NSError *error) {
        [SVProgressHUD dismiss];
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退款成功，请耐心等待！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退款失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}


-(void)secretCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)index
{
    cell.userInteractionEnabled = NO;
    Coupon *coupon = [_order.couponlist objectAtIndex:index.row];
    
    UILabel *t1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 50.0f, 21.0f)];
    t1.text = [NSString stringWithFormat:@"验证码%d",index.row+1];
    t1.textColor = [UIColor colorWithRed:83.0f/255 green:83.0f/255 blue:83.0f/255 alpha:1];
    t1.font = [Util parseFont:24];
    

    
    UILabel *t2 = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 10.0f, 200.0f, 21.0f)];
    t2.text = coupon.secret;
    
    t1.backgroundColor = [UIColor clearColor];
    t2.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:t1];
    [cell.contentView addSubview:t2];

}

-(void)moneyCell:(UITableViewCell *)cell
{
    cell.userInteractionEnabled = NO;
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 70.0f, 21.0f)];
    l1.text = @"退款金额";
    l1.textColor = [UIColor colorWithRed:83.0f/255 green:83.0f/255 blue:83.0f/255 alpha:1];
    l1.font = [Util parseFont:24];
    

    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 10.0f, 200.0f, 21.0f)];
    l2.text = [NSString stringWithFormat:@"%.2f",_order.origin];
    l2.textColor = [UIColor redColor];
    l1.backgroundColor = [UIColor clearColor];
    l2.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:l1];
    [cell.contentView addSubview:l2];
    
}

-(void)refundTypeCell:(UITableViewCell *)cell indexpath:(NSIndexPath *)indexpath;
{

    cell.userInteractionEnabled = NO;
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 80.0f, 21.0f)];
    l1.textColor = [UIColor colorWithRed:83.0f/255 green:83.0f/255 blue:83.0f/255 alpha:1];
    l1.font = [Util parseFont:24];
    
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 10.0f, 200.0f, 21.0f)];
    l2.textColor = [UIColor colorWithRed:160.0f/255 green:160.0f/255 blue:160.0f/255 alpha:1];
    l2.font = [Util parseFont:18];
    l1.backgroundColor = [UIColor clearColor];
    l2.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:l1];
    [cell.contentView addSubview:l2];
    
    switch (indexpath.row) {
        case 0:
            l1.text = @"退至搜搜账户";
            l2.text = @"（1个工作日内到账）";
            break;
            
        case 1:
            l1.text = @"原路退回";
            l2.text = @"（3-10个工作日内退款到原支付方）";
            break;
            
        default:
            break;
    }
    
}

-(void)reasonCell:(UITableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    
    NSArray *str = @[@"预约不上",@"去过了，不太满意",@"网友/网上评价不好",@"买多了/买错了",@"计划有变，没时间消费",@"后悔了，不想要了",@"其他原因"];
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 10.0f, 200.0f, 21.0f)];
    l2.textColor = [UIColor colorWithRed:160.0f/255 green:160.0f/255 blue:160.0f/255 alpha:1];
    l2.font = [Util parseFont:25];
    l2.text = [str objectAtIndex:indexpath.row];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(choseReason:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = cell.contentView.frame;
    btn.tag = indexpath.row;
    if ([[self.selectReason objectAtIndex:indexpath.row] integerValue]==1) {
        [btn setImage:[UIImage imageNamed:@"refund_mark_sel"] forState:UIControlStateNormal];
    }else
    {
        [btn setImage:[UIImage imageNamed:@"refund_mark_un"] forState:UIControlStateNormal];
        
    }
    
    
    l2.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:btn];
    [cell.contentView addSubview:l2];
    

}

-(void)choseReason:(UIButton *)sender
{
    if ([[self.selectReason objectAtIndex:sender.tag] integerValue]==0) {
       [sender setImage:[UIImage imageNamed:@"refund_mark_sel"] forState:UIControlStateNormal];
        [self.selectReason replaceObjectAtIndex:sender.tag withObject:[NSNumber numberWithInteger:1]];
        [self.tableView reloadData];
        return;
    }else
    {
        [sender setImage:[UIImage imageNamed:@"refund_mark_sel"] forState:UIControlStateNormal];
        [self.selectReason replaceObjectAtIndex:sender.tag withObject:[NSNumber numberWithInteger:0]];
        [self.tableView reloadData];
        return;
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"refund"];
    
    switch (indexPath.section) {
        case 0:
            [self secretCell:cell indexPath:indexPath];
            break;
        case 1:
            [self moneyCell:cell];
            break;
//        case 2:
//            [self refundTypeCell:cell indexpath:indexPath];
//            break;
//           
        case 2:
             [self reasonCell:cell indexpath:indexPath];
            break;
        default:
            break;
    }
  return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==1) {
        return nil;
    }
    
    NSArray *titlestr = @[_order.product,@"",@"退款原因"];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    UILabel *titlelb= [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 280.0f, 21.0f)];
    titlelb.text = [titlestr objectAtIndex:section];
    titlelb.backgroundColor = [UIColor clearColor];
    [header addSubview:titlelb];
    
    if (section==3) {
        header.frame = CGRectMake(0.0f, 0.0f, 320.0f, 56.0f);
        
        UILabel *pragm = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 35.0f, 280.0f, 21.0f)];
        pragm.text = @"为了帮我们做得更好，请提交退款原因（至少一项）";
        pragm.textColor = [UIColor colorWithRed:160.0f/255 green:160.0f/255 blue:160.0f/255 alpha:1];
        pragm.font = [Util parseFont:20];
        pragm.backgroundColor = [UIColor clearColor];
        [header addSubview:pragm];
        
    }
    
    return header;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    switch (section) {
        case 0:
            return [_order.couponlist count];
            break;
        case 1:
            return 1;
            break;
   
        case 2:
            
            return 7;
            break;
            
        default:
            break;
    }
    
    return 0;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 0;
    }
    if (section==3) {
        return 56;
    }
    return 35.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)viewWillAppear:(BOOL)animated
{

    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"申请退款";
    self.navigationItem.titleView = titlelb;
    

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
