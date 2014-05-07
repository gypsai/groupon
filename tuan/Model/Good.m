//
//  Good.m
//  tuan
//
//  Created by foolish on 13-4-15.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "Good.h"
#import "Comment.h"

@implementation Good
@synthesize teamState=_teamState;
@synthesize gid=_gid;
@synthesize title=_title;
@synthesize team_price=_team_price;
@synthesize market_price=_market_price;
@synthesize per_number=_per_number;
@synthesize permin_number=_permin_number;
@synthesize now_number=_now_number;
@synthesize allowrefund=_allowrefund;
@synthesize booking=_booking;
@synthesize imageurl=_imageurl;
@synthesize mobile=_mobile;
@synthesize detail=_detail;
@synthesize notice=_notice;
@synthesize teamintroduce=_teamintroduce;
@synthesize delivery=_delivery;
@synthesize state=_state;
@synthesize conduser=_conduser;
@synthesize expire_time=_expire_time;
@synthesize begin_time=_begin_time;
@synthesize end_time=_end_time;
@synthesize partnerTitle=_partnerTitle;
@synthesize address=_address;
@synthesize exp_date=_exp_date;
@synthesize buy_number_str=_buy_number_str;
@synthesize distStr=_distStr;
@synthesize shopAddress=_shopAddress;
@synthesize shopMobile=_shopMobile;
@synthesize phone=_phone;
@synthesize coordinate=_coordinate;
@synthesize isFreeExpress=_isFreeExpress;
@synthesize freeExpNum=_freeExpNum;
@synthesize expressFee=_expressFee;
@synthesize expressID=_expressID;
@synthesize expressName=_expressName;
@synthesize expressType = _expressType;
@synthesize selfGetFee=_selfGetFee;
@synthesize selfGetID=_selfGetID;
@synthesize seflGetName=_selfGetName;
@synthesize team_id=_team_id;
@synthesize product=_product;
@synthesize traffic=_traffic;
@synthesize iscollect=_iscollect;
@synthesize comment_list=_comment_list;
@synthesize partnerID=_partnerID;
@synthesize credit=_credit;
@synthesize isNew=_isNew;

