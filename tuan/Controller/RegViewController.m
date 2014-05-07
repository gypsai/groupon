//
//  RegViewController.m
//  tuan
//
//  Created by foolish on 13-4-2.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "RegViewController.h"
#import "UserOperation.h"
#import "PhoneBindViewController.h"
#import "GPUserManager.h"


@interface RegViewController ()

@end

@implementation RegViewController
@synthesize sender=_sender;

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
    
    
  
    
     UILabel *lbusername = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 12.0f, 50.0f, 30.0f)];
     lbusername.text = @"邮 箱:";
     lbusername.backgroundColor = [UIColor clearColor];
     lbusername.textAlignment = NSTextAlignmentCenter;
    
    //email 输入框
    self.tfemail = [[UITextField alloc] initWithFrame:CGRectMake(70.0f, 12.0f, 230.0f, 40.0f)];
    self.tfemail.placeholder = @"请输入邮箱";
    self.tfemail.borderStyle = UITextBorderStyleRoundedRect;
    self.tfemail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfemail.tag = 0;
    self.tfemail.delegate = self;
    

     
     UILabel *lbpassword = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 68.0f, 50.0f, 30.0f)];
     lbpassword.text = @"密 码:";
     lbpassword.backgroundColor = [UIColor clearColor];
     lbpassword.textAlignment = NSTextAlignmentCenter;
     
        
    //password输入框
    self.tfpassword = [[UITextField alloc] initWithFrame:CGRectMake(70.0f, 68.0f, 230.0f, 40.0f)];
    self.tfpassword.placeholder = @"请输入密码";
    self.tfpassword.borderStyle = UITextBorderStyleRoundedRect;
    self.tfpassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfpassword.tag = 1;
    self.tfpassword.delegate = self;
    self.tfpassword.secureTextEntry = YES;
    
    
    //go Reg
    UIButton *goReg = [UIButton buttonWithType:UIButtonTypeCustom];
    goReg.frame = CGRectMake(20.0f, 120.0f, 273.0f, 40.0f);
    [goReg setTitle:@"注  册" forState:UIControlStateNormal];
    goReg.titleLabel.textColor = [UIColor whiteColor];
    [goReg addTarget:self action:@selector(reg:) forControlEvents:UIControlEventTouchUpInside];
    [goReg setBackgroundImage:[UIImage imageNamed:@"reg_btn"] forState:UIControlStateNormal];
    
    [self.view addSubview:lbusername];
    [self.view addSubview:lbpassword];
    [self.view addSubview:self.tfemail];
    [self.view addSubview:self.tfpassword];
    [self.view addSubview:goReg];
   
	// Do any additional setup after loading the view.
}


-(void)reg:(UIButton *)sender
{
    
    [UserOperation regWithEmail:self.tfemail.text password:self.tfpassword.text withblock:^(User *user, NSError *error) {
        if (!error) {
            
            [GPUserManager sharedClient].user = user;
            PhoneBindViewController *pbv = [[PhoneBindViewController alloc] init];
            [GPUserManager sharedClient].user.email = self.tfemail.text;
            [GPUserManager sharedClient].user.password = self.tfpassword.text;
            [self.navigationController pushViewController:pbv animated:YES];
            
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[error localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        
        }
    }];

}

-(void)autoLogin
{


}

-(void)viewWillAppear:(BOOL)animated
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"注册";
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
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
