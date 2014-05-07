//
//  LoginViewController.m
//  LiCaiTao
//
//  Created by foolish on 13-3-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "LoginViewController.h"
#import "GPUserManager.h"
#import "RegViewController.h"
#import "UserOperation.h"
#import "LocalDB.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    self=[super init];
    if (self) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setUI
{
   
    /*
    UILabel *lbusername = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 100.0f, 50.0f, 30.0f)];
    lbusername.text = @"用户名:";
    lbusername.backgroundColor = [UIColor clearColor];
    lbusername.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lbpassword = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 150.0f, 50.0f, 30.0f)];
    lbpassword.text = @"密 码:";
    lbpassword.backgroundColor = [UIColor clearColor];
    lbpassword.textAlignment = NSTextAlignmentCenter;
    */
    //username 输入框
    self.tfusername = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 12.0f, 273.0f, 40.0f)];
    self.tfusername.placeholder = @"   邮箱/用户名";
    self.tfusername.borderStyle = UITextBorderStyleRoundedRect;
    self.tfusername.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *lv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tf_user_icon"]];
    lv.frame = CGRectMake(0.0f, 0.0f, 16.0f, 16.0f);
    self.tfusername.leftView = lv; //self.tfpassword.clearButtonMode = UITextFieldViewModeAlways;
    self.tfusername.leftViewMode = UITextFieldViewModeAlways;
    self.tfusername.tag = 0;
    self.tfusername.delegate = self;
    
    
    //password输入框
    self.tfpassword = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 68.0f, 273.0f, 44.0f)];
    self.tfpassword.placeholder = @"   密码";
    self.tfpassword.borderStyle = UITextBorderStyleRoundedRect;
   // self.tfpassword.
    self.tfpassword.tag = 1;
    self.tfpassword.delegate = self;
    UIImageView *lp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tf_pwd_icon"]];
    lp.frame = CGRectMake(0.0f, 0.0f, 16.0f, 16.0f);
    self.tfpassword.leftViewMode = UITextFieldViewModeAlways;
    self.tfpassword.leftView = lp; 
    self.tfpassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfpassword.secureTextEntry = YES;
    
    //登录按钮
    UIButton *btnlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnlogin.frame = CGRectMake(20.0f, 119.0f, 273.0f, 40.0f);
    [btnlogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnlogin setBackgroundImage:[UIImage imageNamed:@"reg_btn"] forState:UIControlStateNormal];
    [btnlogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
   
    //GO LOGIN
    UIButton *regbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regbtn.frame = CGRectMake(219.0f, 180.0f, 82.0f, 30.0f);
    [regbtn setImage:[UIImage imageNamed:@"goregbtn"] forState:UIControlStateNormal];
    [regbtn addTarget:self action:@selector(goreg:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tfusername];
    [self.view addSubview:self.tfpassword];
    [self.view addSubview:btnlogin];
    [self.view addSubview:regbtn];
    
    
}

-(void)goreg:(id)sender
{
    RegViewController *rgv = [[RegViewController alloc] init];
    [GPUserManager sharedClient].needAutoLogin = YES;
    [self.navigationController pushViewController:rgv animated:YES];
    
}

-(void)login:(id)sender
{
    
    
    self.view.userInteractionEnabled = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [UserOperation loginWithUserName:self.tfusername.text password:self.tfpassword.text withblock:^(User *user, NSError *error) {
        
        self.view.userInteractionEnabled = YES;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (!error) {
            [LocalDB storeUserInfo:user];
            [GPUserManager sharedClient].user = user;
            [GPUserManager sharedClient].accessToken = user.userkey;
            [self dismissModalViewControllerAnimated:YES];
          //  [self.delegate loginSuccess];
        }
        else
        {
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录错误" message:@"错误!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        
        }
       
        
    }];
  
    /*
    int value = (arc4random() % 10) + 1;
    if (value<5) {
        
        [GPUserManager sharedClient].accessToken = @"valid access token";
        [GPUserManager sharedClient].user.username = @"gypsai";
        
        NSLog(@"获取到的Token为：%@",[GPUserManager sharedClient].accessToken
              );
        NSLog(@"user nick is:%@",[GPUserManager sharedClient].user.username);
        
      [self dismissModalViewControllerAnimated:YES];
      [self.delegate loginSuccess];
        
    }else
    {
    
        NSError *error = nil;
        error = [NSError errorWithDomain:@"world" code:200 userInfo:nil];
        
      //  [self.delegate login:self loginFailWihtError:&error];
    
    }*/
   
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag==1) {
        [textField resignFirstResponder];
        
        return YES;
    }
    
    return  NO;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUI];
	// Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"登录";
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
