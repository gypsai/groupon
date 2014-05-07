//
//  UserOperation.m
//  tuan
//
//  Created by foolish on 13-4-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "UserOperation.h"

@implementation UserOperation

+(void)getEncrypSecretKey:(void (^)(NSString *, NSError *))block
{

    [[NetBase sharedClient] getPath:USER_GET_SECRET_KEY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
      //  NSLog(@"secret key is:%@",[responseObject objectForKey:@"result"]);
        
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSString *key = [responseObject objectForKey:@"result"];
            block(key,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];

}

+(void)loginWithUserName:(NSString *)username password:(NSString *)password withblock:(void (^)(User *, NSError *))block
{

    [[UserNetBase sharedClient] postPath:USER_LOGIN parameters:[NSDictionary dictionaryWithObjectsAndKeys:username,@"email",password,@"password", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"user info:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            
            User *user = [[User alloc] initFromLogin:responseObject];
            block(user,nil);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error) {
           block(nil,error);
            NSLog(@"login error:%@",error);
        }
        
    }];
    
}

+(void)regWithEmail:(NSString *)email password:(NSString *)password withblock:(void (^)(User *, NSError *))block
{

    [[UserNetBase sharedClient] postPath:USER_REG parameters:[NSDictionary dictionaryWithObjectsAndKeys:email,@"email",password,@"password", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"the reg response :%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            //0：注册失败
            //-1：注册邮箱不能为空；
            //-2：注册邮箱格式错误；
            //-3：密码不能为空；
            NSError *error = nil;
            switch (code) {
                case 0:
                    error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"注册失败",NSLocalizedDescriptionKey, nil]];
                    break;
                case -1:
                    error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"注册邮箱不能为空",NSLocalizedDescriptionKey, nil]];
                    break;
                case -2:
                    error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"注册邮箱格式错误",NSLocalizedDescriptionKey, nil]];
                    break;
                case -3:
                    error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"密码不能为空",NSLocalizedDescriptionKey, nil]];
                    break;
                    
                    
                default:
                    break;
            }
           
            block(nil,error);
        }
        else
        {
            NSLog(@"reg uid:%d",[[responseObject objectForKey:@"userid"] integerValue]);
            
            User *user = [[User alloc] init];
            user.userid = [responseObject objectForKey:@"userid"];
            user.userkey = [responseObject objectForKey:@"userkey"];
            NSLog(@"key after reg:%@",[responseObject objectForKey:@"userkey"]);
            block(user,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            block(nil,error);
        }
    }];

}

+(void)getSMSCodeWith:(NSString *)mobile uid:(NSString *)user_id withblock:(void (^)(BOOL, NSError *))block
{

    [[UserNetBase sharedClient] postPath:USER_GET_SMSCODE parameters:[NSDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",user_id,@"user_id", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(false,error);
        }
        else
        {
            NSLog(@"reSPONSE DATA:%@",responseObject);
            
            block(true,nil);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(false,error);
        
    }];

}

+(void)editUserName:(NSString *)uid username:(NSString *)username act:(NSString *)action key:(NSString *)userkey withblock:(void (^)(BOOL, NSError *))block
{

    [[UserNetBase sharedClient] postPath:USER_EDIT parameters:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",username,@"username",@"editusername",@"act",userkey,@"userkey", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"reSPONSE DATA:%@",responseObject);
        
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(false,error);
        }
        else
        {
            
            block(true,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(false,error);
    }];
    
}

+(void)editPassword:(NSString *)uid oldpassword:(NSString *)oldpassword newpassword:(NSString *)newpassword verify:(NSString *)verifypassword act:(NSString *)editpassword key:(NSString *)userkey withblock:(void (^)(BOOL, NSString *, NSError *))block
{

    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",oldpassword,@"oldpassword",newpassword,@"password",verifypassword,@"password2",@"editpassword",@"act",userkey,@"userkey", nil];
    
    [[UserNetBase sharedClient] postPath:USER_EDIT parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"reSPONSE DATA:%@",responseObject);
        
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(false,nil,error);
        }
        else
        {
            NSString *key = [responseObject objectForKey:@"userkey"];
            
            block(true,key,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(false,nil,error);
    }];

}


+(void)sendSMSCodeWithOrderID:(NSString *)orderid withblock:(void (^)(BOOL, NSError *))block
{
    
    [[UserNetBase sharedClient] postPath:USER_SEND_ORDERSMS parameters:[NSDictionary dictionaryWithObjectsAndKeys:orderid,@"id", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"send SMS:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(false,error);
        }
        else
        {
            
            block(true,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(false,error);
        
    }];

   

}

+(void)getAddWithBlock:(void (^)(NSArray *, NSError *))block
{

    [[UserNetBase sharedClient] postPath:MAIN_ADD parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"4",@"type", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"ADD:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSArray *adds = [responseObject objectForKey:@"result"];
            
            
            block(adds,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil,error);
        
    }];

}

+(void)getCityIDwithlat:(NSString *)lat lng:(NSString *)lng withblock:(void (^)(NSDictionary *, NSError *))block
{
    NSString *loc = [lat stringByAppendingFormat:@",%@",lng];
    [[UserNetBase sharedClient] getPath:@"city.php" parameters:[NSDictionary dictionaryWithObjectsAndKeys:loc,@"location", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];

}


@end
