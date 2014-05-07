//
//  NetOperation.m
//  tuan
//
//  Created by foolish on 13-4-14.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "NetOperation.h"
#import "Category.h"
#import "Good.h"
#import "Order.h"

@implementation NetOperation

+(void)getUserOrderWithUID:(NSString *)uid userkey:(NSString *)userkey type:(NSInteger )type offset:(NSInteger)offset size:(NSInteger)size withblock:(void (^)(NSArray *, NSError *))block
{

  
    
    [[NetBase sharedClient] getPath:ORDER_ACTION parameters:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"userid",userkey,@"userkey",[NSNumber numberWithInt:offset] ,@"offset",[NSNumber numberWithInt:size],@"size",[NSNumber numberWithInt:type],@"type", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"my coupon:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [responseObject objectForKey:@"result"]) {
                
                Order *order = [[Order alloc] initWithDict:dict];
                order.good = [[Good alloc] initWithDic:dict];
                [rst addObject:order];
            }
            
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
        
    }];

    

}

+(void)editUserAddressWithParam:(NSDictionary *)param withblock:(void (^)(BOOL, NSError *))block
{
    [[NetBase sharedClient] postPath:USER_EDIT_ADDRESS parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"EDIT ADDRESS:%@",responseObject);
        
        
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

+(void)getGoodDetailByID:(NSString *)oid lat:(NSInteger)lat lng:(NSInteger)lng withblock:(void (^)(Good *, NSError *))block
{
    [[NetBase sharedClient] getPath:ORDER_DETAIL parameters:[NSDictionary dictionaryWithObjectsAndKeys:oid,@"teamid",[NSNumber numberWithInteger:lat],@"lat",[NSNumber numberWithInteger:lng],@"lng",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"order detail response:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
         
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            if ([responseObject objectForKey:@"result"]==[NSNull null]) {
                     NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"网络请求为空",NSLocalizedDescriptionKey, nil]];
                block(nil,error);
            }else
            {
                Good *good = [[Good alloc] initWithDic:dict];
                block(good,nil);
            }
           
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
        
    }];

}

+(void)getNearByTeamListWithParam:(NSDictionary *)param withblock:(void (^)(NSArray *, NSError *))block
{

   // NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:lat],@"lat",[NSNumber numberWithInt:lng],@"lng",[NSNumber numberWithInt:index],@"index",[NSNumber numberWithInt:size],@"size", nil];
    
    [[NetBase sharedClient] getPath:NEARBY_TEAM parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"nearyby list:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [responseObject objectForKey:@"result"]) {
                
                Good *good = [[Good alloc] initWithDic:dict];
                [rst addObject:good];
            }
            
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
    
    }];
    

}

+(void)getGoodListWithParam:(NSDictionary *)param withblock:(void (^)(NSArray *, NSError *))block
{

    [[NetBase sharedClient] postPath:ORDER_LIST parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"ORDER LIST:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [responseObject objectForKey:@"result"]) {
            
                Good *good = [[Good alloc] initWithDic:dict];
                [rst addObject:good];
            }
            
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
        
    
    }];

}

+(void)getMapGoodWithParam:(NSDictionary *)param withblock:(void (^)(NSArray *, NSError *))block
{
    [[NetBase sharedClient] postPath:ORDER_NEARBY_LIST parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"ORDER LIST:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [responseObject objectForKey:@"result"]) {
                
                Good *good = [[Good alloc] initWithDic:dict];
                [rst addObject:good];
            }
            
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
    }];


}

+(void)bindMobileWithUid:(NSString *)userid mobile:(NSString *)mobile secret:(NSString *)secret key:(NSString *)userkey withblock:(void (^)(BOOL, NSError *))block
{
    [[NetBase sharedClient] postPath:BIND_MOBILE parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",mobile,@"mobile",secret,@"secret",userkey,@"userkey",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"BIND MOBILE:%@",responseObject);
        
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

+(void)getRegion:(void (^)(NSArray *, NSError *))block
{

    [[NetBase sharedClient] getPath:GET_REGION parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      //  NSLog(@"GET REGION:%@",responseObject);
        
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            Category *cat = [[Category alloc]init];
            cat.name = @"全部区域";
            cat.cid = 0;
            cat.hasChild = false;
            [rst addObject:cat];
            
            for (NSDictionary *dic in [responseObject objectForKey:@"result"]) {
                Category *cat = [[Category alloc] initWithDic:dic];
                [rst addObject:cat];
            }
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
    }];

}

+(void)getAllCatgoryWithCityID:(NSString *)cityid withblock:(void (^)(NSArray *, NSError *))block
{

    
    [[NetBase sharedClient] getPath:GET_CATGORY parameters:[NSDictionary dictionaryWithObjectsAndKeys:cityid,@"cityid", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // NSLog(@"GET category:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in [responseObject objectForKey:@"result"]) {
                Category *cat = [[Category alloc] initWithDic:dic];
                [rst addObject:cat];
            }
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
    }];

}

