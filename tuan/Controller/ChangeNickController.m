//
//  ChangeNickController.m
//  tuan
//
//  Created by foolish on 13-4-21.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "ChangeNickController.h"
#import "UserOperation.h"
#import "GPUserManager.h"
#import "LocalDB.h"

@interface ChangeNickController ()

@end

@implementation ChangeNickController
@synthesize username=_username;
@synthesize delegate=_delegate;

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //username 输入框
    self.tfusername = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 12.0f, 273.0f, 40.0f)];
    self.tfusername.placeholder = self.username;
    self.tfusername.borderStyle = UITextBorderStyleRoundedRect;
    self.tfusername.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfusername.tag = 0;
    self.tfusername.delegate = self;
    
    //登录按钮
    UIButton *btnlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnlogin.frame = CGRectMake(20.0f, 70.0f, 273.0f, 40.0f);
    [btnlogin setTitle:@"修改" forState:UIControlStateNormal];
    [btnlogin setBackgroundImage:[UIImage imageNamed:@"reg_btn"] forState:UIControlStateNormal];
    [btnlogin addTarget:self action:@selector(changeusername:) forControlEvents:UIControlEventTouchUpInside];
    

    [self.view addSubview:self.tfusername];
    [self.view addSubview:btnlogin];
	// Do any additional setup after loading the view.
}

-(void)changeusername:(id)sender
{
    
    self.username = self.tfusername.text;
    
    [UserOperation editUserName:[GPUserManager sharedClient].user.userid username:self.username act:nil key:[GPUserManager sharedClient].user.userkey withblock:^(BOOL success, NSError *error) {
        if (success) {
            [GPUserManager sharedClient].user.username=self.username;
            [LocalDB storeUserInfo:[GPUserManager sharedClient].user];
            NSLog(@"new user name:%@",self.tfusername.text);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改成功" message:@"恭喜您，新用户名已修改成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 0;
            [alert show];
            
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改失败" message:@"修改失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 1;
            [alert show];
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==0) {
        [self.delegate changeSuccess];
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void)viewWillAppear:(BOOL)animated
{

    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"修改用户名";
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
