//
//  NetOperation.h
//  tuan
//
//  Created by foolish on 13-4-14.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetBase.h"
#import "Order.h"
#import "Good.h"
#import "User.h"


#define PAYED 2
#define UNPAY 1
#define RETURN 3
#define ALLORDER 4
#define CONSUMED 1
#define UNCONSUMED 0
#define ALL_COUPON 3


@interface NetOperation : NSObject



//Integer userid  用户ID
//String  userkey 密钥
//Integer type    用来区分订单的类型：1-未付款；2-已付款；3-申请退款
//Integer offset  Mysql的limit起始位置
//Integer size    一次取得最大记录数
//返回结果：
//失败：{"code":"错误代码"}
//-1：用户ID不能为空；
//-10：密钥为空；
//-11：密钥错误；
//成功：

+(void)getUserOrderWithUID:(NSString *)uid userkey:(NSString *)userkey type:(NSInteger )type offset:(NSInteger)offset size:(NSInteger)size withblock:(void(^)(NSArray *orders,NSError *error))block;


//收货地址管理
//请求地址
//api/UserAction_uptAddress
//请求方式post
//参数
//Integer userid     用户ID
//String  userkey 密钥
//String mobile 手机
//String address 地址
//String zipcode 邮编
//String realname 真实姓名
//返回结果：
//失败：{"code":"错误代码"}
//-1：用户ID不能为空；
//-10：密钥为空；
//-11：密钥错误;
//0: 服务器错误
//成功 {"code":1,result:"修改成功"}
//
//说明，收货地址不能够为空

+(void)editUserAddressWithParam:(NSDictionary *)param withblock:(void(^)(BOOL success,NSError *error))block;

//请求地址：
//api/UserAction_getMyAccount
//请求方式：POST
//传递参数：
//Integer userid     用户ID
//String  userkey    密钥
//
//返回结果：
//失败：{"result":null,"code":"错误代码"}
//-1：userid不能为空；
//0：user信息不存在;

+(void)getMyAccountWithUid:(NSString *)userid userkey:(NSString *)userkey withblock:(void(^)(User *user,NSError *error))block;

//失败：{"code":"错误代码", "result":"null"}
//0：有异常
//-1：团购项目ID不能为空
//-2：用户ID不能为空
//-3：团购项目不存在或已删除
//-4：未绑定手机号，无法购买
//-5：该团购一个用户只允许购买一次，你已成功购买过
//-6：您购买本单产品的数量已经达到上限
//-8: 抽奖活动暂不支持
//-10：密钥为空；
//-11：密钥错误；
+(void)getGoodDetailByID:(NSString *)oid lat:(NSInteger)lat lng:(NSInteger)lng withblock:(void(^)(Good *good , NSError *error))block;


//TeamAction_getTeamInfoList
//请求方式POST
//参数
//index=#开始ID#
//size=#条数#
//title=#搜索条件#
//orderType=#排序方式# --0默认排序 1人们 2折扣 3价格
//subId=#子分类ID#
//groupId=#父分类ID#  -- 子分类ID和父分类ID两个参数不会同时存在
//cityId=#区域ID#
//partnerId=#商家ID#  -- 获取某个商家下边的团购信息

+(void)getGoodListWithParam:(NSDictionary *)param withblock:(void(^)(NSArray *orderlist,
                                                                      NSError *error))block;


//
//TeamAction_getMapTeamList
//请求方式GET
//参数
//lat=#纬度# --百度地图取到的值*e6
//lng=#经度# --度地图取到的值*e6
//index=#起始值#    --开始
//size=#大小#  --默认在地图上返回100个商家的最后团购信息，周边团购根据客户端传入值决定
//title=#搜索条件# --暂时不需要用到，扩展用
//subId=#子分类ID# --暂时不需要用到，扩展用
//groupId=#父分类ID#  -- 子分类ID和父分类ID两个参数不会同时存在 --暂时不需要用到，扩展用
//cityId=#区域ID# --暂时不需要用到，扩展用
//partnerId=#商家ID#  -- 获取某个商家下边的团购信息 --暂时不需要用到，扩展用

+(void)getMapGoodWithParam:(NSDictionary *)param withblock:(void(^)(NSArray *orderlist,
                                                                        NSError *error))block;


//TeamAction_getNearTeamList
//请求方式GET
//参数
//index=#开始数#
//size=#总数#
//lat=#纬度#
//lng=#经度#

+(void)getNearByTeamListWithParam:(NSMutableDictionary *)param withblock :(void(^)(NSArray *orderlist,NSError *error))block;