+(void)getMyCouponWithUid:(NSString *)uid key:(NSString *)userkey isused:(NSInteger )issued index:(NSInteger)offset size:(NSInteger)size withblock:(void (^)(NSArray *, NSError *))block
{
    NSDictionary *params;
    switch (issued) {
        case CONSUMED:
            params = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",userkey,@"userkey",@"Y",@"isused",[NSNumber numberWithInt:offset] ,@"offset",[NSNumber numberWithInt:size],@"size", nil];
            break;
        case UNCONSUMED:
            params = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",userkey,@"userkey",@"N",@"isused",[NSNumber numberWithInt:offset] ,@"offset",[NSNumber numberWithInt:size],@"size", nil];
            
            break;
        case ALL_COUPON:
            params = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",userkey,@"userkey",[NSNumber numberWithInt:offset] ,@"offset",[NSNumber numberWithInt:size],@"size", nil];
            
            break;
        default:
            break;
    }

    [[NetBase sharedClient] getPath:MY_COUPON parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        NSLog(@"my coupon:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [responseObject objectForKey:@"result"]) {
                
                Coupon *coupon = [[Coupon alloc] initFromDict:dict];
                [rst addObject:coupon];
            }
            
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
    
    }];
}

+(void)addCollectWithUid:(NSString *)uid key:(NSString *)userkey teamid:(NSInteger)teamid withblock:(void (^)(BOOL, NSError *))block
{

   //NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"65582",@"uid",@"80eb6",@"userkey",1320,@"teamid",nil];
    
    [[NetBase sharedClient] getPath:ADD_COLLECT parameters:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",userkey,@"userkey",[NSString stringWithFormat:@"%d", teamid],@"teamid",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"add collect:%@",responseObject);
        
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

+(void)getMyCollectNumberWithUid:(NSString *)uid key:(NSString *)userkey withblock:(void (^)(NSInteger, NSError *))block
{

    [[NetBase sharedClient] postPath:COLLECT_NUM parameters:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",userkey,@"userkey", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"collect count:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(0,error);
        }
        else
        {
            NSInteger num = [[responseObject objectForKey:@"result"] integerValue];
            block(num,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(0,error);
    }];

}

+(void)getMyCollectWithUid:(NSString *)uid key:(NSString *)userkey offset:(NSInteger)offset size:(NSInteger)size withblock:(void (^)(NSArray *, NSError *))block
{

    [[NetBase sharedClient] postPath:MY_COLLECT parameters:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",userkey,@"userkey",[NSNumber numberWithInt:offset],@"offset",[NSNumber numberWithInt:size],@"size",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"MY COLLECT LIST:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [responseObject objectForKey:@"result"]) {
                
                Good *good = [[Good alloc] initWithDic:dict];
                [rst addObject:good];
            }
            
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        

    }];
}

+(void)getVersionWithBlock:(void (^)(NSString *, NSError *))block
{

    NetBase *nb = [[NetBase alloc] initWithBaseURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=284417350"]];
    [nb getPath:nil parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"version response:%@",responseObject);
        
        
        NSArray *configData = [responseObject valueForKey:@"results"];
        NSString *version = nil;
        
        for (id config in configData)
        {
            version = [config valueForKey:@"version"];
        }
        
        
        block(version,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];

}

+(void)OrderBuyWithUid:(NSString *)uid userkey:(NSString *)userkey teamid:(NSInteger)teamid withblock:(void (^)(Order *, NSError *))block
{
    [[NetBase sharedClient] postPath:ORDER_BUY parameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:teamid],@"teamid",uid,@"userid",userkey,@"userkey",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"order detail response:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            if ([responseObject objectForKey:@"result"]==[NSNull null]) {
                NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"网络请求为空",NSLocalizedDescriptionKey, nil]];
                block(nil,error);
            }else
            {
                Good *good = [[Good alloc] initWithDic:[dict objectForKey:@"teaminfo"]];
                Order *order = [[Order alloc] init];
                order.good = good;
                order.bind_mobile = [dict objectForKey:@"bind_mobile"];
                block(order,nil);
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
        
    }];
    


}

