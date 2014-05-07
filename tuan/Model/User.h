//
//  User.h
//  tuan
//
//  Created by foolish on 13-4-3.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *loginname;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *userkey;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *realname;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *zipcode;
@property(nonatomic,strong)NSString *bindedmobile;

@property(nonatomic,strong)UIImageView *usericon;

-(id)initFromLogin:(NSDictionary *)dict;
-(id)initFromProfile:(NSDictionary *)dict;

@end
