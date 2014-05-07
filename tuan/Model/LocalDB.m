//
//  LocalDB.m
//  tuan
//
//  Created by foolish on 13-4-18.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "LocalDB.h"
#import "GPUserManager.h"

@implementation LocalDB



+(void)storeUserInfo:(User *)user
{
    

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:user.username forKey:@"username"];
    [ud setObject:user.password forKey:@"password"];
    [ud setObject:user.mobile forKey:@"mobile"];
    [ud setObject:user.userid forKey:@"userid"];
    [ud setObject:user.userkey forKey:@"userkey"];
    [ud setObject:user.realname forKey:@"realname"];
    [ud setObject:user.email forKey:@"email"];
    [ud setObject:user.zipcode forKey:@"zipcode"];
    [ud setObject:user.address forKey:@"address"];
    [ud setObject:user.bindedmobile forKey:@"bindedmobile"];
    
    [ud synchronize];
    
}

+(User *)getUserInfo
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    User *user = [[User alloc] init];
    user.username = [ud objectForKey:@"username"];
    user.password = [ud objectForKey:@"password"];
    user.mobile = [ud objectForKey:@"mobile"];
    user.userid = [ud objectForKey:@"userid"];
    user.userkey = [ud objectForKey:@"userkey"];
    user.realname = [ud objectForKey:@"realname"];
    user.username = [ud objectForKey:@"email"];
    user.zipcode = [ud objectForKey:@"zipcode"];
    user.address = [ud objectForKey:@"address"];
    user.bindedmobile = [ud objectForKey:@"bindedmoble"];
    
    return user;

}

+(void)loadUser
{
    [GPUserManager sharedClient].user = [self getUserInfo];
    [GPUserManager sharedClient].accessToken = [GPUserManager sharedClient].user.userkey;

}

+(void)deleteUserInfo
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"username"];
    [ud removeObjectForKey:@"password"];
    [ud removeObjectForKey:@"mobile"];
    [ud removeObjectForKey:@"userid"];
    [ud removeObjectForKey:@"userkey"];
    [ud removeObjectForKey:@"realname"];
    [ud removeObjectForKey:@"email"];
    [ud removeObjectForKey:@"zipcode"];
    [ud removeObjectForKey:@"address"];
    [ud removeObjectForKey:@"bindedmoble"];
    
    [ud synchronize];
}

+(BOOL)hasUserInfo
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (([ud objectForKey:@"username"]!=nil)&&([ud objectForKey:@"password"]!=nil)) {
        return true;
    }
         
         return false;
}



@end
