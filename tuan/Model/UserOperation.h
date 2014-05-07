//
//  UserOperation.h
//  tuan
//
//  Created by foolish on 13-4-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetBase.h"
#import "UserNetBase.h"
#import "User.h"

@interface UserOperation : NSObject

+(void)getEncrypSecretKey:(void(^)(NSString *key,NSError *error))block;
+(void)loginWithUserName:(NSString *)username password:(NSString *)password withblock:(void(^)(User *user,NSError *error))block;

//失败：{"code":"错误代码"}
//0：注册失败
//-1：注册邮箱不能为空；
//-2：注册邮箱格式错误；
//-3：密码不能为空；

+(void)regWithEmail:(NSString *)email password:(NSString *)password withblock:(void(^)(User *user,NSError *error))block;
+(void)getSMSCodeWith:(NSString *)mobile uid:(NSString *)user_id withblock:(void(^)(BOOL success,NSError *error))block;
+(void)editUserName:(NSString *)uid username:(NSString *)username act:(NSString *)action key:(NSString *)userkey withblock:(void(^)(BOOL success,NSError *error))block;
+(void)editPassword:(NSString *)uid oldpassword:(NSString *)oldpassword newpassword:(NSString *)newpassword verify:(NSString *)verifypassword act:(NSString *)editpassword key:(NSString *)userkey withblock:(void(^)(BOOL success,NSString *key,NSError *error))block;

//String  id    订单编号
//返回结果：JSON String
//成功：{"code":"1"}
//失败：{"code":"错误代码"}
//
//-1：订单号为空
//-2：无此订单
+(void)sendSMSCodeWithOrderID:(NSString *)orderid withblock:(void(^)(BOOL success,NSError *error))block;

+(void)getAddWithBlock:(void(^)(NSArray *urls,NSError *error))block;

+(void)getCityIDwithlat:(NSString *)lat lng:(NSString *)lng  withblock:(void(^)(NSDictionary *dict,NSError *error))block;

@end
