//
//  Test.m
//  tuan
//
//  Created by foolish on 13-4-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "Test.h"
#import "NSString+MD5.h"
#import "GPUserManager.h"

@implementation Test

+(void)test
{

    //获取团购商品详情
//    [NetOperation getORderDetailByID:@"222" withblock:^(Order *order, NSError *error) {
//        
//    }];
    
    //获取团购列表,查询接口
    
//    index=#开始ID#
//    size=#条数#
//    title=#搜索条件#
//    orderType=#排序方式# --0默认排序 1人们 2折扣 3价格
//    subId=#子分类ID#
//    groupId=#父分类ID#  -- 子分类ID和父分类ID两个参数不会同时存在
//    cityId=#区域ID#
//    partnerId=#商家ID#  -- 获取某个商家下边的团购信息
   /*
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"0" forKey:@"index"];
    [param setObject:@"1" forKey:@"size"];
    [param setObject:@"餐厅" forKey:@"title"];
    //[param setObject:@"0" forKey:@"orderType"];
    //[param setObject:@"" forKey:@"subId"];
    //[param setObject:@"" forKey:@"groupId"];
    //[param setObject:@"" forKey:@"cityId"];
    //[param setObject:@"" forKey:@"partnerId"];
    
    [NetOperation getGoodListWithParam:nil withblock:^(NSArray *orderlist, NSError *error) {
        
    }];
   */
    
//    TeamAction_getMapTeamList
//    请求方式GET
//    参数
//    lat=#纬度# --百度地图取到的值*e6
//    lng=#经度# --度地图取到的值*e6
//    index=#起始值#    --开始
//    size=#大小#  --默认在地图上返回100个商家的最后团购信息，周边团购根据客户端传入值决定
//    title=#搜索条件# --暂时不需要用到，扩展用
//    subId=#子分类ID# --暂时不需要用到，扩展用
//    groupId=#父分类ID#  -- 子分类ID和父分类ID两个参数不会同时存在 --暂时不需要用到，扩展用
//    cityId=#区域ID# --暂时不需要用到，扩展用
//    partnerId=#商家ID#  -- 获取某个商家下边的团购信息 --暂时不需要用到，扩展用
    /*
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"0" forKey:@"index"];
    [param setObject:@"1" forKey:@"size"];
    [param setObject:@"餐厅" forKey:@"title"];
    [param setObject:@"" forKey:@"lat"];
    [param setObject:@"" forKey:@"lng"];
    //[param setObject:@"0" forKey:@"orderType"];
    //[param setObject:@"" forKey:@"subId"];
    //[param setObject:@"" forKey:@"groupId"];
    //[param setObject:@"" forKey:@"cityId"];
    //[param setObject:@"" forKey:@"partnerId"];
    [NetOperation getNearByOrderWithParam:param withblock:^(NSArray *orderlist, NSError *error) {
        
    }];
    */
  
    //需要登录才能完成的操作
  //  [self login:nil];
    
    //获取区域
    /*
    [NetOperation getRegion:^(NSArray *reg, NSError *error) {
        
    }];
     */
    /*
    [NetOperation getAllCatgory:^(NSArray *cat, NSError *error) {
        
    }];
    */
    //email注册
//    [UserOperation regWithEmail:@"gypsai@163.com" password:@"luom1ng" withblock:^(User *user, NSError *error) {
//        
//    }];
//    

    //获取短信验证码
//    [UserOperation getSMSCodeWith:@"18659246430" uid:@"65583" withblock:^(BOOL success, NSError *error) {
//        
//    }];
    
   
    
    
}

+(void)afterLoginTest
{

    //修改用户名
//    [UserOperation editUserName:[GPUserManager sharedClient].user.userid username:@"风哥" act:nil key:[GPUserManager sharedClient].user.userkey withblock:^(BOOL success, NSError *error) {
//        
//    }];
    
    //修改 密码
    
//    [UserOperation editPassword:[GPUserManager sharedClient].user.userid oldpassword:@"xxoo" newpassword:@"luom1ng" verify:@"luom1ng" act:nil key:[GPUserManager sharedClient].user.userkey withblock:^(BOOL success, NSString *key, NSError *error) {
//        
//    }];
    //用户下单信息查询
    /*
    [NetOperation getUserOrderWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey type:@"4" withblock:^(NSArray *orders, NSError *error) {
        
    }];*/
    
//    [NetOperation bindMobileWith:[GPUserManager sharedClient].user.userid mobile:@"18659246430" secret:@"173459" withblock:^(BOOL success, NSError *error) {
//        
//    }];
    
    
}

+(void)login:(NSString *)secret
{
    
    NSString *password = @"luom1ng";
   // password = [[password stringByAppendingString:secret] md5HexDigest];
    
    [UserOperation loginWithUserName:@"gypsai@foxmail.com" password:password withblock:^(User *user, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }else
        {
        
            [GPUserManager sharedClient].user = user;
            
            [self afterLoginTest];
        
        }
        
    }];

}

@end
