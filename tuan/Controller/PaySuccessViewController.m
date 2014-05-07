//
//  PaySuccessViewController.m
//  tuan
//
//  Created by foolish on 13-5-4.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "PaySuccessViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController
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
    UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pay_seccess"]];
    imv.frame = CGRectMake(25.0f, 30.0f, 191.0f, 26.0f);
    [self.view addSubview:imv];
    
    UIView *noticev = [[UIView alloc] initWithFrame:CGRectMake(25.0f, 80.0f, 280.0f, 200.0f)];
    noticev.layer.cornerRadius = 5.0f;
    noticev.layer.borderColor = [[UIColor colorWithRed:155.0f/255.0f green:155.0f/255 blue:155.0f/255 alpha:1.0f] CGColor];
    noticev.layer.borderWidth = 1.0f;
    
    UILabel *desclb = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [desclb setNumberOfLines:0];
    UIFont *font2 = [UIFont fontWithName:@"Helvetica" size:14];
    desclb.lineBreakMode = NSLineBreakByWordWrapping;
    desclb.font = font2;
    NSString *cntt =[NSString stringWithFormat:@"您购买的商品是:%@",_order.good.product];
    CGSize size = CGSizeMake(270,2000);
    CGSize desclibsize = [cntt sizeWithFont:font2 constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    desclb.frame = CGRectMake(5.0f,5.0f,desclibsize.width,desclibsize.height);
    desclb.text = cntt;
    desclb.backgroundColor = [UIColor clearColor];
    noticev.frame = CGRectMake(25.0f, 80.0f, 280.0f,desclb.frame.size.height+10);
    [noticev addSubview:desclb];
    
    UIButton *backTop = [UIButton buttonWithType:UIButtonTypeCustom];
    backTop.frame = CGRectMake(30.0f, noticev.frame.origin.y+noticev.frame.size.height+10, 200.0f, 30.0f) ;
    [backTop setImage:[UIImage imageNamed:@"back_main"] forState:UIControlStateNormal];
    [backTop setTitleColor:[UIColor colorWithRed:3.0f/255 green:60.0f/255 blue:176.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [backTop addTarget:self action:@selector(backTop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backTop];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:noticev];
}


-(void)backTop:(UIButton *)sender
{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"成功支付";
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
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
