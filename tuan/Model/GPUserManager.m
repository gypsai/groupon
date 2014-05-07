//
//  GPUserManager.m
//  LiCaiTao
//
//  Created by foolish on 13-3-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "GPUserManager.h"
#import "LocalDB.h"

@implementation GPUserManager

@synthesize accessToken=_accessToken;
@synthesize user=_user;
@synthesize currentOrderID=_currentOrderID;
@synthesize needAutoLogin=_needAutoLogin;
@synthesize l=_l;

+(GPUserManager *)sharedClient
{

    static GPUserManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return  sharedInstance;

}

-(id)init
{
    self = [super init];
    if (self) {
        if (self.user==nil) {
            self.user=[[User alloc] init];
        }
    }
    
    return self;
}

-(void)initAccessToken:(NSString *)token
{

    self.accessToken = token;
    
}

-(void)logOut
{

    self.accessToken = nil;
    self.user = nil;
    [LocalDB deleteUserInfo];

}

-(BOOL)isLogin
{
    if (self.accessToken== nil) {
        return NO;
    }
    if (self.accessToken.length!=0) {
        return YES;
    }
    
    return NO;

}

@end
