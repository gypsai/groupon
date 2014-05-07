//
//  ChangeNickController.h
//  tuan
//
//  Created by foolish on 13-4-21.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeNickDelegate <NSObject>

-(void)changeSuccess;

@end

@interface ChangeNickController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITextField *tfusername;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,assign)id<ChangeNickDelegate>delegate;

@end
