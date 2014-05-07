//
//  EditAddressController.m
//  tuan
//
//  Created by foolish on 13-4-29.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "EditAddressController.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import "LocalDB.h"
@interface EditAddressController ()

@end

@implementation EditAddressController

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
    lborgionpassword.text = @"收货人:";
    lborgionpassword.backgroundColor = [UIColor clearColor];
    lborgionpassword.textAlignment = NSTextAlignmentCenter;
    
    
    self.tfrealname = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 210.0f, 40.0f)];
    self.tfrealname.placeholder = @"请输入新收货人";
    self.tfrealname.borderStyle = UITextBorderStyleRoundedRect;
    self.tfrealname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfrealname.tag = 0;
    
//    //新密码
//    UILabel *lbpassword1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 68.0f, 70.0f, 30.0f)];
//    lbpassword1.text = @"电话:";
//    lbpassword1.backgroundColor = [UIColor clearColor];
//    lbpassword1.textAlignment = NSTextAlignmentCenter;
//    
//    self.tfmobile = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 68.0f, 210.0f, 40.0f)];
//    self.tfmobile.placeholder = @"请输入电话号码";
//    self.tfmobile.borderStyle = UITextBorderStyleRoundedRect;
//    self.tfmobile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    self.tfmobile.tag = 1;
//    self.tfmobile.delegate = self;
    
    
    UILabel *lbpassword2 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 68.0f, 80.0f, 30.0f)];
    lbpassword2.text = @"地址:";
    lbpassword2.backgroundColor = [UIColor clearColor];
    lbpassword2.textAlignment = NSTextAlignmentCenter;
    
    //确认新密码
    self.tfaddress = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 68.0f, 210.0f, 40.0f)];
    self.tfaddress.placeholder = @"请确认新地址";
    self.tfaddress.borderStyle = UITextBorderStyleRoundedRect;
    self.tfaddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfaddress.tag = 2;
    self.tfaddress.delegate = self;
    
     //邮编
    UILabel *lbpostcode = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 124.0f, 80.0f, 30.0f)];
    lbpostcode.text = @"邮编:";
    lbpostcode.backgroundColor = [UIColor clearColor];
    lbpostcode.textAlignment = NSTextAlignmentCenter;
    
   
    self.tfcode = [[UITextField alloc] initWithFrame:CGRectMake(90.0f, 124.0f, 210.0f, 40.0f)];
    self.tfcode.placeholder = @"新邮编";
    self.tfcode.borderStyle = UITextBorderStyleRoundedRect;
    self.tfcode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tfcode.tag = 3;
    self.tfcode.delegate = self;
    
    
    
    //go Reg
    UIButton *goReg = [UIButton buttonWithType:UIButtonTypeCustom];
    goReg.frame = CGRectMake(20.0f, 232.0f, 273.0f, 40.0f);
    [goReg setTitle:@"修改" forState:UIControlStateNormal];
    goReg.titleLabel.textColor = [UIColor whiteColor];
    [goReg addTarget:self action:@selector(changeAddress:) forControlEvents:UIControlEventTouchUpInside];
    [goReg setBackgroundImage:[UIImage imageNamed:@"reg_btn"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.tfrealname];
	//[self.view addSubview:self.tfmobile];
	[self.view addSubview:self.tfaddress];
    [self.view addSubview:self.tfcode];
	[self.view addSubview:lborgionpassword];
	//[self.view addSubview:lbpassword1];
	[self.view addSubview:lbpassword2];
    [self.view addSubview:lbpostcode];
	[self.view addSubview:goReg];
	
    
    // Do any additional setup after loading the view.
}

-(void)changeAddress:(id)sender
{
    
//    Integer userid     用户ID
//    String  userkey 密钥
//    String mobile 手机
//    String address 地址
//    String zipcode 邮编
//    String realname 真实姓名
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if (self.tfrealname.text==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收货人不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [param setObject:self.tfrealname.text forKey:@"realname"];
   // [param setObject:self.tfmobile.text forKey:@"mobile"];
    if (self.tfcode.text==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮编不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [param setObject:self.tfcode.text forKey:@"zipcode"];
    
    if (self.tfaddress.text==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收货地址不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [param setObject:self.tfaddress.text forKey:@"address"];
    [param setObject:[GPUserManager sharedClient].user.userid forKey:@"userid"];
    [param setObject:[GPUserManager sharedClient].user.userkey forKey:@"userkey"];
    [NetOperation editUserAddressWithParam:param withblock:^(BOOL success, NSError *error) {
        if (success) {
           // [GPUserManager sharedClient].user.username=self.username;
           // [LocalDB storeUserInfo:[GPUserManager sharedClient].user];
          //  NSLog(@"new user name:%@",self.tfusername.text);
            [GPUserManager sharedClient].user.zipcode = self.tfcode.text;
            [GPUserManager sharedClient].user.address = self.tfaddress.text;
            [GPUserManager sharedClient].user.realname = self.tfrealname.text;
            
            [LocalDB storeUserInfo:[GPUserManager sharedClient].user];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改成功" message:@"恭喜您，新的送货地址已修改成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;

}

-(void)viewWillAppear:(BOOL)animated
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"修改送货地址";
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
