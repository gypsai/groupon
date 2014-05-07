//
//  GPUserManager.h
//  LiCaiTao
//
//  Created by foolish on 13-3-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <CoreLocation/CoreLocation.h>

@class GPUserManager;
@protocol GPUserManagerDelegate <NSObject>

-(void)user:(GPUserManager *)userManager loginSuccessWithToken:(NSString *)token;

@end

@interface GPUserManager : NSObject

@property(nonatomic,strong) NSString *accessToken;
@property(nonatomic,strong) User *user;
@property(nonatomic,strong) NSString *currentOrderID;
@property(nonatomic,assign) BOOL needAutoLogin;
@property(nonatomic,assign) CLLocationCoordinate2D l;

+(GPUserManager *)sharedClient;
-(void)initAccessToken:(NSString *)token;
-(BOOL)isLogin;
-(void)logOut;

@end