+(void)getMyAccountWithUid:(NSString *)userid userkey:(NSString *)userkey withblock:(void (^)(User *, NSError *))block
{
    [[NetBase sharedClient] postPath:USER_GET_PROFILE parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",userkey,@"userkey", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"user account:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            
            User *user = [[User alloc] initFromProfile:[responseObject objectForKey:@"result"]];
            block(user,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error) {
            block(nil,error);
            NSLog(@"login error:%@",error);
        }
        
    }];

}

+(void)CreateOrderWithParam:(NSDictionary *)param withblock:(void (^)(Order *, NSError *))block
{
    [[NetBase sharedClient] postPath:ORDER_CREATE parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"create order response:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            if ([responseObject objectForKey:@"result"]==[NSNull null]) {
                NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"网络请求为空",NSLocalizedDescriptionKey, nil]];
                block(nil,error);
            }else
            {
               Order *order = [[Order alloc] initFromCreate:dict];
               block(order,nil);
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
        
    }];
    


}

+(void)OrderEnsureWithUID:(NSString *)userid userkey:(NSString *)userkey orderid:(NSString *)orderid phonetag:(NSString *)phonetag withblock:(void (^)(Order *, NSError *))block
{

    [[NetBase sharedClient] postPath:ORDER_ENSUERE parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",userkey,@"userkey",orderid,@"orderid",phonetag,@"phonetag", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"create order response:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
       if (code==1) {
           Order *order = [[Order alloc] init];
            order.status = ORDER_SELFPAY_SUCCESS;
            block(order,nil);
            
        }else if(code==2)
        {
            Order *order = [[Order alloc] init];
            order.status = ORDER_PAYED;
            block(order,nil);
            
        }else if(code==3)
        {
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            Order *order = [[Order alloc] initWithDict:dict];
            order.status = ORDER_PENDINGALIPAY;
            block(order,nil);
            
        }else
        {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];

}

+(void)OrderCanRefundWithOrderID:(NSString *)orderid withblock:(void (^)(Order *, NSError *))block
{
    [[NetBase sharedClient] postPath:ORDER_IF_REFUND parameters:[NSDictionary dictionaryWithObjectsAndKeys:orderid,@"orderid", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"if can refund response:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            Order *order = [[Order alloc] initWithDict:dict];
            order.good = [[Good alloc] initWithDic:dict];
            block(order,nil);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(nil,error);
    }];

}

+(void)OrderRefundWithUID:(NSString *)userid userkey:(NSString *)userkey orderid:(NSString *)orderid reason:(NSString *)rreason withblock:(void (^)(BOOL, NSError *))block
{
    [[NetBase sharedClient] postPath:ORDER_REFUND parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",userkey,@"userkey",orderid,@"orderid",rreason,@"rreason", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"refund response:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(NO,error);
        }
        else
        {
            block(YES,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block(NO,error);
    }];


}

+(void)ReadyPayWithUID:(NSString *)userid userkey:(NSString *)userkey orderid:(NSString *)orderid withblock:(void (^)(Order *, NSError *))block
{
    [[NetBase sharedClient] postPath:READY_PAY parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",userkey,@"userkey",orderid,@"orderid", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"create order response:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code==1) {
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            if ([responseObject objectForKey:@"result"]==[NSNull null]) {
                NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"网络请求为空",NSLocalizedDescriptionKey, nil]];
                block(nil,error);
            }else
            {
                Order *order = [[Order alloc] initFromCreate:dict];
                block(order,nil);
            }
            
        }else if(code==2)
        {
            Order *order = [[Order alloc] init];
            order.status = ORDER_PAYED;
            block(order,nil);
            
        }else
        {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];


}

+(void)getUserMoneyWithUID:(NSString *)userid userkdy:(NSString *)userkey withblock:(void (^)(float, NSError *))block
{
    [[NetBase sharedClient] postPath:USER_GETUSERMONEY parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",userkey,@"userkey", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"refund response:%@",responseObject);
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(0,error);
        }else
        {
            float money = [[responseObject objectForKey:@"result"] floatValue];
            block(money,nil);
        
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(0,error);
    }];


}

