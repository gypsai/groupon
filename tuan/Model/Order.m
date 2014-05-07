//
//  Order.m
//  tuan
//
//  Created by foolish on 13-4-14.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "Order.h"

@implementation Order

@synthesize title=_title;
@synthesize detail=_detail;
@synthesize image=_image;
@synthesize secret=_secret;
@synthesize expire_time_str=_expire_time_str;
@synthesize team_price=_team_price;
@synthesize team_id=_team_id;
@synthesize market_price=_market_price;
@synthesize user_id=_user_id;
@synthesize good=_good;
@synthesize bind_mobile=_bind_mobile;
@synthesize usermoney=_usermoney;
@synthesize order_id=_order_id;
@synthesize orderZongJia=_orderZongJia;
@synthesize needPayMoney=_needPayMoney;
@synthesize totalnumb=_totalnumb;
@synthesize origin=_origin;
@synthesize status=_status;
@synthesize canfund=_canfund;
@synthesize rstate=_rstate;
@synthesize couponlist=_couponlist;
@synthesize product=_product;
@synthesize pay_id=_pay_id;
@synthesize isComment=_isComment;

-(id)initWithDict:(NSDictionary *)dict
{

    self = [super init];
    if (self) {
        
        [self parseOrderInfo:dict];
        
    }
    
    return self;

}

-(void)parseOrderInfo:(NSDictionary *)dict
{
    
    _team_id = [dict objectForKey:@"team_id"];
    _title = [dict objectForKey:@"title"];
    _detail = [dict objectForKey:@"detail"];
    _image = [dict objectForKey:@"image"];
    _secret = [dict objectForKey:@"secret"];
    _expire_time_str = [dict objectForKey:@"expire_time_str"];
    _team_price = [[dict objectForKey:@"team_price"] floatValue];
    _market_price = [[dict objectForKey:@"market_price"] floatValue];
    _user_id = [dict objectForKey:@"user_id"];
    _needPayMoney = [[dict objectForKey:@"needPayMoney"] floatValue];
    _order_id = [dict objectForKey:@"id"];
    _totalnumb = [[dict objectForKey:@"quantity"] integerValue];
    _origin = [[dict objectForKey:@"origin"] floatValue];
    NSString *crf = [NSString stringWithFormat:@"%@",[dict objectForKey:@"canfund"]];
    if ([crf  isEqualToString:@"Y"]) {
        _canfund = YES;
    }
    if ([crf  isEqualToString:@"N"]) {
        _canfund = NO;
    }
   
    
    _pay_id = [dict objectForKey:@"pay_id"];
    _product=[dict objectForKey:@"product"];
    _rstate = [NSString stringWithFormat:@"%@",[dict objectForKey:@"rstate"]];
   
    NSLog(@"result is:%@,%@,%@",_product,_order_id,crf);
    
    NSArray *cp = [dict objectForKey:@"couponlist"];
    _couponlist = [[NSMutableArray alloc] init];
    for(NSDictionary *cplist in cp)
    {
        Coupon *coupon = [[Coupon alloc] initFromDict:cplist];
        [_couponlist addObject:coupon ];
    }
    NSString *commentstr;
    if ([dict objectForKey:@"isCommented"]!=[NSNull null]) {
        commentstr = [dict objectForKey:@"isCommented"];
    }else
    {
        commentstr = @"Y";
    }
    if([commentstr isEqualToString:@"Y"])
    {
        _isComment = YES;
    }else
    {
        _isComment = NO;
    }
    
    
}

-(id)initFromCreate:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        _orderZongJia = [[dict objectForKey:@"orderZongJia"] floatValue];
        _usermoney = [[dict objectForKey:@"usermoney"] floatValue];
        
        NSDictionary *orderinfo = [dict objectForKey:@"orderinfo"];
        _good=[[Good alloc] initWithDic:orderinfo];
        [self parseOrderInfo:orderinfo];
        
    }
    
    return self;

}

@end
