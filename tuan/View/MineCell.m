//
//  MineCell.m
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.frame = CGRectMake(0.0f, 0.0f, 320.0f, 48.0f);
        self.backgroundColor = [UIColor whiteColor];
        self.coverimg = [[UIImageView alloc] initWithFrame:CGRectMake(13.0f, 13.0f, 21.0f, 21.0f)];
        self.titlelb = [[UILabel alloc] initWithFrame:CGRectMake(51.0f, 15.0f, 200.0f, 21.0f)];
        
        self.functoinlb = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 15.0f, 50.0f, 21.0f)];
        self.functoinlb.textColor = [UIColor colorWithRed:73.0f/255 green:173.0f/255 blue:206.0f/255 alpha:1.0f];
        self.functoinlb.font = [Util parseFont:24];
        
        [self.contentView addSubview:self.coverimg];
        [self.contentView addSubview:self.titlelb];
        [self.contentView addSubview:self.functoinlb];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
