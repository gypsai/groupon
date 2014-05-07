//
//  TuanViewController.m
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "TuanViewController.h"
#import "SaleDetailViewController.h"
#import "SaleCell.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetStringPicker.h"
#import "AppDelegate.h"
#import "Category.h"
#import "DetailWebController.h"
#import "UIImageView+AFNetworking.h"
#import "GPUserManager.h"
#import "UserOperation.h"
#import "NearbyMapController.h"


@interface TuanViewController ()


@end

@implementation TuanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)getAdds
{

    [UserOperation getAddWithBlock:^(NSArray *urls, NSError *error) {
        
        self.adds = urls;
        
        [self.csView reloadData];
    }];
}

-(void)setSelectBar
{
    
    UIView *selectbar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 36.0f)];
    [self.view addSubview:selectbar];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn1 addTarget:self action:@selector(selecttype:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"sel1"] forState:UIControlStateNormal];
    self.btn1.frame = CGRectMake(0.0f, 0.0f, 106.0f, 36.0f);
    [self.btn1 setTitle:@"全部分类" forState:UIControlStateNormal];
    self.btn1.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn1.tag = 1;
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn2 addTarget:self action:@selector(selecttype:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"sel2"] forState:UIControlStateNormal];
    [self.btn2 setTitle:@"全部区域" forState:UIControlStateNormal];
    self.btn2.titleLabel.tag = 0;
    self.btn2.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn2.frame = CGRectMake(106.0f, 0.0f, 107.0f, 36.0f);
    self.btn2.tag = 2;
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn3 addTarget:self action:@selector(selecttype:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"sel3"] forState:UIControlStateNormal];
    [self.btn3 setTitle:@"默认排序" forState:UIControlStateNormal];
    self.btn3.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn3.frame = CGRectMake(213.0f, 0.0f, 107.0f, 36.0f);
    self.btn3.tag = 3;
    
    [selectbar addSubview:self.btn1];
    [selectbar addSubview:self.btn2];
    [selectbar addSubview:self.btn3];
    
    
    [self.view addSubview:selectbar];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImageView *cover = [[UIImageView alloc] initWithFrame:CGRectMake];
