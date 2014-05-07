//
//  SaleCell.m
//  tuan
//
//  Created by foolish on 13-4-2.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "SaleCell.h"

@implementation SaleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0.0f, 0.0f, 320.0f, 94.0f);
        
        self.coverimg = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 12.0f, 105.0f, 67.0f)];
        self.isnewimg = [[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 16.0f, 20.0f)];
        [self.isnewimg setImage:[UIImage imageNamed:@"new"]];
        
         self.creditlb = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 57.0f, 50.0f, 20.0f)];
        self.creditlb.backgroundColor = [UIColor redColor];
        self.creditlb.textColor = [UIColor whiteColor];
        self.creditlb.font = [Util parseFont:17.0f];
        self.creditlb.textAlignment = NSTextAlignmentCenter;
        
        
        self.titlelb = [[UILabel alloc] initWithFrame:CGRectMake(128.0f, 10.0f, 180.0f, 21.0f)];
        self.titlelb.textColor = [UIColor blackColor];
        self.titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        self.titlelb.numberOfLines = 1;
        
        self.discriplb = [[UILabel alloc] initWithFrame:CGRectMake(128.0f, 31.0f, 180.0f, 42.0f)];
        self.discriplb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        self.discriplb.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        self.discriplb.numberOfLines = 2;
        
        self.truepricelb = [[UILabel alloc] initWithFrame:CGRectMake(120.0f, 64.0f, 50.0f, 21.0f)];
        self.truepricelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        self.truepricelb.textAlignment = NSTextAlignmentRight;
        self.truepricelb.textColor = [UIColor colorWithRed:19.0f/255 green:141.0f/255 blue:208.0f/255 alpha:1.0f];
        
        UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(170.0f, 71.0f, 35.0f, 14.0f)];
        yuan.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
        yuan.text = @"元";
        yuan.textColor = [UIColor colorWithRed:19.0f/255 green:141.0f/255 blue:208.0f/255 alpha:1.0f];
        
        self.discountlb = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(185.0f, 71.0f, 50.0f, 14.0f)];
        self.discountlb.font = [UIFont fontWithName:@"Helvetica" size:9.0f];
        self.discountlb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        [self.discountlb setStrikeThroughEnabled:YES];

        self.countlb = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 71.0f, 90.0f, 17.0f)];
        self.countlb.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        self.countlb.textColor = [UIColor colorWithRed:141.0f/255 green:129.0f/255 blue:129.0f/255 alpha:1.0f];
        
        [self addSubview:self.titlelb];
        [self addSubview:self.countlb];
        [self addSubview:self.discriplb];
        [self addSubview:self.coverimg];
        [self addSubview:self.isnewimg];
        [self addSubview:yuan];
        [self addSubview:self.truepricelb];
        [self addSubview:self.discountlb];
        [self addSubview:self.creditlb];
       
        self.isnewimg.hidden = YES;
        self.creditlb.hidden = YES;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
