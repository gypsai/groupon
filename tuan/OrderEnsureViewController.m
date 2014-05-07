//
//  OrderEnsureViewController.m
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "OrderEnsureViewController.h"
#import "PayViewController.h"
#import "AlixPayResult.h"
#import "AlixPay.h"
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import "PaySuccessViewController.h"
#import "UserOperation.h"
#import "UIDevice+IdentifierAddition.h"

#define CALL_BACK_URL_DEBUG @"http://183.129.206.83:8080/ycssapi/servlet/RSANotifyReceiver.servlet"
#define CALL_BACK_URL @"http://api.ycss.com:8080/ycssapi/servlet/RSANotifyReceiver.servlet"

@interface OrderEnsureViewController ()

@end

@implementation OrderEnsureViewController
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
    
    
    //tableview
    CGRect rec = self.view.bounds;
    rec.size.height -= 49;
    self.tableView = [[UITableView alloc] initWithFrame:rec style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    [self.view addSubview:self.tableView];
    
    
    UIView *footerv = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    UIButton *btnbuy = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnbuy setImage:[UIImage imageNamed:@"suer_pay"] forState:UIControlStateNormal];
    [btnbuy setFrame:CGRectMake(10.0f, 10.0f, 297.0f, 41.0f)];
    [btnbuy addTarget:self action:@selector(sureorder:) forControlEvents:UIControlEventTouchUpInside];
    [footerv addSubview:btnbuy];
    self.tableView.tableFooterView = footerv;
    
   
    

	// Do any additional setup after loading the view.
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
            return 2;
            break;
        case 1:
            return 3;
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
            titlelb.text = @"    结算信息";
            break;
        case 2:
            titlelb.text = @"    支付方式";
        default:
            break;
    }
    
    return titlelb;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellorder"];
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 7.0f, 150.0f, 30.0f)];
    titlelb.textAlignment = NSTextAlignmentLeft;
    titlelb.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titlelb];
    
    UILabel *contentlb = [[UILabel alloc] initWithFrame:CGRectMake(160.0f, 7.0f, 120.0f, 30.0f)];
    contentlb.backgroundColor = [UIColor clearColor];
    contentlb.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:contentlb];
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                titlelb.text = @"数量";
                contentlb.text = [NSString stringWithFormat:@"%d",_order.totalnumb];
            }
            if (indexPath.row==1) {
                titlelb.text = @"总额";
                contentlb.text = [NSString stringWithFormat:@"￥%.2f",_order.orderZongJia];
            }
           
            break;
        case 1:
            if (indexPath.row==0) {
                titlelb.text = @"总价";
                contentlb.text = [NSString stringWithFormat:@"￥%.2f",_order.orderZongJia];
                
            }
            if (indexPath.row==1) {
                titlelb.text = @"余额支付";
                contentlb.textColor = [UIColor redColor];
                if (_order.usermoney<_order.orderZongJia) {
                    contentlb.text = [NSString stringWithFormat:@"￥%.2f",_order.usermoney];
                }else
                {
                   contentlb.text = [NSString stringWithFormat:@"￥%.2f",_order.orderZongJia];
                }
                
            }
            if (indexPath.row==2) {
                titlelb.text = @"还需支付";
                contentlb.textColor = [UIColor redColor];
                if (_order.usermoney<_order.orderZongJia) {
                    contentlb.text = [NSString stringWithFormat:@"￥%.2f",_order.orderZongJia-_order.usermoney];
                }else
                {
                    contentlb.text = [NSString stringWithFormat:@"￥%.2f",0.00f];
                }
            }
            
            break;
        case 2:
        {
            UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alipay_type"]];
            icon.frame = CGRectMake(10.0f, 6.0f, 208.0f, 32.0f);
            [cell.contentView addSubview:icon];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

-(void)goAlipay
{
    NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
	
    
    
	//partner和seller获取失败,提示
	if ([partner length] == 0 || [seller length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
														message:@"缺少partner或者seller。"
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
		[alert show];
		return;
	}
	
	/*
	 *生成订单信息及签名
	 *由于demo的局限性，本demo中的公私钥存放在AlixPayDemo-Info.plist中,外部商户可以存放在服务端或本地其他地方。
	 */
	//将商品信息赋予AlixPayOrder的成员变量
	AlixPayOrder *order = [[AlixPayOrder alloc] init];
	order.partner = partner;
	order.seller = seller;
	order.tradeNO = _order.pay_id; //订单ID（由商家自行制定）
	order.productName = _order.good.product; //商品标题
	order.productDescription = _order.good.title; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",_order.needPayMoney]; //商品价格
	order.notifyURL =  CALL_BACK_URL; //回调URL
	
	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
	NSString *appScheme = @"tuan";
	
	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];
	NSLog(@"orderSpec = %@",orderSpec);
	
	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
	id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
	NSString *signedString = [signer signString:orderSpec];
	
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        //获取安全支付单例并调用安全支付接口
        AlixPay * alixpay = [AlixPay shared];
        int ret = [alixpay pay:orderString applicationScheme:appScheme];
        
        if (ret == kSPErrorAlipayClientNotInstalled) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"您还没有安装支付宝快捷支付，请先安装。"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alertView setTag:12345];
            [alertView show];
        }
        else if (ret == kSPErrorSignError) {
            NSLog(@"签名错误！");
        }
        
	}

}

