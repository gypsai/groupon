//
//  MapViewController.h
//  tuan
//
//  Created by foolish on 13-4-4.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "KYBubbleView.h"
#import "CalloutMapAnnotation.h"
#import "GPPointAnnotation.h"
#import "CallOutAnnotationView.h"

@interface MapViewController : UIViewController<BMKMapViewDelegate>

@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,strong)NSMutableArray *coors;
@property(nonatomic,strong)KYBubbleView *bubbleView;
@property(nonatomic,strong)BMKAnnotationView *selectedAV;

@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableDictionary *param;
@property(nonatomic,assign)BOOL isLoading;
@property(nonatomic,strong)CalloutMapAnnotation *_calloutMapAnnotation;



@end