//    cover.image = [UIImage imageNamed:@"main_cover"];
//    [self.view addSubview:cover];
//    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.notifydelegate = self;
    
    
    self.nonlb= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 250.0f, 30.0f)];
    self.nonlb.text = @"对不起，没有找到团购商品~";
    self.nonlb.textAlignment = NSTextAlignmentCenter;
    self.nonlb.center = self.view.center;
    [self.view addSubview:self.nonlb];
    self.nonlb.hidden = YES;
    
    [self getAdds];
    
    
    [self setSelectBar];
    
    CGRect rec = self.view.bounds;
    rec.origin.y += 36.0f;
    rec.size.height -= 36.0f;
    self.tableView.frame = rec;
    
     self.csView=[[XLCycleScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.f)];
    
    self.csView.delegate = self;
    self.csView.datasource = self;
    self.tableView.tableHeaderView = self.csView;
    
     self.param = [[NSMutableDictionary alloc] init];
    [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"groupId"];
    [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"cityId"];
    [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"orderType"];
    
    self.pullToRefreshEnabled = YES;
    self.data = [[NSMutableArray alloc] init];
    self.lv= [[LoadStatusView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    self.lv.backgroundColor = [UIColor whiteColor];
    self.footerView = self.lv;
    
    self.hv = [[LoadStatusView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    self.hv.backgroundColor = [UIColor whiteColor];
    self.headerView = self.hv;
    
    
   [self loadData];
   [self getUserLocation];
  	// Do any additional setup after loading the view.
}

- (NSInteger)numberOfPages
{
    return [self.adds count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.f)];
    NSString *url = [[self.adds objectAtIndex:index] objectForKey:@"image"];
    [view setImageWithURL:[NSURL URLWithString:url]];
    
    return view;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    
}

-(void)reloadData
{
   
    
    [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"index"];
    [self.param setObject:@"10" forKey:@"size"];
    
    NSInteger lat = (NSInteger)([GPUserManager sharedClient].l.latitude*1000000);
    NSInteger lng = (NSInteger)([GPUserManager sharedClient].l.longitude*1000000);
    
    [self.param setObject:[NSNumber numberWithInteger:lat] forKey:@"lat"];
    [self.param setObject:[NSNumber numberWithInteger:lng] forKey:@"lng"];
    self.lv.lbstatus.text = @"正在加载......";
    [self.lv.activityV startAnimating];
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.lv.hidden = NO;
    
    [NetOperation getGoodListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
        self.isLoading = NO;
        if (!error) {
            
            
            NSLog(@"params|| index:%@,size:%@,title:%@,ordertype:%@,groupid:%@,subid:%@,cityid:%@",[self.param objectForKey:@"index"],[self.param objectForKey:@"size"],[self.param objectForKey:@"title"],[self.param objectForKey:@"orderType"],[self.param objectForKey:@"groupId"],[self.param objectForKey:@"subId"],[self.param objectForKey:@"cityId"]);
            NSLog(@"count:%d",[orderlist count]);
            
            self.data = (NSMutableArray *)orderlist;
            
            if ([self.data count]==0) {
                self.nonlb.hidden = NO;
                self.lv.hidden = YES;
            }
            [self.tableView reloadData];
            //  [self loadTestData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self loadMoreCompleted];
            
        }else
        {
            
        }
        
    }];

    
}

-(void)refreshData
{

    [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"index"];
    [self.param setObject:@"10" forKey:@"size"];
    
    NSInteger lat = (NSInteger)([GPUserManager sharedClient].l.latitude*1000000);
    NSInteger lng = (NSInteger)([GPUserManager sharedClient].l.longitude*1000000);
    
    [self.param setObject:[NSNumber numberWithInteger:lat] forKey:@"lat"];
    [self.param setObject:[NSNumber numberWithInteger:lng] forKey:@"lng"];
    self.hv.lbstatus.text = @"正在加载......";
    [self.hv.activityV startAnimating];
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.hv.hidden = NO;
    
    [NetOperation getGoodListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
        self.isLoading = NO;
        if (!error) {
            
            
            NSLog(@"params|| index:%@,size:%@,title:%@,ordertype:%@,groupid:%@,subid:%@,cityid:%@",[self.param objectForKey:@"index"],[self.param objectForKey:@"size"],[self.param objectForKey:@"title"],[self.param objectForKey:@"orderType"],[self.param objectForKey:@"groupId"],[self.param objectForKey:@"subId"],[self.param objectForKey:@"cityId"]);
            NSLog(@"count:%d",[orderlist count]);
            
            self.data = (NSMutableArray *)orderlist;
            
            [self.tableView reloadData];
           
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self refreshCompleted];
            
        }else
        {
            
        }
        
    }];

    

}


- (void) addItemsOnTop
{
    NSLog(@"start loading refresh!");
     [self refreshData];
    // [self refreshCompleted];
}



-(void)loadData
{
    
    [self.param setObject:[NSString stringWithFormat:@"%d",[self.data count]] forKey:@"index"];
    [self.param setObject:@"10" forKey:@"size"];
    
    NSInteger lat = (NSInteger)([GPUserManager sharedClient].l.latitude*1000000);
    NSInteger lng = (NSInteger)([GPUserManager sharedClient].l.longitude*1000000);
    
    [self.param setObject:[NSNumber numberWithInteger:lat] forKey:@"lat"];
    [self.param setObject:[NSNumber numberWithInteger:lng] forKey:@"lng"];
    self.lv.lbstatus.text = @"正在加载......";
    [self.lv.activityV startAnimating];
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.lv.hidden = NO;

    [NetOperation getGoodListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
        self.isLoading = NO;
        if (!error) {
            
            
            NSLog(@"params|| index:%@,size:%@,title:%@,ordertype:%@,groupid:%@,subid:%@,cityid:%@",[self.param objectForKey:@"index"],[self.param objectForKey:@"size"],[self.param objectForKey:@"title"],[self.param objectForKey:@"orderType"],[self.param objectForKey:@"groupId"],[self.param objectForKey:@"subId"],[self.param objectForKey:@"cityId"]);
            NSLog(@"count:%d",[orderlist count]);
            
            [self.data addObjectsFromArray:orderlist];
            if ([self.data count]==0) {
                self.nonlb.hidden = NO;
                self.lv.hidden = YES;
            }
            [self.tableView reloadData];
          //  [self loadTestData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self loadMoreCompleted];
            if ([orderlist count]==0) {
                self.canLoadMore = NO;
                self.lv.lbstatus.text = @"没有更多了";
            }
            
            
        }else
        {
            
        }
        
    }];
    
    
}

