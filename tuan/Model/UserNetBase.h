//
//  UserNetBase.h
//  tuan
//
//  Created by foolish on 13-4-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

#define USER_LOGIN @"login.php"
#define USER_REG @"register.php"
#define USER_GET_SMSCODE @"getsmscode.php"
#define USER_SEND_ORDERSMS @"smscode.php"
#define USER_EDIT @"edituser.php"
#define USER_SERVER_BASE_DEBUG @"http://testtuan.ycss.com/appapi/"
#define USER_SERVER_BASE @"http://tuan.ycss.com/appapi/"
#define MAIN_ADD @"ad.php"
//http://tuan.ycss.com/appapi/city.php?location=35.620919,111.232857
@interface UserNetBase : AFHTTPClient

+(UserNetBase *)sharedClient;

@end