//请求地址：
//api/BindAction_bindMobile
//请求方式：POST
//传递参数：
//Integer userid     用户ID
//String  mobile     手机号
//String  secret     短息验证码
//返回结果：
//成功：{"code":"1", "result":"null"}
//失败：{"code":"错误代码", "result":"null"}
//0：有异常
//-1：用户ID不能为空
//-2：手机号不能为空
//-3：请输入短信验证码
//-4：非法访问（绑定信息不存在）
//-5：短信验证码错误

+(void)bindMobileWithUid:(NSString *)userid mobile:(NSString *)mobile secret:(NSString *)secret key:(NSString *)userkey withblock:(void(^)(BOOL success,NSError *error))block;

+(void)getRegion:(void(^)(NSArray *reg,NSError *error))block;

+(void)getAllCatgoryWithCityID:(NSString *)cityid withblock:(void(^)(NSArray *cat,NSError *error))block;

//传递参数：
//Integer uid     用户ID
//String  userkey 密钥
//Integer offset  Mysql的limit起始位置
//Integer size    一次取得最大记录数
//返回结果：
//失败：{"code":"错误代码"}
//-1：用户ID不能为空；
//-10：密钥为空；
//-11：密钥错误；
//成功：

+(void)getMyCouponWithUid:(NSString *)uid key:(NSString *)userkey isused:(NSInteger )issued index:(NSInteger )offset size:(NSInteger)size withblock:(void(^)(NSArray *couplist,NSError *error))block;

//传递参数：
//Integer uid        用户ID
//String  userkey    密钥
//Integer teamid     团购ID
//
//返回结果：
//失败：{"result":null,"code":"错误代码"}
//-1：  userid不能为空；
//-2:  团购ID为空；
//-3：  已收藏过此团购信息；
//-10：密钥为空；
//-11：密钥错误；
//
//成功：{"result":null,"code":1}
+(void)addCollectWithUid:(NSString *)uid key:(NSString *)userkey teamid:(NSInteger)teamid withblock:(void(^)(BOOL success,NSError *error))block;

//请求地址：
//api/CollectAction_getMyCollectionCount
//请求方式：POST
//传递参数：
//Integer uid        用户ID
//String  userkey    密钥
//
//返回结果：
//失败：{"result":null,"code":"错误代码"}
//0: 异常
//-1：  userid不能为空；
//-10：密钥为空；
//-11：密钥错误；
//
//成功：{"result":3,"code":1}

+(void)getMyCollectNumberWithUid:(NSString *)uid key:(NSString *)userkey withblock:(void(^)(NSInteger number,NSError *error))block;

//请求地址：
//api/CollectAction_getMyCollection
//请求方式：POST
//传递参数：
//Integer uid        用户ID
//String  userkey    密钥
//Integer offset     Mysql的limit起始位置
//Integer size       一次取得最大记录数
//
//返回结果：
//失败：{"result":null,"code":"错误代码"}
//-1：  userid不能为空；
//-10：密钥为空；
//-11：密钥错误；
+(void)getMyCollectWithUid:(NSString *)uid key:(NSString *)userkey offset:(NSInteger)offset size:(NSInteger)size withblock:(void (^)(NSArray *rest, NSError *))block;

//获取应用的version
+(void)getVersionWithBlock:(void(^)(NSString *version,NSError *error))block;

//----------------------------------
//--参团API
//----------------------------------
//返回值中重要字段说明：
//team_id       团购项目ID
//title         团购项目标题
//product       团购商品标题
//team_price    团购价格
//market_price  市场价格
//now_number    已有多少人购买（已付款的）
//max_number    允许购买的最高数量， 0-表示没有最高上限
//per_number    每人限购    0-表示没不限购
//permin_number 单次最少购买数量，最少1件
//delivery     配送方式 "coupon"-验证码； "express"-快递
//farefree;    免运费数量；-1免运费；0-不免运费；大于0-如1购买1件免运费,以此类推
//"express_list": { //团购支持的快递列表
//    "0": {
//        "id": "35",          快递分类的ID
//        "price": "15",       运费
//        "name": "圆通快递"    快递名称
//    }
//}
+(void)OrderBuyWithUid:(NSString *)uid userkey:(NSString *)userkey teamid:(NSInteger)teamid withblock:(void(^)(Order *order , NSError *error))block;

//请求地址：
//api/OrderAction_submitOrder
//请求方式：POST
//传递参数：
//Integer userid     用户ID
//String  userkey    密钥
//String  teamid     团购项目ID
//Integer buyCount   购买数量
//Integer express_id 快递ID   //不是快递类型就传0
//String  shouhuoren 收货人        //不是快递类型就不传
//String  zipcode    邮编             //不是快递类型就不传
//String  shaddress  收货地址   //不是快递类型就不传
//String  express_xx 送货时间   //不是快递类型就不传
//String  mobile     手机号
//String  referer    订单来源    ios / android
//String  remark     留言

