//
//  PhoneBindViewController.h
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol bindDelegate <NSObject>

-(void)bindSuccess;
-(void)bindFailure;

@end

@interface PhoneBindViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>


@property(nonatomic,strong)UITextField *tfphonenum;
@property(nonatomic,strong)UITextField *tfcheckcode;
@property(nonatomic,assign)id<bindDelegate>delegate;

@end
