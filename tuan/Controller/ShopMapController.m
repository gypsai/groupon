//
//  ShopMapController.m
//  tuan
//
//  Created by foolish on 13-5-9.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "ShopMapController.h"

#import "SaleDetailViewController.h"
#import "KYPointAnnotation.h"
#import <QuartzCore/QuartzCore.h>
#import "NetOperation.h"
#import "UIImageView+AFNetworking.h"

@interface ShopMapController ()

@end

@implementation ShopMapController
@synthesize data=_data;
@synthesize param=_param;
@synthesize mapView=_mapView;
@synthesize good=_good;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadData
{
    
  
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.mapView setZoomLevel:14];
    //    self.mapView.showsUserLocation = YES;
    //    CLLocationCoordinate2D l = {35.01144,110.996075};
    //    [self.mapView setCenterCoordinate:l];
    
    [self.view addSubview:self.mapView];
   
    GPPointAnnotation *pointAnnotation = [[GPPointAnnotation alloc] init];
    pointAnnotation.title = @" ";
    pointAnnotation.gtag = 1;
    pointAnnotation.coordinate = _good.coordinate;
    [_mapView addAnnotation:pointAnnotation];
    
    [_mapView setCenterCoordinate:_good.coordinate];
    
 
    
  
    
    //    CLLocationCoordinate2D coordinate1 = {34.996676,111.017532};
    //    CLLocationCoordinate2D coordinate2 = {35.01144,110.996075};
    //    self.coors = [[NSMutableArray alloc] init];
    //    [self.coors addObject:[NSValue valueWithBytes:&coordinate1 objCType:@encode(CLLocationCoordinate2D)]];
    //    [self.coors addObject:[NSValue valueWithBytes:&coordinate2 objCType:@encode(CLLocationCoordinate2D)]];
    //    for ( NSValue *v in self.coors) {
    //
    //        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    //       // BMKAnnotationView *annotation = [[BMKAnnotationView alloc] init];
    //
    //        CLLocationCoordinate2D l;
    //        [v getValue:&l];
    //        annotation.coordinate = l;
    //       // annotation.title = @"美味厨房爱上对方是否发生阿打发士大夫了费率为";
    //       // annotation.subtitle = @"12元";
    //
    //        [_mapView addAnnotation:annotation];
    //        [_mapView setCenterCoordinate:l];
    //
    //    }
    
    
    
	// Do any additional setup after loading the view.
}




- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    CalloutMapAnnotation *ann = (CalloutMapAnnotation*)annotation;
    
    if ([annotation isKindOfClass:[GPPointAnnotation class]]) {
        
        BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotation.image = [UIImage imageNamed:@"mapmark"];
        newAnnotation.canShowCallout = NO;
		newAnnotation.animatesDrop = YES;
		
		return newAnnotation;
        
    }
    else if ([annotation isKindOfClass:[CalloutMapAnnotation class]]){
        
        //此时annotation就是我们calloutview的annotation
        //CalloutMapAnnotation *ann = (CalloutMapAnnotation*)annotation;
        
        //如果可以重用
        CallOutAnnotationView *calloutannotationview = (CallOutAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"calloutview"];
        
        //否则创建新的calloutView
        if (!calloutannotationview) {
            calloutannotationview = [[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"calloutview"] ;
            
        }
        
        //开始设置添加marker时的赋值
        calloutannotationview.mc.titlelb.text = _good.title;
        calloutannotationview.mc.pricelb.text = [NSString stringWithFormat:@"%.1f",_good.team_price] ;
        calloutannotationview.mc.discountlb.text = [NSString stringWithFormat:@"%.1f元",_good.market_price] ;
        [calloutannotationview.mc.icon setImageWithURL:[NSURL URLWithString:_good.imageurl]];
        [calloutannotationview.mc.btn addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        calloutannotationview.mc.btn.tag = ann.gtag;
        return calloutannotationview;
        
    }
    return nil;
}

-(void)goDetail:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    
    if (self._calloutMapAnnotation&&![view isKindOfClass:[CallOutAnnotationView class]]) {
        
        if (self._calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            self._calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [self.mapView removeAnnotation:self._calloutMapAnnotation];
            self._calloutMapAnnotation = nil;
            
        }
        
        
    }
    
}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    GPPointAnnotation *annn = (GPPointAnnotation*)view.annotation;
    
    
    
    // NSLog(@"anotation is:%@",[view.annotation description]);
    
    if ([view.annotation isKindOfClass:[GPPointAnnotation class]]) {
        
        //如果点到了这个marker点，什么也不做
        if (self._calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            self._calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        //如果当前显示着calloutview，又触发了select方法，删除这个calloutview annotation
        if (self._calloutMapAnnotation) {
            [mapView removeAnnotation:self._calloutMapAnnotation];
            self._calloutMapAnnotation=nil;
            
            
            
        }
        //创建搭载自定义calloutview的annotation
        self._calloutMapAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
        
        //把通过marker(ZNBCPointAnnotation)设置的pointCalloutInfo信息赋值给CalloutMapAnnotation
        self._calloutMapAnnotation.gtag = annn.gtag;
        
        [mapView addAnnotation:self._calloutMapAnnotation];
        
        [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
        
    }
    
}



-(void)goBk:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"地图";
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titlelb;
    
    UIButton *bk = [UIButton buttonWithType:UIButtonTypeCustom];
    bk.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [bk setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [bk addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:bk];
    self.navigationItem.leftBarButtonItem = mp;
    
}


-(void)goMap:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