+(void)feedbackWithUID:(NSString *)userid title:(NSString *)title contact:(NSString *)contact message:(NSString *)message withblock:(void (^)(BOOL, NSError *))block
{

    [[NetBase sharedClient] postPath:USER_FEEDBACK  parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",title,@"title",contact,@"contact",message,@"message",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"feed back:%@",responseObject);
        
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

+(void)removeOrderWithUID:(NSString *)userid userkey:(NSString *)userkey orderid:(NSString *)orderid withblock:(void (^)(BOOL, NSError *))block
{
    
    [[NetBase sharedClient] postPath:ORDER_REMOVE  parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",userkey,@"userkey",orderid,@"orderid",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"reomove order:%@",responseObject);
        
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

+(void)isCollectUID:(NSString *)uid teamid:(NSString *)teamid withblock:(void (^)(BOOL, NSError *))block
{
    [[NetBase sharedClient] postPath:ORDER_ISCOLLECT  parameters:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",teamid,@"teamid",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"is collect:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(false,error);
        }
        else
        {
            NSInteger rst = [[responseObject valueForKey:@"result"] integerValue];
            if (rst==1) {
                block(true,nil);
            }else
            {
                block(false,nil);
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(false,error);
    }];


}

+(void)decollectWithUID:(NSString *)uid userkey:(NSString *)userkey teamid:(NSString *)teamid withblock:(void (^)(BOOL, NSError *))block
{

    [[NetBase sharedClient] postPath:ORDER_DECOLLECT  parameters:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",userkey,@"userkey",teamid,@"teamid",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"decollect:%@",responseObject);
        
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

+(void)commentWithParams:(NSMutableDictionary *)param withblock:(void (^)(BOOL, NSError *))block
{
    [[NetBase sharedClient] postPath:ORDER_COMMENT  parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"decollect:%@",responseObject);
        
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

+(void)getMyCouponOrderWithUID:(NSString *)userid userkey:(NSString *)userkey isused:(NSString *)isused offset:(NSNumber *)offset size:(NSNumber *)size withblock:(void(^)(NSArray *orders,NSError *error))block
{

    [[NetBase sharedClient] postPath:ORDER_COUPONORDER parameters:[NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",userkey,@"userkey",offset ,@"offset",size,@"size",isused,@"isused", nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"coupon order:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [responseObject objectForKey:@"result"]) {
                
                Order *order = [[Order alloc] initWithDict:dict];
                order.good = [[Good alloc] initWithDic:dict];
                [rst addObject:order];
            }
            
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
        
    }];


}

+(void)getCountInfoWithUID:(NSString *)uid userkey:(NSString *)userkey withblock:(void (^)(NSDictionary *, NSError *))block
{
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",userkey,@"userkey",nil];
    
    [[NetBase sharedClient] getPath:COUNT_INFO parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"nearyby list:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            block(dict,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
    }];

}

+(void)getDailyGoodWithTime:(NSString *)reach_time withblock:(void (^)(Good *, NSError *))block
{
    [[NetBase sharedClient] postPath:GOOD_DAILY_NEW parameters:[NSDictionary dictionaryWithObjectsAndKeys:reach_time,@"reach_time",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"DAILY NEW response:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            
            NSDictionary *dict = [responseObject objectForKey:@"result"];
            if ([responseObject objectForKey:@"result"]==[NSNull null]) {
                NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"网络请求为空",NSLocalizedDescriptionKey, nil]];
                block(nil,error);
            }else
            {
                Good *good = [[Good alloc] initWithDic:dict];
                block(good,nil);
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
        
    }];

    
}


+(void)getPartnerTeamListWithParam:(NSMutableDictionary *)param withblock:(void (^)(NSArray *, NSError *))block
{
    
    [[NetBase sharedClient] getPath:MAP_GET_PARTENER parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"parten list:%@",responseObject);
        
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if (code!=1) {
            NSError *error = [NSError errorWithDomain:@"user" code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"出错咯~",NSLocalizedDescriptionKey, nil]];
            block(nil,error);
        }
        else
        {
            NSMutableArray *rst = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [responseObject objectForKey:@"result"]) {
                
                Good *good = [[Good alloc] initWithDic:dict];
                [rst addObject:good];
            }
            
            block(rst,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error :%@",error);
        block(nil,error);
        
    }];


}
@end
