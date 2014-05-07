//
//  Coupon.m
//  tuan
//
//  Created by foolish on 13-4-18.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon
@synthesize exp_time=_exp_time;
@synthesize secret=_secret;
@synthesize cid=_cid;
@synthesize product=_product;
@synthesize imageurl=_imageurl;
@synthesize team_price=_team_price;
@synthesize team_id=_team_id;
@synthesize isConsumed=_isConsumed;

-(id)initFromDict:(NSDictionary *)dict
{
    self=[super init];
    if (self) {
        _exp_time = [dict objectForKey:@"expire_time_str"];
        _secret = [dict objectForKey:@"secret"];
        _cid = [dict objectForKey:@"id"];
        _product = [dict objectForKey:@"product"];
        if ([dict objectForKey:@"image"]!=[NSNull null]) {
            _imageurl = [dict objectForKey:@"image"];
            _imageurl = [IMG_PREFIX stringByAppendingFormat:@"%@",_imageurl];
            
        }
        
        _team_price=[[dict objectForKey:@"team_price"] floatValue];
        _team_id = [[dict objectForKey:@"team_id"] integerValue];
    }
    
    return self;

}

@end