-(void)paySuccess
{
    
    PaySuccessViewController *psv = [[PaySuccessViewController alloc] init];
    psv.order=_order;
    [self.navigationController pushViewController:psv animated:YES];

//    [UserOperation sendSMSCodeWithOrderID:[GPUserManager sharedClient].currentOrderID withblock:^(BOOL success, NSError *error) {
//   
//        
//    }];
//
}

-(void)sureorder:(id)sender
{
    
    [NetOperation OrderEnsureWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey orderid:_order.order_id phonetag:[[UIDevice currentDevice] uniqueDeviceIdentifier] withblock:^(Order *order, NSError *error) {
        if (!error) {
            if (order.status==ORDER_PENDINGALIPAY) {
                _order.needPayMoney = order.needPayMoney;
                _order.pay_id = order.pay_id;
                [GPUserManager sharedClient].currentOrderID = _order.order_id;
                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                delegate.paydelegate = self;
                [self goAlipay];
            }
            if (order.status==ORDER_SELFPAY_SUCCESS) {
                
              
//                [UserOperation sendSMSCodeWithOrderID:_order.order_id withblock:^(BOOL success, NSError *error) {
//                    
//                }];
                _order.pay_id = order.pay_id;
                PaySuccessViewController *psv = [[PaySuccessViewController alloc] init];
                psv.order=_order;
                [self.navigationController pushViewController:psv animated:YES];
            }
            if (order.status==ORDER_PAYED) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                     message:@"您已经成功付款"
                                                                    delegate:self
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                [alertView setTag:123];
                [alertView show];

            }
          
        }
    }];
      // PayViewController *pv = [[PayViewController alloc] init];
    
  //  [self.navigationController pushViewController:pv animated:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"确认支付";
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titlelb;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelbtn.frame = CGRectMake(0.0f, 0.0f, 51.0f, 32.0f);
    [cancelbtn setBackgroundImage:[UIImage imageNamed:@"nav_right_btn"] forState:UIControlStateNormal];
    [cancelbtn setTintColor:[UIColor whiteColor]];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *cl = [[UIBarButtonItem alloc] initWithCustomView:cancelbtn];
    self.navigationItem.rightBarButtonItem = cl;

    
    UIButton *bk = [UIButton buttonWithType:UIButtonTypeCustom];
    bk.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [bk setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [bk addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:bk];
    self.navigationItem.leftBarButtonItem = mp;
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==12345) {
   
        if (buttonIndex==0) {
            NSString *iTunesLink = @"http://itunes.apple.com/app/id535715926";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        }
    }
   
}

-(void)cancelAction:(id)sender
{

    [self.navigationController popToRootViewControllerAnimated:YES];

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