+(void)CreateOrderWithParam:(NSDictionary *)param withblock:(void(^)(Order *order,NSError *error))block;

//请求地址：
//api/OrderAction_payOrder
//请求方式：POST
//传递参数：
//Integer userid     用户ID
//String  userkey    密钥
//Integer orderid    订单ID
+(void)OrderEnsureWithUID:(NSString *)userid userkey:(NSString *)userkey orderid:(NSString *)orderid phonetag:(NSString *)phonetag withblock:(void(^)(Order *order,NSError *error))block;

//请求地址：
//api/OrderAction_canRefund
//请求方式：POST
//传递参数：
//Integer orderid    订单ID
//
//返回结果：
//无法退款：{"code":"错误代码", "result":"null"}
//0：有异常
//-1：订单ID不能为空
//-2：订单信息不存在或已删除
//-3: 无法申请退款
//
//可以退款：{"code":"1", "result":"..."}
+(void)OrderCanRefundWithOrderID:(NSString *)orderid withblock:(void(^)(Order *order,NSError *error))block;

//----------------------------------
//--申请退款
////----------------------------------
//请求地址：
//api/OrderAction_refund
//请求方式：POST
//传递参数：
//Integer userid     用户ID
//String  userkey    密钥
//Integer orderid    订单ID
//String  rreason    退款原因
//
//返回结果：
//失败：{"code":"错误代码", "result":"null"}
//0：有异常
//-1：用户ID不能为空
//-2：用户信息不存在或已删除
//-3: 订单ID不能为空
//-4：订单信息不存在或已删除
//-5：无法申请退款
//
//成功：{"code":"1", "result":"null"}
+(void)OrderRefundWithUID:(NSString *)userid userkey:(NSString *)userkey orderid:(NSString *)orderid reason:(NSString *)rreason withblock:(void(^)(BOOL success,NSError *error))block;

//
//请求地址：
//api/OrderAction_readyPay
//请求方式：POST
//传递参数：
//Integer userid     用户ID
//String  userkey    密钥
//Integer orderid    订单ID
//返回结果：
//失败：{"code":"错误代码", "result":"null"}
//0：有异常
//-1：用户ID不能为空
//-2：用户信息为空
//-3：订单ID为空
//-4：订单信息不存在
//-5：团购信息不存在或已删除
//-6：当前用户 达到限制购买数量，无法继续购买
//-7：团购项目已关闭
//-10：密钥为空；
//-11：密钥错误；
//成功：{"code":"2", "result":"null"} --已经支付过了，无需再次支付
//需要支付：

+(void)ReadyPayWithUID:(NSString *)userid userkey:(NSString *)userkey orderid:(NSString *)orderid withblock:(void(^)(Order *order,NSError *error))block;

////----------------------------------
////-我的账户余额
////----------------------------------
//请求地址：
//api/UserAction_getMyMoney
//请求方式：POST
//传递参数：
//Integer userid     用户ID
//String  userkey    密钥
//
//返回结果：
//失败：{"result":null,"code":"错误代码"}
//-1：userid不能为空；
//0：user信息不存在;
//-10：密钥为空；
//-11：密钥错误；
//成功：{"result":20.0,"code":1}

+(void)getUserMoneyWithUID:(NSString *)userid userkdy:(NSString *)userkey withblock:(void(^)(float money ,NSError *error))block;

//----------------------------------
//--意见反馈
//----------------------------------
//请求地址：
//api/FeedbackAction_suggest
//请求方式：POST
//传递参数：
//Integer userid  用户ID（有登录就传，没有就不传或者传0）
//String  title   您的称呼
//String  contact 联系方式
//String  message 内容
//
//返回结果：
//失败：{"code":"错误代码"}
//0：异常;
//-1：您的称呼不能为空；
//-2：联系方式不能为空；
//-3：内容不能为空；
//成功：{"code":1, result:null}

+(void)feedbackWithUID:(NSString *)userid title:(NSString *)title contact:(NSString *)contact message:(NSString *)message withblock:(void(^)(BOOL success,NSError *error))block;


//请求地址：
//api/OrderAction_delOrder
//请求方式：POST
//传递参数：
//Integer userid     用户ID
//String  userkey    密钥
//String  orderid    订单ID
//
//返回结果：
//失败：{"code":"错误代码", "result":"null"}
//0：有异常
//-1：userid不能为空
//-2：orderid不能为空
//-3：订单信息不存在或已删除
//-4：此订单不是未付款订单，不能删除
//-5：您没有权利删除他人订单
//-10：密钥不能为空；
//-11：密钥错误；
//
//成功：{"code": 1, "result":"null"}
+(void)removeOrderWithUID:(NSString *)userid userkey:(NSString *)userkey orderid:(NSString *)orderid  withblock:(void(^)(BOOL success,NSError *error))block;

