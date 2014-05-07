//
//  LoginViewController.h
//  LiCaiTao
//
//  Created by foolish on 13-3-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@class LoginViewController;
@protocol LoginViewDelegate <NSObject>

-(void)login:(LoginViewController *)lv loginSuccessWithToken:(NSString *)token;
-(void)login:(LoginViewController *)lv loginFailWihtError:(NSError **)error;
-(void)loginSuccess;

@end

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{

   // id<LoginViewDelegate> *delegate;

}

@property(nonatomic,strong) UITextField *tfusername;
@property(nonatomic,strong) UITextField *tfpassword;
@property(nonatomic,strong) UIButton *btnautologin;
@property(nonatomic,strong) UIButton *btnremenberpwd;
@property(nonatomic,assign) id<LoginViewDelegate> delegate;

@end
