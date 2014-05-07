//
//  NearbyMapController.h
//  tuan
//
//  Created by foolish on 13-4-24.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "CalloutMapAnnotation.h"
@interface NearbyMapController : UIViewController<BMKMapViewDelegate>

@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,strong)NSMutableArray *coors;
@property(nonatomic,strong)CalloutMapAnnotation *_calloutMapAnnotation;

@property(nonatomic,assign)NSInteger lat;
@property(nonatomic,assign)NSInteger lng;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableDictionary *param;
@property(nonatomic,strong)NSMutableDictionary *detailparam;

@property(nonatomic,strong)NSMutableArray *annotations;

@end
