//
//  RegViewController.h
//  tuan
//
//  Created by foolish on 13-4-2.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegDelegate <NSObject>

-(void)regSuccess;
-(void)regFailure;

@end

@interface RegViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *tfemail;
@property(nonatomic,strong)UITextField *tfpassword;
@property(nonatomic,strong)UITextField *tfphonenum;
@property(nonatomic,assign)id<RegDelegate>delegate;
@property(nonatomic,strong)id sender;

@end
