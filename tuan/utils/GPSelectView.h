//
//  GPSelectView.h
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPSelectView : UIActionSheet<UIPickerViewDataSource,UIPickerViewDelegate>


- (id)initWithTitle:(NSString *)title  data:(NSArray *)ldata delegate:(id /*<UIActionSheetDelegate>*/)delegate;

//- (void)showInView:(UIView *)view;

@end
