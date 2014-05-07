//
//  ChangePasswordController.m
//  tuan
//
//  Created by foolish on 13-4-21.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "ChangePasswordController.h"
#import "UserOperation.h"
#import "GPUserManager.h"
#import "LocalDB.h"
@interface ChangePasswordController ()

@end

@implementation ChangePasswordController

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
    
    //初始密码
    UILabel *lborgionpassword = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 12.0f, 70.0f, 30.0f)];
    lborgionpassword.text = @"原密码:";
    lborgionpassword.backgroundColor = [UIColor clearColor];
    lborgionpassword.textAlignment = NSTextAlignmentCenter;
    
    
    self.tforigionpwd = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 210.0f, 40.0f)];
    self.tforigionpwd.secureTextEntry = YES;
    self.tforigionpwd.placeholder = @"请输入原始密码";
    self.tforigionpwd.borderStyle = UITextBorderStyleRoundedRect;
    self.tforigionpwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tforigionpwd.tag = 0;
    self.tforigionpwd.delegate = self;
    
    //新密码
    UILabel *lbpassword1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 68.0f, 70.0f, 30.0f)];
    lbpassword1.text = @"新密码:";
    lbpassword1.backgroundColor = [UIColor clearColor];
    lbpassword1.textAlignment = NSTextAlignmentCenter;
    
    self.tfnewpwd1 = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 68.0f, 210.0f, 40.0f)];
    self.tfnewpwd1.placeholder = @"请输入新密码";
    self.tfnewpwd1.borderStyle = UITextBorderStyleRoundedRect;
    self.tfnewpwd1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfnewpwd1.tag = 1;
    self.tfnewpwd1.delegate = self;
    self.tfnewpwd1.secureTextEntry = YES;
    
    
    UILabel *lbpassword2 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 124.0f, 80.0f, 30.0f)];
    lbpassword2.text = @"确认密码:";
    lbpassword2.backgroundColor = [UIColor clearColor];
    lbpassword2.textAlignment = NSTextAlignmentCenter;
    
    //确认新密码
    self.tfnewpwd2 = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 124.0f, 210.0f, 40.0f)];
    self.tfnewpwd2.placeholder = @"请确认新密码";
    self.tfnewpwd2.borderStyle = UITextBorderStyleRoundedRect;
    self.tfnewpwd2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfnewpwd2.tag = 1;
    self.tfnewpwd2.delegate = self;
    self.tfnewpwd2.secureTextEntry = YES;
    
    
    
    //go Reg
    UIButton *goReg = [UIButton buttonWithType:UIButtonTypeCustom];
    goReg.frame = CGRectMake(20.0f, 176.0f, 273.0f, 40.0f);
    [goReg setTitle:@"修改" forState:UIControlStateNormal];
    goReg.titleLabel.textColor = [UIColor whiteColor];
    [goReg addTarget:self action:@selector(changePwd:) forControlEvents:UIControlEventTouchUpInside];
    [goReg setBackgroundImage:[UIImage imageNamed:@"reg_btn"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.tfnewpwd2];
	[self.view addSubview:self.tfnewpwd1];
	[self.view addSubview:self.tforigionpwd];
	[self.view addSubview:lborgionpassword];
	[self.view addSubview:lbpassword1];
	[self.view addSubview:lbpassword2];
	[self.view addSubview:goReg];
	
    
    // Do any additional setup after loading the view.
}

-(void)changePwd:(id)sender
{
    [UserOperation editPassword:[GPUserManager sharedClient].user.userid  oldpassword:self.tforigionpwd.text newpassword:self.tfnewpwd1.text verify:self.tfnewpwd2.text  act:nil key:[GPUserManager sharedClient].user.userkey withblock:^(BOOL success, NSString *key, NSError *error) {
        if (!error) {
            [GPUserManager sharedClient].user.userkey=key;
            [LocalDB storeUserInfo:[GPUserManager sharedClient].user];
            NSLog(@"new user key is:%@",key);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改成功" message:@"恭喜您，新密码已修改成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
    titlelb.text = @"修改密码";
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
