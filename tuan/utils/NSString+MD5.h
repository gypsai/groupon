//
//  NSString+MD5.h
//  NongXin
//
//  Created by foolish on 12-12-14.
//  Copyright (c) 2012年 foolish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (MD5)
-(NSString *) md5HexDigest;
@end
