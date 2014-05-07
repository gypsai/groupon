//
//  CommentCell.m
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.lb_user = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 250.0f, 21.0f)];
        self.lb_user.textColor = [UIColor redColor];
        self.lb_user.font = [UIFont fontWithName:@"Helvetica" size:15];
        
        self.lb_content = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 36.0f, 260.0f, 21.0f)];
        self.lb_content.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        self.lb_time = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 62.0f, 260.0f, 21.0f)];
        self.lb_time.font = [UIFont fontWithName:@"Helvetica" size:15];
       // self.lb_time.textColor = [UIColor colorWithRed:144.0f green:144.0f blue:144.0f alpha:1.0f];
        self.lb_time.textColor = [UIColor grayColor];
        
        
        self.lb_user.backgroundColor = [UIColor clearColor];
        self.lb_content.backgroundColor = [UIColor clearColor];
        self.lb_time.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.lb_user];
        [self.contentView  addSubview:self.lb_content];
        [self.contentView addSubview:self.lb_time];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
