//
//  Util.m
//  tuan
//
//  Created by foolish on 13-4-16.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "Util.h"

@implementation Util

+(UIFont *)parseFont:(float )fontsize
{

    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontsize/2];
    
    return font;
}

+(NSDate *)parseFromString:(NSString *)date
{
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/yyy hh:mm"];
   
    NSDate *datesec = [formatter dateFromString:date];
   
   
    return datesec;
}

@end
