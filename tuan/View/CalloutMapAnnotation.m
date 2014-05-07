//
//  CalloutMapAnnotation.m
//  tuan
//
//  Created by foolish on 13-4-27.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "CalloutMapAnnotation.h"

@implementation CalloutMapAnnotation


@synthesize latitude;
@synthesize longitude;
@synthesize locationInfo;
@synthesize gtag=_gtag;

- (id)initWithLatitude:(CLLocationDegrees)lat
		  andLongitude:(CLLocationDegrees)lon {
	if (self = [super init]) {
		self.latitude = lat;
		self.longitude = lon;
	}
	return self;
}


-(CLLocationCoordinate2D)coordinate{
    
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = self.latitude;
	coordinate.longitude = self.longitude;
	return coordinate;
    
    
}


@end