//
//  GPSelectView.m
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "GPSelectView.h"
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.3

@implementation GPSelectView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (id)initWithTitle:(NSString *)title  data:(NSArray *)ldata delegate:(id /*<UIActionSheetDelegate>*/)delegate
{
    self =  [super initWithTitle:nil
                        delegate:nil
               cancelButtonTitle:nil
          destructiveButtonTitle:nil
               otherButtonTitles:nil];

    self.frame = CGRectMake(0.0f, 0.0f, 320.0f, 260.0f);
    
    UIView *titleview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 11.0f, 320.0f, 21.0f)];
    titlelabel.text = title;

    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelbtn.frame = CGRectMake(10.0f, 1.0f, 42.0f, 42.0f);
    
    
    UIButton *surebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    surebtn.frame = CGRectMake(268.0f, 1.0f, 42.0f, 42.0f);
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 216.0f)];
    //picker.delegate=delegate;
    
    [self addSubview:titleview];
    [self addSubview:titlelabel];
    [self addSubview:cancelbtn];
    [self addSubview:surebtn];
    [self addSubview:picker];
    
    
    return  self;
    
}

- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