-(void)getUserLocation
{

    [UserOperation getCityIDwithlat:[NSString stringWithFormat:@"%f",[GPUserManager sharedClient].l.latitude] lng:[NSString stringWithFormat:@"%f",[GPUserManager sharedClient].l.longitude] withblock:^(NSDictionary *dict, NSError *error) {
        
        NSString *cid = [dict objectForKey:@"cityid"];
        NSString *cname = [dict objectForKey:@"name"];
        if ([dict objectForKey:@"cityid"]==[NSNull null]) {
            cid = @"0";
        }
        
        if ([dict objectForKey:@"name"]==[NSNull null]) {
            cname = @"全部区域";
        }
        
        NSLog(@"the data is:%@,%@",cid,cname);
        [self.param setObject:cid forKey:@"cityId"];
        
        self.btn2.titleLabel.text = cname;
        self.btn2.titleLabel.tag = [cid integerValue];
        [self reloadData];
    }];
}




#pragma mark - Pull to Refresh

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
    [super pinHeaderView];
    self.hv.lbstatus.text = @"loading。。。。。。";
    [self.hv.activityV startAnimating];
    // do custom handling for the header view
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
    [super unpinHeaderView];
    self.hv.lbstatus.text = @"加载完成";
    [self.hv.activityV stopAnimating];
    // do custom handling for the header view
    //[[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Update the header text while the user is dragging
//
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    
    if (willRefreshOnRelease)
        self.hv.lbstatus.text = @"释放刷新...";
    else
        self.hv.lbstatus.text = @"下拉刷新...";
    
//    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
//    if (willRefreshOnRelease)
//        hv.title.text = @"Release to refresh...";
//    else
//        hv.title.text = @"Pull down to refresh...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// refresh the list. Do your async calls here.
//
- (BOOL) refresh
{
    if (![super refresh])
        return NO;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self addItemsOnTop];
    
    return YES;
}


#pragma stable

- (void) willBeginLoadingMore
{
    
    self.lv.lbstatus.text=@"释放开始加载......";
    self.lv.lbstatus.hidden = NO;
    
    
    
}

- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    self.lv.lbstatus.text = @"上拉加载更多......";
    [self.lv.activityV stopAnimating];
    
    if (!self.canLoadMore) {
        
    }
    
}

- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    self.lv.lbstatus.text = @"正在加载......";
    [self.lv.activityV startAnimating];
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:0.0];
    // DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    // fv.infoLabel.text = @"正在加载";
    // fv.infoLabel.hidden = NO;
    
    return YES;
}

-(void)dropLoadMore
{
    self.lv.lbstatus.text = @"上拉加载更多......";
    
}

