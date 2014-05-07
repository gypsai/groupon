//
//  ConsumedCell.m
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "ConsumedCell.h"

@implementation ConsumedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Initialization code
        self.frame = CGRectMake(0.0f, 0.0f, 320.0f, 94.0f);
        
        self.coverimg = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 12.0f, 105.0f, 67.0f)];
        
        self.titlelb = [[UILabel alloc] initWithFrame:CGRectMake(128.0f, 10.0f, 160.0f, 40.0f)];
        self.titlelb.textColor = [UIColor blackColor];
        self.titlelb.numberOfLines = 2;
        self.titlelb.font = [UIFont fontWithName:@"Helvetica-bold" size:14.0f];
        
        self.desclb =  [[UILabel alloc] initWithFrame:CGRectMake(128.0f, 26.0f, 160.0f, 42.0f)];
        self.desclb.numberOfLines = 2;
        self.desclb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        self.desclb.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
        
        //总价格
        self.pricecount = [[UILabel alloc] initWithFrame:CGRectMake(120.0f, 64.0f, 120.0f, 21.0f)];
        self.pricecount.font = [UIFont fontWithName:@"Helvetica-bold" size:15.0f];
        self.pricecount.textAlignment = NSTextAlignmentLeft;
        self.pricecount.backgroundColor = [UIColor clearColor];
        self.pricecount.textColor = [UIColor colorWithRed:19.0f/255 green:141.0f/255 blue:208.0f/255 alpha:1.0f];
        
        
        //总数
        self.countlb = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 71.0f, 80.0f, 17.0f)];
        self.countlb.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        self.countlb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        
        self.lb_orderid = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, self.countlb.frame.origin.y+self.countlb.frame.size.height+15, 260.0f, 21.0f)];
        
        self.commentbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentbtn.frame = CGRectMake(17.0f, 135.0f, 143.0f, 35.0f);
        [self.commentbtn setTitle:@"评价" forState:UIControlStateNormal];
        [self.commentbtn setBackgroundImage:[UIImage imageNamed:@"btn_detail"] forState:UIControlStateNormal];
       
        self.checkbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.checkbtn.frame = CGRectMake(160.0f, 135.0f, 143.0f, 35.0f);
        [self.checkbtn setTitle:@"验证码" forState:UIControlStateNormal];
        [self.checkbtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
        
        
        [self addSubview:self.titlelb];
        [self addSubview:self.countlb];
        [self addSubview:self.coverimg];
        [self addSubview:self.truepricelb];
        [self addSubview:self.discountlb];
        [self addSubview:self.commentbtn];
        [self addSubview:self.checkbtn];
        [self addSubview:self.lb_orderid];
        [self addSubview:self.pricecount];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
