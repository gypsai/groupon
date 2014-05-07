//
//  CommentViewController.h
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *tf_comment;
@property(nonatomic,assign)NSInteger isconf;
@property(nonatomic,assign)NSInteger isback;
@property(nonatomic,strong)UIScrollView *scro;
@property(nonatomic,strong)NSString *orderid;
@property(nonatomic,strong)NSMutableDictionary *param;

@end