- (void) addItemsOnBottom
{
    
    [self loadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.data count];
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SaleCell *cell = [[SaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx00"];
    Good *good = [self.data objectAtIndex:indexPath.row];
    
    cell.titlelb.text = good.partnerTitle;
    cell.discriplb.text = good.product;
    cell.truepricelb.text = [NSString stringWithFormat:@"%.2f",good.team_price];
    cell.discountlb.text = [NSString stringWithFormat:@"%.2f元",good.market_price];
    cell.countlb.text = good.buy_number_str;
    if (good.isNew) {
        cell.isnewimg.hidden = NO;
    }else
    {
        cell.isnewimg.hidden = YES;
    }
    if (good.credit>0) {
        cell.creditlb.hidden = NO;
        cell.creditlb.text = [NSString stringWithFormat:@"返利%.2f元",good.credit];
        
    }else
    {
        cell.creditlb.hidden= YES;
    }
    
    
    [cell.coverimg setImageWithURL:[NSURL URLWithString:good.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SaleDetailViewController *slv = [[SaleDetailViewController alloc] init];
    slv.hidesBottomBarWhenPushed = YES;
    slv.good = [self.data objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:slv animated:YES];
}



-(void)selecttype:(UIButton *)seg
{
    
    self.canLoadMore = YES;
    self.nonlb.hidden = YES;
    
    if (seg.enabled) {
        seg.enabled = NO;
    }
    
    switch (seg.tag) {
        case 1:
            [self changeType:seg];
            break;
        case 2:
            [self changeAera:seg];
            break;
        case 3:
            [self changeOrder:seg];
            break;
            
        default:
            break;
    }

}

-(void)changeType:(UIButton*)sender
{
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        sender.enabled = YES;
        
        Category *cat = (Category *)selectedValue;
        if (cat.fid==-1) {
            [self.param setObject:[NSString stringWithFormat:@"%d",cat.parentID] forKey:@"groupId"];
            
        }else
        {
            [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"groupId"];
            
        }
        
        [self.param setObject:[NSString stringWithFormat:@"%d",cat.cid] forKey:@"subId"];
         self.btn1.titleLabel.text = cat.name;
        [self reloadData];
          
 
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
            sender.enabled = YES;
    };
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [NetOperation getAllCatgoryWithCityID:[NSString stringWithFormat:@"%d",self.btn2.titleLabel.tag] withblock:^(NSArray *cat, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error||([ cat count]==0)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没找到分类" message:@"对不起没有找到相关分类" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else
        {
          [ActionSheetStringPicker showPickerWithTitle:@"选择分类" rows:cat initialSelectionRow:0 initialSelectionComp:0 doneBlock:done cancelBlock:cancel origin:self.btn1];
        }
      
    }];
    

    
}

-(void)changeAera:(UIButton*)sender
{
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
           sender.enabled = YES;
        
        Category *cat = (Category *)selectedValue;
        NSLog(@"Block Picker select name:%@",cat.name);
        
        [self.param setObject:[NSString stringWithFormat:@"%d",cat.cid] forKey:@"cityId"];
       
        self.btn2.titleLabel.text = cat.name;
        self.btn2.titleLabel.tag = cat.cid;
        [self reloadData];
          
        
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
            sender.enabled = YES;
    };
    AppDelegate *ad = [UIApplication sharedApplication].delegate;
    NSArray *aera = [ad.cat objectForKey:@"region"];
    [ActionSheetStringPicker showPickerWithTitle:@"选择区域" rows:aera initialSelectionRow:0 initialSelectionComp:0 doneBlock:done cancelBlock:cancel origin:self.btn2];

    

}

-(void)changeOrder:(UIButton*)sender
{
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            sender.enabled = YES;
        Category *cat = (Category *)selectedValue;
        NSLog(@"Block Picker select name:%@",cat.name);
        
        [self.param setObject:[NSString stringWithFormat:@"%d",cat.cid] forKey:@"orderType"];
       
        self.btn3.titleLabel.text = cat.name;
        [self reloadData];
         
        
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
            sender.enabled = YES;
    };
    
    
    
    NSArray *aera = [Category parseThirdType];
    
    [ActionSheetStringPicker showPickerWithTitle:@"排序方式" rows:aera initialSelectionRow:0 initialSelectionComp:0 doneBlock:done cancelBlock:cancel origin:self.btn3];

    

}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    self.navigationController.navigationBarHidden = NO;

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *titlev = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 65.0f, 36.0f)];
    [titlev setImage:[UIImage imageNamed:@"logo"]];
    self.navigationItem.titleView = titlev;
    
    UIButton *mapbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mapbtn.frame = CGRectMake(0.0f, 0.0f, 51.0f, 32.0f);
    [mapbtn setImage:[UIImage imageNamed:@"btn_map"] forState:UIControlStateNormal];
    [mapbtn addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:mapbtn];
    self.navigationItem.leftBarButtonItem = mp;
    
    UIButton *searchbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchbtn.frame = CGRectMake(0.0f, 0.0f, 51.0f, 32.0f);
    [searchbtn setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(goSearch:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sp = [[UIBarButtonItem alloc] initWithCustomView:searchbtn];
    self.navigationItem.rightBarButtonItem = sp;
    
    
}


-(void)goMap:(id)sender
{
    
//    MapViewController *mpv = [[MapViewController alloc] init];
//    mpv.hidesBottomBarWhenPushed = YES;
//    mpv.param = self.param;
//    [self.navigationController pushViewController:mpv animated:YES];
    
    NearbyMapController *nmp = [[NearbyMapController alloc] init];
    nmp.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nmp animated:YES];
    
}

-(void)goSearch:(id)sender
{

    SearchViewController *sv = [[SearchViewController alloc] init];
    sv.hidesBottomBarWhenPushed = YES;
    sv.param = [[NSMutableDictionary alloc] init];
    [sv.param addEntriesFromDictionary:self.param];
    [self.navigationController pushViewController:sv animated:YES];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
