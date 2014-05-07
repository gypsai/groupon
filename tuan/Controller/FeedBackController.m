//
//  FeedBackController.m
//  tuan
//
//  Created by foolish on 13-5-14.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "FeedBackController.h"
#import "GPUserManager.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "RegViewController.h"
@interface FeedBackController ()

@end

@implementation FeedBackController

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
    
    UIImageView *imge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"feedback_bg"]];
    imge.frame = CGRectMake(0.0f, 0.0f, 320.0f, 368.0f);
   
    
    self.tftitle = [[UITextField alloc] initWithFrame:CGRectMake(85.0f, 146.0f, 226.0f, 30.0f)];
    self.tftitle.borderStyle = UITextBorderStyleLine;
    self.tftitle.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tftitle.tag = 0;
    self.tftitle.layer.borderColor = [[UIColor colorWithRed:160.0f/255 green:160.0f/255 blue:160.0f/255 alpha:1.0f] CGColor];
    self.tftitle.delegate = self;
    
    self.tfcontact = [[UITextField alloc] initWithFrame:CGRectMake(85.0f, 211.0f, 226.0f, 30.0f)];
    self.tfcontact.borderStyle = UITextBorderStyleLine;
    self.tfcontact.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfcontact.tag = 1;
    self.tfcontact.layer.borderColor = [[UIColor colorWithRed:160.0f/255 green:160.0f/255 blue:160.0f/255 alpha:1.0f] CGColor];
    self.tfcontact.delegate = self;
    
    self.tfmessage = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 311.0f, 283.0f, 30.0f)];
    self.tfmessage.borderStyle = UITextBorderStyleLine;
    self.tfmessage.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfmessage.tag = 2;
    self.tfmessage.layer.borderColor = [[UIColor colorWithRed:160.0f/255 green:160.0f/255 blue:160.0f/255 alpha:1.0f] CGColor];
    self.tfmessage.delegate = self;
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(242.0f, 360.0f, 63.0f, 31.0f);
    [submit setImage:[UIImage imageNamed:@"sub_feedback"] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.scro = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    self.view.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    self.scro.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    
    [self.scro addSubview:imge];
    [self.scro addSubview:self.tftitle];
    [self.scro addSubview:self.tfcontact];
    [self.scro addSubview:self.tfmessage];
    [self.scro addSubview:submit];
    
    [self.view addSubview:self.scro];
    
    
	// Do any additional setup after loading the view.
}

-(void)subAction:(id)sender
{
    
    if (self.tftitle.text==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的称呼！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
        
    }
    if (self.tfcontact.text==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的联系方式！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
        
    }
    if (self.tfmessage.text==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的反馈意见！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
        
    }
    
    if ([[GPUserManager sharedClient] isLogin]) {
        [SVProgressHUD show];
        [NetOperation feedbackWithUID:[GPUserManager sharedClient].user.userid title:self.tftitle.text contact:self.tfmessage.text message:self.tfcontact.text withblock:^(BOOL success, NSError *error) {
            [SVProgressHUD dismiss];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"感谢您的意见，我们将努力做得更好！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }];
        
    }else
    {
        [SVProgressHUD show];
        [NetOperation feedbackWithUID:@"0" title:self.tftitle.text contact:self.tfmessage.text message:self.tfcontact.text withblock:^(BOOL success, NSError *error) {
            [SVProgressHUD dismiss];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"感谢您的意见，我们将努力做得更好！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }];
    }
 
    
    
  

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11111) {
  
        if (buttonIndex==0) {
            LoginViewController *loginv = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginv];
            
            [self presentViewController:nav animated:YES completion:^{
                
                
            }];
        }
        if (buttonIndex==1) {
            
            RegViewController *regv = [[RegViewController alloc] init];
            [GPUserManager sharedClient].needAutoLogin = YES;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:regv];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
  
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        CGSize size= self.scro.contentSize;
        size.height +=300;
        
        self.scro.contentSize = size;
        self.scro.contentOffset = CGPointMake(0.0f, size.height-200);
    }
    if (textField.tag==2) {
        CGSize size= self.scro.contentSize;
        size.height +=500;
        
        self.scro.contentSize = size;
        self.scro.contentOffset = CGPointMake(0.0f, size.height-300);
    }

    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        CGSize size= self.scro.contentSize;
        size.height -=300;
        self.scro.contentSize = size;
    }
    if (textField.tag==2) {
        CGSize size= self.scro.contentSize;
        size.height -=500;
        self.scro.contentSize = size;
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    [textField resignFirstResponder];
    return YES;
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if (textField.tag==1) {
//        CGSize size= self.scro.contentSize;
//        size.height -=300;
//        self.scro.contentSize = size;
//    }
//    if (textField.tag==2) {
//        CGSize size= self.scro.contentSize;
//        size.height -=500;
//        self.scro.contentSize = size;
//    }
//    
//}

-(void)viewWillAppear:(BOOL)animated
{
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"意见反馈";
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
