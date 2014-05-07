//
//  CalloutMapAnnotation.h
//  tuan
//
//  Created by foolish on 13-4-27.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface CalloutMapAnnotation : NSObject<BMKAnnotation>


@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
@property(nonatomic,assign)NSInteger gtag;


@property(retain,nonatomic) NSDictionary *locationInfo;//callout吹出框要显示的各信息



- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon;



@end
