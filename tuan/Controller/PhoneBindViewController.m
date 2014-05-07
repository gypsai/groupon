//
//  PhoneBindViewController.m
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "PhoneBindViewController.h"
#import "NetOperation.h"
#import "UserOperation.h"
#import "GPUserManager.h"


@interface PhoneBindViewController ()

@end

@implementation PhoneBindViewController

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
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    //email 输入框
    self.tfphonenum = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 12.0f, 280.0f, 40.0f)];
    self.tfphonenum.placeholder = @"请输入手机号码";
    self.tfphonenum.borderStyle = UITextBorderStyleRoundedRect;
    self.tfphonenum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfphonenum.tag = 0;
    self.tfphonenum.delegate = self;
    
    UIButton *gecode = [UIButton buttonWithType:UIButtonTypeCustom];
    gecode.frame = CGRectMake(20.0f, 62.0f, 273.0f, 40.0f);
    [gecode setTitle:@"获取验证码" forState:UIControlStateNormal];
    gecode.titleLabel.textColor = [UIColor whiteColor];
    [gecode addTarget:self action:@selector(getSmsCode:) forControlEvents:UIControlEventTouchUpInside];
    [gecode setBackgroundImage:[UIImage imageNamed:@"reg_btn"] forState:UIControlStateNormal];
    
    UILabel *lbcheckcode = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 112.0f, 70.0f, 30.0f)];
    lbcheckcode.text = @"验证码:";
    lbcheckcode.backgroundColor = [UIColor clearColor];
    lbcheckcode.textAlignment = NSTextAlignmentCenter;
    
    
    //password输入框
    self.tfcheckcode = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 112.0f, 210.0f, 40.0f)];
    self.tfcheckcode.placeholder = @"验证码";
    self.tfcheckcode.borderStyle = UITextBorderStyleRoundedRect;
    self.tfcheckcode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfcheckcode.tag = 1;
    self.tfcheckcode.delegate = self;
    
    //sure
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(20.0f, 162.0f, 273.0f, 40.0f);
    [sure setTitle:@"绑   定" forState:UIControlStateNormal];
    sure.titleLabel.textColor = [UIColor whiteColor];
    [sure addTarget:self action:@selector(bind:) forControlEvents:UIControlEventTouchUpInside];
    [sure setBackgroundImage:[UIImage imageNamed:@"reg_btn"] forState:UIControlStateNormal];
    
    [self.view addSubview:lbcheckcode];
    [self.view addSubview:self.tfcheckcode];
    [self.view addSubview:self.tfphonenum];
    [self.view addSubview:gecode];
    [self.view addSubview:sure];
    
    
    
	// Do any additional setup after loading the view.
}

-(void)getSmsCode:(id)sender
{
    [UserOperation getSMSCodeWith:self.tfphonenum.text uid:[GPUserManager sharedClient].user.userid withblock:^(BOOL success, NSError *error) {
        if (success) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送成功" message:@"短信验证码已发送成功，请注意查收" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } ];

}

-(void)bind:(id)sender
{

    [NetOperation bindMobileWithUid:[GPUserManager sharedClient].user.userid mobile:self.tfphonenum.text secret:self.tfcheckcode.text key:[GPUserManager sharedClient].user.userkey  withblock:^(BOOL success, NSError *error) {
        
        //NSLog(@"user key:%@",[GPUserManager sharedClient].user.userkey);
        
        if (success) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"绑定成功" message:@"您已绑定成功，感谢使用！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex==0) {
        [self dismissModalViewControllerAnimated:YES];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"绑定手机";
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
    
   // [self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
