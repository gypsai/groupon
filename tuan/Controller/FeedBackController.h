//
//  FeedBackController.h
//  tuan
//
//  Created by foolish on 13-5-14.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetOperation.h"

@interface FeedBackController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITextField *tftitle;
@property(nonatomic,strong)UITextField *tfcontact;
@property(nonatomic,strong)UITextField *tfmessage;
@property(nonatomic,strong)UIScrollView *scro;

@end
