//
//  NetBase.h
//  tuan
//
//  Created by foolish on 13-4-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

#define USER_GET_SECRET_KEY @"UserAction_getSecretKey"
#define ORDER_ACTION @"OrderAction_getMyOrders"
#define ORDER_DETAIL @"TeamAction_getTeamInfoById"
#define ORDER_LIST @"TeamAction_getTeamInfoList"
#define ORDER_NEARBY_LIST @"TeamAction_getMapTeamList"
#define BIND_MOBILE @"BindAction_bindMobile"
#define GET_REGION @"CategoryAction_getRegion"
#define GET_CATGORY @"CategoryAction_getCategorys"
#define MY_COUPON @"CouponAction_getMyCouponion"
#define ADD_COLLECT @"CollectAction_addCollect"
#define COLLECT_NUM @"CollectAction_getMyCollectionCount"
#define MY_COLLECT @"CollectAction_getMyCollection"
#define NEARBY_TEAM @"TeamAction_getNearTeamList"
#define ORDER_BUY @"OrderAction_buy"
#define USER_GET_PROFILE @"UserAction_getMyAccount"
#define ORDER_CREATE @"OrderAction_submitOrder"
#define USER_EDIT_ADDRESS @"UserAction_uptAddress"
#define ORDER_ENSUERE @"OrderAction_payOrder"
#define ORDER_IF_REFUND @"OrderAction_canRefund"
#define ORDER_REFUND @"OrderAction_refund"
#define READY_PAY @"OrderAction_readyPay"
#define USER_GETUSERMONEY @"UserAction_getMyMoney"
#define USER_FEEDBACK @"FeedbackAction_suggest"
#define ORDER_REMOVE @"OrderAction_delOrder"
#define ORDER_ISCOLLECT @"CollectAction_isCollect"
#define ORDER_DECOLLECT @"CollectAction_cancelCollect"
#define ORDER_COMMENT @"OrderAction_orderComment"
#define ORDER_COUPONORDER @"OrderAction_getMyCouponOrders"
#define COUNT_INFO @"CouponAction_getCountInfo"
#define GOOD_DAILY_NEW @"TeamAction_getNewTeamInfo"
#define MAP_GET_PARTENER @"TeamAction_getPartnerTeamList"


#define TEST_SERVER_BASE @"http://api.ycss.com:8080/ycssapi/api/"
#define TEST_SERVER_BASE_DEBUG @"http://183.129.206.83:8080/ycssapi/api/"

#define PIC_PREFIX @"http://fengshui.b0.upaiyun.com"

@interface NetBase : AFHTTPClient

+(NetBase *)sharedClient;
- (id)initWithBaseURL:(NSURL *)url ;

@end