////----------------------------------
////-是否已收藏
////----------------------------------
//请求地址：
//api/CollectAction_isCollect
//请求方式：POST
//传递参数：
//Integer uid        用户ID
//Integer teamid     团购ID
//
//返回结果：
//失败：{"result":null,"code":"错误代码"}
//-1：  uid不能为空；
//-2:  团购ID为空；
//0:  异常;
//
//成功： {"result":1,"code":1} -- 已收藏
//{"result":0,"code":1} -- 未收藏
+(void)isCollectUID:(NSString *)uid teamid:(NSString *)teamid withblock:(void(^)(BOOL success,NSError *error))block;



////----------------------------------
////-取消收藏
////----------------------------------
//请求地址：
//api/CollectAction_cancelCollect
//请求方式：POST
//传递参数：
//Integer uid        用户ID
//String  userkey    密钥
//Integer teamid     团购ID
//
//返回结果：
//失败：{"result":null,"code":"错误代码"}
//-1：  uid不能为空；
//-2:  团购ID为空；
//-10：密钥为空；
//-11：密钥错误；
//0: 异常
//
//成功： {"result":1,"code":1} -- 已成功取消

+(void)decollectWithUID:(NSString *)uid userkey:(NSString *)userkey teamid:(NSString *)teamid withblock:(void(^)(BOOL success,NSError *error))block;

//请求地址：
//api/OrderAction_orderComment
//请求方式：POST
//传递参数：
//Integer userid            评价人ID
//String  userkey           评价人的登录后的密钥
//Integer orderid           订单ID
//String  comment_grade     满意度("good"--满意；"none"--一般；"bad"--失望)
//String  comment_wantmore  愿意再去(Y-是；N-否)
//String  comment_content   点评内容
//
//返回结果：
//失败：{"result":null,"code":"错误代码"}
//0：  异常-未知错误
//-1：   订单ID不能为空；
//-2:  订单不存在或已删除；
//-3：   订单对应的团购信息不存在或已删除；
//-4：   满意度不能为空
//-5：   请选择愿意再去；
//-6：   点评内容不能为空；
//-7：   用户ID不能为空；
//-8：  非法访问（订单状态不是已支付 或者 评价userid不是订单的user_id）
//
//成功：{"result":null,"code":1}

+(void)commentWithParams:(NSMutableDictionary *)param withblock:(void(^)(BOOL success,NSError *error))block;

////--------------------------------------------------------------------------------------------
////--我的 已消费  / 未消费订单(验证码类型的)
////--------------------------------------------------------------------------------------------
//请求地址：
//api/OrderAction_getMyCouponOrders
//请求方式：POST / GET
//传递参数：
//
//Integer userid  用户ID
//String  userkey 密钥
//Integer isused  是否已消费(使用状态) "Y"-已消费；"N"-未消费；默认"N"
//Integer offset  Mysql的limit起始位置
//Integer size    一次取得最大记录数
//返回结果：
//失败：{"code":"错误代码"}
//-1：用户ID不能为空；
//-10：密钥为空；
//-11：密钥错误；
//成功：

+(void)getMyCouponOrderWithUID:(NSString *)userid userkey:(NSString *)userkey isused:(NSString *)isused offset:(NSNumber *)offset
                          size:(NSNumber *)size withblock:(void(^)(NSArray *orders,NSError *error))block;
//
//请求地址：
//api/CouponAction_getCountInfo
//请求方式：POST / GET
//传递参数：
//Integer uid     用户ID
//String  userkey 密钥
//返回结果：
//失败：{"code":"错误代码"}
//-1：用户ID不能为空；
//-10：密钥为空；
//-11：密钥错误；
//成功：
//{
//    "result": [
//               {
//                   "yxfCount":10,
//                   "wxfCount":10,
//                   "yfkCount":10,
//                   "wfkCount":10
//               }
//               ],
//    "code": 1
//}

+(void)getCountInfoWithUID:(NSString *)uid userkey:(NSString *)userkey withblock:(void(^)(NSDictionary *countinf,NSError *error))block;

////----------------------------------
////-评价API
////----------------------------------
//请求地址：
//api/TeamAction_getNewTeamInfo
//请求方式：POST
//传递参数：
//String reach_time; //客户端最后退出应用的时间 格式为yyyy-MM-dd HH:mm
+(void)getDailyGoodWithTime:(NSString *)reach_time withblock:(void(^)(Good *good , NSError *error))block;

+(void)getPartnerTeamListWithParam:(NSMutableDictionary *)param withblock :(void(^)(NSArray *orderlist,NSError *error))block;

@end
