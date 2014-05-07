//
//  GCell.m
//  tuan
//
//  Created by foolish on 13-4-5.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "GCell.h"

@implementation GCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)init {
	
    if (self = [super init]) {
		
      //  self.frame = CGRectMake(0, 0, 86.0f, 35.0f);
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 86.0f, 35.0f)];
        lb.center = self.center;
        lb.text = @"电影";
        [self addSubview:lb];
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
