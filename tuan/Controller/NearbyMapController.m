//
//  NearbyMapController.m
//  tuan
//
//  Created by foolish on 13-4-24.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "NearbyMapController.h"
#import "GPPointAnnotation.h"
#import "CallOutAnnotationView.h"
#import "BMapKit.h"
#import "SaleDetailViewController.h"
#import "MapCell.h"
#import "UIImageView+AFNetworking.h"
#import "GPUserManager.h"
#import "NetOperation.h"
#import "AppDelegate.h"
#import "ActionSheetStringPicker.h"
#import "Category.h"

@interface NearbyMapController ()

@end

@implementation NearbyMapController
@synthesize data=_data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self test];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.mapView setZoomLevel:14];
    
    CLLocationCoordinate2D center = {34.996676,111.017532};
    [self.mapView setCenterCoordinate:center];
	[self.view addSubview:self.mapView];
    
    self.annotations = [[NSMutableArray alloc] init];
    self.param = [[NSMutableDictionary alloc] init];
    self.detailparam = [[NSMutableDictionary alloc] init];
    [self loadData];

}

-(void)reloadData
{
    [self.mapView removeAnnotations:self.annotations];
    [self.annotations removeAllObjects];
 
    for (NSInteger i=0; i<[self.data count]; i++) {
        
        Good *good = [self.data objectAtIndex:i];
        GPPointAnnotation *pointAnnotation = [[GPPointAnnotation alloc] init];
        pointAnnotation.title = @" ";
        pointAnnotation.gtag = i;
        
        pointAnnotation.coordinate = good.coordinate;
        [_mapView addAnnotation:pointAnnotation];
        [self.annotations addObject:pointAnnotation];
        
    }
    
    BMKPointAnnotation *myanno = [[BMKPointAnnotation alloc] init];
    myanno.title = @"我的位置";
    myanno.coordinate = [GPUserManager sharedClient].l;
  //  [_mapView setCenterCoordinate:[GPUserManager sharedClient].l];
    [_mapView addAnnotation:myanno];
    
}

-(void)loadData
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    self.lat = (NSInteger)([GPUserManager sharedClient].l.latitude*1000000);
    self.lng = (NSInteger)([GPUserManager sharedClient].l.longitude*1000000);
    [self.param setObject:[NSNumber numberWithInteger:self.lat] forKey:@"lat"];
    [self.param setObject:[NSNumber numberWithInteger:self.lng] forKey:@"lng"];
    [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"index"];
    [self.param setObject:[NSNumber numberWithInt:30] forKey:@"size"];

    [NetOperation getNearByTeamListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
     
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        self.data = nil;
        self.data = (NSMutableArray *)orderlist;
        NSLog(@"have numbers of data:%d",[self.data count]);
        NSArray *arr = [self.param allKeys];
        NSArray *arr2 = [self.param allValues];
        for (NSInteger i=0; i<[arr count]; i++) {
            NSLog(@"%@--->>%@",[arr objectAtIndex:i],[arr2 objectAtIndex:i]);
        }
        
        [self reloadData];
        
    }];
    
}


-(void)test
{
    [NetOperation getPartnerTeamListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
    }];

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
        
        Good *good = [self.data objectAtIndex:ann.gtag];
        if ([self.param objectForKey:@"subId"]!=nil) {
        [self.detailparam setObject:[self.param objectForKey:@"subId"] forKey:@"subId"];
        }
        if ([self.param objectForKey:@"groupId"]!=nil) {
            [self.detailparam setObject:[self.param objectForKey:@"groupId"] forKey:@"groupId"];  
        }
      
        [self.detailparam setObject:good.partnerID forKey:@"partnerId"];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        calloutannotationview.mc.hidden = YES;
        calloutannotationview.ml.hidden = YES;
        
        [NetOperation getPartnerTeamListWithParam:self.detailparam withblock:^(NSArray *orderlist, NSError *error) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            
            NSLog(@"count is:%d",[orderlist count]);
            if ([orderlist count]>1) {
                
//                CGRect rect =  calloutannotationview.frame;
//                rect.size.height = 120;
//                calloutannotationview.frame = rect;
                
                 calloutannotationview.mc.hidden = YES;
                calloutannotationview.ml.hidden = NO;
                calloutannotationview.ml.data = orderlist;
                calloutannotationview.ml.nav = self.navigationController;
           
                [calloutannotationview.ml.tableView reloadData];
               
            }else
            {
                calloutannotationview.mc.hidden = NO;
                calloutannotationview.ml.hidden = YES;
                
//                CGRect rect =  calloutannotationview.frame;
//                rect.size.height = 80;
//                calloutannotationview.frame = rect;
                
                calloutannotationview.mc.titlelb.text = good.title;
                calloutannotationview.mc.pricelb.text = [NSString stringWithFormat:@"%.1f",good.team_price] ;
                calloutannotationview.mc.discountlb.text = [NSString stringWithFormat:@"%.1f元",good.market_price] ;
                [calloutannotationview.mc.icon setImageWithURL:[NSURL URLWithString:good.imageurl]];
                [calloutannotationview.mc.btn addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
                calloutannotationview.mc.btn.tag = ann.gtag;
                
            }
            
        }];
        //开始设置添加marker时的赋值
        
        
     
        return calloutannotationview;
        
    }
    return nil;
}

-(void)goDetail:(UIButton *)sender
{
    
    SaleDetailViewController *sd = [[SaleDetailViewController alloc] init];
    Good *good = [self.data objectAtIndex:sender.tag];
    sd.good = good;
    [self.navigationController pushViewController:sd animated:YES];
    
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
    titlelb.text = @"地图模式";
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titlelb;
    
    UIButton *catbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    catbtn.frame = CGRectMake(0.0f, 0.0f, 51.0f, 32.0f);
    [catbtn setImage:[UIImage imageNamed:@"catbtn"] forState:UIControlStateNormal];
    [catbtn addTarget:self action:@selector(catAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *cp = [[UIBarButtonItem alloc] initWithCustomView:catbtn];
    self.navigationItem.rightBarButtonItem = cp;
    

    UIButton *bk = [UIButton buttonWithType:UIButtonTypeCustom];
    bk.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [bk setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [bk addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:bk];
    self.navigationItem.leftBarButtonItem = mp;
    
}

-(void)catAction:(id)sender
{
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        Category *cat = (Category *)selectedValue;
        if (cat.fid==-1) {
            [self.param setObject:[NSString stringWithFormat:@"%d",cat.parentID] forKey:@"groupId"];
            
        }else
        {
            [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"groupId"];
            
        }
        
        [self.param setObject:[NSString stringWithFormat:@"%d",cat.cid] forKey:@"subId"];
        [self loadData];
        
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *aera = [ad.cat objectForKey:@"category"];
    [ActionSheetStringPicker showPickerWithTitle:@"选择分类" rows:aera initialSelectionRow:0 initialSelectionComp:0 doneBlock:done cancelBlock:cancel origin:sender];
    
    
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
