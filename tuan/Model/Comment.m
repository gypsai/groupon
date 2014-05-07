//
//  Comment.m
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "Comment.h"

@implementation Comment
@synthesize comment_content=_comment_content;
@synthesize comment_time=_comment_time;
@synthesize username=_username;

-(id)initComment:(NSDictionary *)dict
{
    self=[super init];
    if (self) {
        
        if ([dict objectForKey:@"comment_content"]==[NSNull null]) {
            _comment_content = @"暂无内容";
        }else{
            _comment_content = [dict objectForKey:@"comment_content"];
            
        }
        
        if ([dict objectForKey:@"comment_time"]==[NSNull null]) {
            _comment_time = @"未知";
        }else
        {
            _comment_time = [dict objectForKey:@"comment_time"];
            
        }
        if ([dict objectForKey:@"username"]==[NSNull null]) {
            _username = @"未知";
        }else
        {
            _username = [dict objectForKey:@"username"];
            
        }
    
        
    }
    return self;

}




@end
