//
//  ChangePasswordController.h
//  tuan
//
//  Created by foolish on 13-4-21.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITextField *tforigionpwd;
@property(nonatomic,strong)UITextField *tfnewpwd1;
@property(nonatomic,strong)UITextField *tfnewpwd2;

@end
