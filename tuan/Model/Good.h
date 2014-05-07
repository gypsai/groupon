//
//  Good.h
//  tuan
//
//  Created by foolish on 13-4-15.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
#define IMG_PREFIX @"http://tuan.ycss.com/static/"
#define COUPON 1
#define EXPRESS 2
#define EXPRESS_SELFGET 1
#define EXPRESS_POST 2
#define EXPRESS_BOTH 3
#define STATE_NORMAL 1
#define STATE_EXPIRED 0
#define STATE_OUT -1
#define STATE_OUTNUMBER -2
#define STATE_PENDING -3

@interface Good : NSObject
//1 private Integer teamState; ^M
//62      1：可以正常购买；^M
//63      0：已过期 / 已关闭；^M
//64     -1:已经卖光了；^M
//65     -2：已达到团购的限购数量,无法再购买了（当前登录用户）^M
//66     -3: 团购还未开启^M
//Integer id;   //团购ID
//String title; // 本单标题
//String summary; // 本单简介
//Integer city_id; // 区域ID
//String city_ids; // 多区域ID
//Integer group_id; // 父分类ID
//Integer sub_id; // 子分类ID
//Integer partner_id; // 商户ID
//String partnerTitle; // 商户标题
//Double team_price; // 团购价格
//Double market_price; // 时长价格
//String product; // 发送短信中的标题
//String condbuy; // 团购的一些其他属性 （商品团购需要选择颜色，款式之类的）
//Integer per_number; // 每人限购
//Integer permin_number; // 最低购买
//Integer min_number; // 团购成功最低数量
//Integer max_number; // 最高团购数量
//Integer now_number; // 现在被购买团购数量
//String allowrefund; // 是否允许退款 Y是，N否
//String booking; // 是否预约 Y是 N否
//String image; // 图片地址
//String mobile; // 联系方式
//Integer card; // 代金券使用最大面额
//Integer farefree; // 面邮费数量
//String address; // 用户自取地址
//String detail; // 团购详情
//String notice; // 特别提示
//String teamintroduce; // 项目简介
//String companyintroduce; // 公司简介
//String express; // 快递
//String userreview; // 网友点评
//String systemreview; // 运城搜搜团推广辞
//String delivery; // 验证码
//String state; // 团购状态 'none'// 正在进行中,'success'成功,'soldout'售光,'failure'失败,'refund'退款
//String conduser; // 限制条件 Y限制,N不限制
//String buyonce; // 是否购买一次 Y是，N不是
//Integer expire_time; // 验证码有效期 需要在客户端转换为date日期
//Integer begin_time; // 团购开始时间
//Integer end_time; // 团购结束时间
//Integer reach_time; // 团购成功时间
//Integer close_time;// 团购结束时间
//Integer lat; 	//纬度值客户端/e6使用
//Integer lng;    //经度值客户端/e6使用
//delivery     配送方式 "coupon"-验证码； "express"-快递
//farefree;    免运费数量；-1免运费；0-不免运费；大于0-如1购买1件免运费,以此类推
//"express_list": { //团购支持的快递列表
//    "0": {
//        "id": "35",          快递分类的ID
//        "price": "15",       运费
//        "name": "圆通快递"    快递名称
//    }
//}

@property(nonatomic,assign)NSInteger teamState;
@property(nonatomic,assign)NSInteger gid;
@property(nonatomic,assign)NSInteger team_id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)float team_price;
@property(nonatomic,assign)float market_price;
@property(nonatomic,assign)NSInteger per_number;
@property(nonatomic,assign)NSInteger permin_number;
@property(nonatomic,assign)NSInteger now_number;
@property(nonatomic,strong)NSString *buy_number_str;
@property(nonatomic,assign)Boolean allowrefund;
@property(nonatomic,assign)Boolean booking;
@property(nonatomic,strong)NSString *imageurl;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSString *notice;
@property(nonatomic,strong)NSString *teamintroduce;
//@property(nonatomic,strong)NSString *delivery;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,assign)Boolean  conduser;
@property(nonatomic,strong)NSString *expire_time;
@property(nonatomic,strong)NSString *begin_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *partnerTitle;
@property(nonatomic,strong)NSString *partnerID;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *exp_date;
@property(nonatomic,strong)NSString *distStr;
@property(nonatomic,strong)NSString *shopAddress;
@property(nonatomic,strong)NSString *shopMobile;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,assign)NSInteger delivery;
@property(nonatomic,assign)BOOL isFreeExpress;
@property(nonatomic,assign)NSInteger freeExpNum;
@property(nonatomic,strong)NSString *traffic;
//快递相关
@property(nonatomic,assign)NSInteger expressType; //快递类型 ，邮寄或者自取
@property(nonatomic,assign)float expressFee;
@property(nonatomic,assign)NSInteger expressID;
@property(nonatomic,strong)NSString *expressName;

//自提
@property(nonatomic,assign)NSInteger selfGetID;
@property(nonatomic,assign)float selfGetFee;
@property(nonatomic,strong)NSString *seflGetName;

@property(nonatomic,strong)NSArray *comment_list;

@property(nonatomic,assign)BOOL iscollect;
@property(nonatomic,assign)float credit;
@property(nonatomic,assign)BOOL isNew;

-(id)initWithDic:(NSDictionary *)dict;

@end
