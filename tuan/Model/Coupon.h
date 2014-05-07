//
//  Coupon.h
//  tuan
//
//  Created by foolish on 13-4-18.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Good.h"

@interface Coupon : NSObject

//booking = "<null>";
//"buy_id" = 1;
//"close_time" = 0;
//consume = N;
//"consume_time" = 0;
//"create_time" = 1367679226;
//credit = 0;
//detail = "<null>";
//"expire_time" = 1368979200;
//"expire_time_str" = "2013\U5e7405\U670819";
//id = 110973958287;
//image = "<null>";
//indextitle = "<null>";
//ip = "<null>";
//"market_price" = 0;
//"order_id" = 62050;
//"partner_id" = 572;
//product = "<null>";
//secret = 523548;
//sms = 0;
//"sms_time" = 0;
//"subpartner_id" = 0;
//"team_id" = 1391;
//"team_price" = 0;
//title = "<null>";
//type = consume;
//"user_id" = 65626;

@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *exp_time;
@property(nonatomic,strong)NSString *secret;
@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSString *imageurl;
@property(nonatomic,assign)float team_price;
@property(nonatomic,assign)NSInteger team_id;
@property(nonatomic,assign)BOOL isConsumed;

-(id)initFromDict:(NSDictionary *)dict;

@end
