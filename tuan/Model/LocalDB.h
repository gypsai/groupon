//
//  LocalDB.h
//  tuan
//
//  Created by foolish on 13-4-18.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface LocalDB : NSObject

+(void)storeUserInfo:(User *)user;
+(void)loadUser;
+(void)deleteUserInfo;
+(BOOL)hasUserInfo;

@end