-(id)initWithDic:(NSDictionary *)dict
{

    self=[super init];
    if (self) {
        
        if ([dict objectForKey:@"credit"]!=[NSNull null]) {
            _credit=[[dict objectForKey:@"credit"] floatValue];
        }else
        {
            _credit=0;
        }
        if ([dict objectForKey:@"isNew"]!=[NSNull null]) {
            if ([[dict objectForKey:@"isNew"] integerValue]==0) {
                _isNew = NO;
            }else
            {
                _isNew = YES;
            }
        }else
        {
            _isNew = NO;
        }
        
        if ([dict objectForKey:@"partner_id"] != [NSNull null]) {
            _partnerID = [dict objectForKey:@"partner_id"];
        }else
        {
            _partnerID = @"0";
        }
        _gid = [[dict objectForKey:@"id"] integerValue];
        _team_id = [[dict objectForKey:@"team_id"] integerValue];
        
        if ([dict objectForKey:@"traffic"]!=[NSNull null]) {
            _traffic = [dict objectForKey:@"traffic"];
        }
        
        _title = [dict objectForKey:@"title"];
        _product=[dict objectForKey:@"product"];
        _team_price = [[dict objectForKey:@"team_price"] floatValue];
        _market_price = [[dict objectForKey:@"market_price"] floatValue];
        if ([dict objectForKey:@"per_number"] == [NSNull null]) {
            _per_number = 0;
        }else
        {
            _per_number = [[dict objectForKey:@"per_number"] integerValue];
            
        }
        if ([dict objectForKey:@"permin_number"] == [NSNull null]) {
            _permin_number = 0;
        }else
        {
            _permin_number = [[dict objectForKey:@"permin_number"] integerValue];
            
        }
        
        
        if ([dict objectForKey:@"shopAddress"]!=[NSNull null]) {
            _shopAddress = [dict objectForKey:@"shopAddress"];
        }else
        {
            _shopAddress = @"暂无地址";
            
        }
        
        if ([dict objectForKey:@"shopMobile"]!=[NSNull null]) {
            _shopMobile = [dict objectForKey:@"shopMobile"];
        }else
        {
            _shopMobile=@"";
        }
        if ([dict objectForKey:@"phone"]!=[NSNull null]) {
            _phone = [dict objectForKey:@"phone"];
        }else
        {
            _shopMobile=@"";
        }
       
        if ([dict objectForKey:@"now_number"]!=[NSNull null]) {
            _now_number = [[dict objectForKey:@"now_number"] integerValue];
            
        }else
        {
            _now_number = 0;
        
        }
        
        _buy_number_str = [NSString stringWithFormat:@"%d人已购买",_now_number];
        
        if ([[dict objectForKey:@"allowrefund"] isEqual:@"Y"]) {
            _allowrefund = true;
        }else
        {
            _allowrefund = false;
        }
        
        if ([[dict objectForKey:@"booking"] isEqual:@"Y"]) {
            _booking = true;
        }else
        {
            _booking = false;
        }
        
        if ([dict objectForKey:@"distStr"]!=[NSNull null]) {
            _distStr = [dict objectForKey:@"distStr"];
            _distStr = [_distStr stringByAppendingFormat:@"公里"];
        }else
        {
            _distStr = @"未知距离";
        }
        
        if ([dict objectForKey:@"image"]!=[NSNull null]) {
            _imageurl = [dict objectForKey:@"image"];
            _imageurl = [IMG_PREFIX stringByAppendingFormat:@"%@",_imageurl];
            
        }
        
        if (([dict objectForKey:@"lat"]!=[NSNull null])&&([dict objectForKey:@"lng"]!=[NSNull null])) {
            _coordinate.latitude = [[dict objectForKey:@"lat"] doubleValue]/1000000;
            _coordinate.longitude = [[dict objectForKey:@"lng"] doubleValue]/1000000;
        }else
        {
            NSInteger value = ((arc4random() % 100000) + 1);
            double offset = ((double)value)/1000000;
           // NSLog(@"%.6f",offset/1000000000);
            _coordinate.latitude = 34.996676+offset;
            _coordinate.longitude = 111.017532+offset;
        }
        _mobile = [dict objectForKey:@"mobile"];
        _detail = [dict objectForKey:@"detail"];
        _notice = [dict objectForKey:@"notice"];
        _teamintroduce = [dict objectForKey:_teamintroduce];
        
        if ([dict objectForKey:@"delivery"]!=[NSNull null]) {
            if ([[dict objectForKey:@"delivery"] isEqual:@"coupon"]) {
                _delivery = COUPON;
            }
            if ([[dict objectForKey:@"delivery"] isEqual:@"express"]) {
                _delivery = EXPRESS;
            }
        }else
        {
            _delivery = EXPRESS;
        }
        
        if (_delivery==EXPRESS) {
            NSDictionary *dicttmp = [dict objectForKey:@"express_list"];
            NSArray *arr = [dicttmp allValues];
            
            if ([arr count]==2) {
                _expressType = EXPRESS_BOTH;
            }if ([arr count]==1) {
                NSString *name = [[arr objectAtIndex:0] objectForKey:@"name"];
                if ([name isEqualToString:@"上门自取"]) {
                    _expressType = EXPRESS_SELFGET;
                }else
                {
                    _expressType = EXPRESS_POST;
                }
            }
            
            for (NSDictionary *expressdic in arr) {
                NSString *name = [expressdic objectForKey:@"name"];
                if ([name isEqualToString:@"上门自取"]) {
                    _selfGetName = [expressdic objectForKey:@"name"];
                    _selfGetID = [[expressdic objectForKey:@"id"] integerValue];
                    _selfGetFee = [[expressdic objectForKey:@"price"] floatValue];
                    
                }else
                {
                    _expressName = [expressdic objectForKey:@"name"];
                    _expressID = [[expressdic objectForKey:@"id"] integerValue];
                    _expressFee = [[expressdic objectForKey:@"price"] floatValue];
                    
                
                }
            }
            
//            if ([_expressName isEqualToString:@"自提"]) {
//                _expressType = EXPRESS_SELFGET;
//            }else
//            {
//                _expressType = EXPRESS_POST;
//            }
            
        }
        
        _state = [dict objectForKey:@"state"];
        
        if ([[dict objectForKey:@"conduser"] isEqual:@"Y"]) {
            _conduser = true;
        }else
        {
            _conduser = false;
        }
        if ([dict objectForKey:@"expire_time"] != [NSNull null]) {
            _expire_time =[NSString stringWithFormat:@"%d",[[dict objectForKey:@"expire_time"] integerValue]];
        }else
        {
            _expire_time = @"永不过期";
        }
        
        
        _begin_time = [dict objectForKey:@"begin_time"];
        _end_time = [dict objectForKey:@"end_time"];
        _partnerTitle = [dict objectForKey:@"partnerTitle"];
        
        if ([dict objectForKey:@"address"]!=[NSNull null]) {
            _address = [dict objectForKey:@"address"];
            if (_address.length==0) {
                _address = @"暂无地址";
            }
        }else
        {
            _address = @"暂无暂无地址";
        }
        
        if ([dict objectForKey:@"end_time"]!=[NSNull null]) {
            _exp_date = [self calExpDate:[[dict objectForKey:@"end_time"] integerValue]];
        }else
        {
            _expire_time = @"永不过期";
        }
        
        if ([dict objectForKey:@"farefree"]!=[NSNull null]) {
            if ([[dict objectForKey:@"farefree"] integerValue]==0) {
                _isFreeExpress = NO;
            }else
            {
                _isFreeExpress = YES;
                _freeExpNum = [[dict objectForKey:@"farefree"] integerValue];
            }
        }else
        {
            _isFreeExpress = NO;
        }
        
        NSArray *cmtarr = [dict objectForKey:@"comment_list"];
        NSMutableArray *a = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in cmtarr) {
            Comment *comment = [[Comment alloc] initComment:dict];
            [a addObject:comment];
        }
        _comment_list = a;
        
        if ([dict objectForKey:@"teamState"]!=[NSNull null]) {
            _teamState = [[dict objectForKey:@"teamState"] integerValue];
            
        }else
        {
            _teamState = STATE_NORMAL;
        }
    
        
       
        
    }
    
    return self;

}

-(NSString *)calExpDate:(NSInteger)timecount
{

 
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
   
    NSInteger itime =timecount - (NSInteger)a;
    
    if (itime<0) {
        return @"已过期";
    }
    
     NSInteger days = itime/60/60/24;
     NSInteger hour = (itime%(3600*24))/3600;
    NSInteger min = (itime%3600)/60;
   
   
   // NSInteger month = itime/60/60/24/12;
    
    NSLog(@"pram is:%d,%d,%d",itime,timecount,(NSInteger)a);
    
    NSString *ex = [NSString  stringWithFormat:@"%d天%d小时%d分钟",days,hour,min];
   // NSLog(@"rst is:%@",ex);
    return ex;
   
}

@end
