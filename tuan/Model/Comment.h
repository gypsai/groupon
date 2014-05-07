//
//  Comment.h
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property(nonatomic,strong)NSString *comment_content;
@property(nonatomic,strong)NSString *comment_time;
@property(nonatomic,strong)NSString *username;

-(id)initComment:(NSDictionary *)dict;
@end
