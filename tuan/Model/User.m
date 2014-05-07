//
//  User.m
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize username=_username;
@synthesize usericon=_usericon;
@synthesize userid=_userid;
@synthesize userkey=_userkey;
@synthesize bindedmobile=_bindedmobile;
@synthesize address=_address;
@synthesize zipcode=_zipcode;

-(id)init
{

    self = [super init];
    
    if (self) {
        
    }

    return self;
}


-(id)initFromLogin:(NSDictionary *)dict
{
    self = [super init];
    
    if (self) {
        
        self.userid = [dict objectForKey:@"userid"] ;
        self.userkey = [dict objectForKey:@"userkey"];
        
        NSDictionary *userinfo = [dict objectForKey:@"userinfo"];
        
        if (userinfo) {
            [self parseUserInfo:userinfo];
        }
        
        
        
    }
    
    return self;

}


-(void)parseUserInfo:(NSDictionary *)dict
{
    self.username = [dict objectForKey:@"username"];
    self.mobile = [dict objectForKey:@"mobile"];
    self.email = [dict objectForKey:@"email"];
    
    if ([dict objectForKey:@"realname"]!=[NSNull null]) {
        self.realname = [dict objectForKey:@"realname"];
    }else
    {
        self.realname = @"暂无";
    }
    
    if ([dict objectForKey:@"zipcode"]!=[NSNull null]) {
        self.zipcode = [dict objectForKey:@"zipcode"];
    }else
    {
        self.zipcode = @"暂无邮编";
    }
    
    if ([dict objectForKey:@"address"]!=[NSNull null]) {
        self.address = [dict objectForKey:@"address"];
    }else
    {
        self.address = @"暂无地址";
    }
    
    if ([dict objectForKey:@"bindedmobile"]!=[NSNull null]) {
        self.bindedmobile = [dict objectForKey:@"bindedmobile"];
    }else
    {
        self.bindedmobile = @"暂无电话";
    }
    
}

-(id)initFromProfile:(NSDictionary *)dict
{
    self = [super init];
    
    if (self) {
        
            [self parseUserInfo:dict];
        
    }
    
    return self;

}

@end
