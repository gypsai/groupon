//
//  LoadStatusView.m
//  TravelLog
//
//  Created by foolish on 13-4-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "LoadStatusView.h"

@implementation LoadStatusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews
{

    self.lbstatus = [[UILabel alloc] initWithFrame:CGRectMake(126.0f, 13.0f, 174.0f, 21.0f)];
    self.lbstatus.backgroundColor = [UIColor clearColor];
    self.lbstatus.textColor = [UIColor blackColor];
    self.lbstatus.font =[UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    
    self.activityV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityV.frame = CGRectMake(91.0f, 15.0f, 20.0f, 20.0f);

    
    [self addSubview:self.lbstatus];
    [self addSubview:self.activityV];
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
