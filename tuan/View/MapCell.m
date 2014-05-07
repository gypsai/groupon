//
//  MapCell.m
//  tuan
//
//  Created by foolish on 13-4-28.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "MapCell.h"

@implementation MapCell
@synthesize icon=_icon;
@synthesize titlelb = _titlelb;
@synthesize pricelb = _pricelb;
@synthesize btn=_btn;
@synthesize accessory=_accessory;
@synthesize discountlb=_discountlb;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(7.0f, 7.0f, 92.0f, 60.0f)];
        self.titlelb = [[UILabel alloc] initWithFrame:CGRectMake(107.0f, 7.0f, 147.0f, 40.0f)];
        self.titlelb.numberOfLines = 2;
        self.titlelb.font = [Util parseFont:24.0f];
        
        self.pricelb = [[UILabel alloc] initWithFrame:CGRectMake(107.0f, 47.0f, 50.0f, 21.0f)];
        self.pricelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        self.pricelb.textAlignment = NSTextAlignmentRight;
        [self.pricelb setBackgroundColor:[UIColor clearColor]];
        self.pricelb.textColor = [UIColor colorWithRed:19.0f/255 green:141.0f/255 blue:208.0f/255 alpha:1.0f];
        
        UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(157.0f, 55.0f, 35.0f, 14.0f)];
        yuan.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
        yuan.text = @"元";
        yuan.backgroundColor = [UIColor clearColor];
        yuan.textColor = [UIColor colorWithRed:19.0f/255 green:141.0f/255 blue:208.0f/255 alpha:1.0f];
        
        self.discountlb = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(172.0f, 55.0f, 35.0f, 14.0f)];
        self.discountlb.font = [UIFont fontWithName:@"Helvetica" size:9.0f];
        self.discountlb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        self.discountlb.backgroundColor = [UIColor clearColor];
        [self.discountlb setStrikeThroughEnabled:YES];
        

        
        self.accessory = [[UIImageView alloc] initWithFrame:CGRectMake(255.0f, 27.0f, 14.0f, 19.0f)];
        [self.accessory setImage:[UIImage imageNamed:@"map_accessory"]];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = self.frame;
        
        [self addSubview:self.icon];
        [self addSubview:self.titlelb];
        [self addSubview:self.pricelb];
        [self addSubview:self.discountlb];
        [self addSubview:yuan];
        [self addSubview:self.accessory];
        [self addSubview:self.btn];
        
    }
    return self;
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
