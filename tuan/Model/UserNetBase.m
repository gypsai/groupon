//
//  UserNetBase.m
//  tuan
//
//  Created by foolish on 13-4-13.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "UserNetBase.h"
#import "AFJSONRequestOperation.h"

@implementation UserNetBase

+(UserNetBase *)sharedClient
{
    
    static UserNetBase *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UserNetBase alloc] initWithBaseURL:[NSURL URLWithString:USER_SERVER_BASE]];
    });
    
    return _sharedClient;
    
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    return self;
}

@end
