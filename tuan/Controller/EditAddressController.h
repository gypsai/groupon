//
//  EditAddressController.h
//  tuan
//
//  Created by foolish on 13-4-29.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddressController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITextField *tfrealname;
@property(nonatomic,strong)UITextField *tfmobile;
@property(nonatomic,strong)UITextField *tfaddress;
@property(nonatomic,strong)UITextField *tfcode;



@end
