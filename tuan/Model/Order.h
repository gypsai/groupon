//
//  Order.h
//  tuan
//
//  Created by foolish on 13-4-14.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Good.h"
#import "Coupon.h"

#define ORDER_PAYED 2
#define ORDER_SELFPAY_SUCCESS 1
#define ORDER_PENDINGALIPAY 3

#define REFUNDSTATE_NORMAL 1
#define REFUNDSTATE_REFUNDING 2
@interface Order : NSObject


//booking = Y;
//"buy_id" = 0;
//"close_time" = 0;
//consume = N;
//
//"consume_time" = 0;
//"create_time" = 1348897824;
//credit = 0;
//detail = "\U8fd0\U57ce\U641c\U641c\U6d4b\U8bd5\U9879\U76ee\Uff01<br />";
//"expire_time" = 1386259200;
//"expire_time_str" = "2013\U5e7412\U670805\U65e5";
//id = 534859747996;
//image = "<null>";
//indextitle = "<null>";
//ip = "<null>";
//"market_price" = 1;
//"order_id" = 29510;
//"partner_id" = 106;
//product = "\U8fd0\U57ce\U641c\U641c\U6d4b\U8bd5";
//secret = 579494;
//sms = 8;
//"sms_time" = 1348899711;
//"subpartner_id" = 0;
//"team_id" = 143;
//"team_price" = "0.01";
//title = "\U8fd0\U57ce\U641c\U641c\U6d4b\U8bd5\U9879\U76ee\Uff01";
//type = consume;
//"user_id" = 65586;

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *secret;
@property(nonatomic,strong)NSString *expire_time_str;
@property(nonatomic,strong)NSString *team_id;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,assign)float team_price;
@property(nonatomic,assign)float market_price;
@property(nonatomic,strong)Good *good;
@property(nonatomic,strong)NSString *bind_mobile;
@property(nonatomic,assign)float usermoney;
@property(nonatomic,assign)float orderZongJia;
@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,assign)float needPayMoney;
@property(nonatomic,assign)NSInteger totalnumb;
@property(nonatomic,assign)float origin;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)BOOL canfund;
@property(nonatomic,strong)NSString *rstate;
@property(nonatomic,strong)NSMutableArray *couponlist;
@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSString *pay_id;
@property(nonatomic,assign)BOOL isComment;

-(id)initWithDict:(NSDictionary *)dict;
-(id)initFromCreate:(NSDictionary *)dict;

@end
