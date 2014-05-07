//
//  PayedCell.m
//  tuan
//
//  Created by foolish on 13-4-20.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "PayedCell.h"

@implementation PayedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       // self.frame = CGRectMake(0.0f, 0.0f, 320.0f, 94.0f);
        
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
        
        self.discountlb = [[UILabel alloc] initWithFrame:CGRectMake(170.0f, 71.0f, 35.0f, 14.0f)];
        self.discountlb.font = [UIFont fontWithName:@"Helvetica" size:9.0f];
        self.discountlb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        
        //总数
        self.countlb = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 71.0f, 80.0f, 17.0f)];
        self.countlb.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        self.countlb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        
        self.secrettitle = [[UILabel alloc] initWithFrame:CGRectMake(32.0f, 84.0f, 56.0f, 21.0f)];
        self.secrettitle.font = [Util parseFont:25.0f];
        self.secrettitle.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        self.secrettitle.text = @"验证码";
        
        self.secret = [[UILabel alloc] initWithFrame:CGRectMake(32.0f, 105.0f, 56.0f, 21.0f)];
        self.secret.font = [Util parseFont:20];
        self.secret.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        
        self.expiretitle = [[UILabel alloc] initWithFrame:CGRectMake(124.0f, 84.0f, 94.0f, 21.0f)];
        self.expiretitle.font = [Util parseFont:25.0f];
        self.expiretitle.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        self.expiretitle.text = @"有效期";
        
       
        self.expirelb = [[UILabel alloc] initWithFrame:CGRectMake(124.0f, 105.0f, 280.0f, 21.0f)];
        self.expirelb.font = [Util parseFont:20];
        self.expirelb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        
//        self.btndetail = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.btndetail.frame = CGRectMake(16.0f, 110.0f, 143.0f, 35.0f);
//        [self.btndetail setTitle:@"订单详情" forState:UIControlStateNormal];
//        [self.btndetail setBackgroundImage:[UIImage imageNamed:@"btn_detail"] forState:UIControlStateNormal];
//        
        self.btnreturn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnreturn.frame = CGRectMake(16.0f, 131.0f, 286.0f, 35.0f);
        [self.btnreturn setTitle:@"申请退款" forState:UIControlStateNormal];
        [self.btnreturn setBackgroundImage:[UIImage imageNamed:@"pay_btn"] forState:UIControlStateNormal];
        
        
        [self addSubview:self.titlelb];
        [self addSubview:self.countlb];
        //[self addSubview:self.desclb];
        [self addSubview:self.coverimg];
        [self addSubview:self.pricecount];
        //[self addSubview:self.discountlb];
        //[self addSubview:self.secret];
        [self addSubview:self.secrettitle];
        //[self addSubview:self.btndetail];
        //[self addSubview:self.btnreturn];
        //[self addSubview:self.expirelb];
        [self addSubview:self.expiretitle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
