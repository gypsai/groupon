//
//  NearbyViewController.m
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "NearbyViewController.h"
#import "SaleDetailViewController.h"
#import "NetOperation.h"
#import "UIImageView+AFNetworking.h"
#import "NearbyMapController.h"
#import "GPUserManager.h"
#import "ActionSheetStringPicker.h"
#import "AppDelegate.h"
#import "Category.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

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
    
    self.nonlb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
    self.nonlb.text = @"对不起，没有相关商品~";
    self.nonlb.center = self.view.center;
    self.nonlb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nonlb];
    self.nonlb.hidden = YES;
    
    self.pullToRefreshEnabled = YES;
    self.data = [[NSMutableArray alloc] init];
    self.param = [[NSMutableDictionary alloc] init];
    self.lv= [[LoadStatusView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    self.lv.backgroundColor = [UIColor whiteColor];
    
    self.footerView = self.lv;
    
    self.hv = [[LoadStatusView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    self.hv.backgroundColor = [UIColor whiteColor];
    self.headerView = self.hv;
    
    [self loadData];
    
}


#pragma mark - Pull to Refresh

- (void) addItemsOnTop
{
    NSLog(@"start loading refresh!");
    [self refreshData];
    // [self refreshCompleted];
}


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

-(void)reloadData
{
    self.data = nil;
    self.data = [[NSMutableArray alloc] init];
    [self loadData];
    
}

-(void)refreshData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.isLoading = YES;
    self.hv.lbstatus.text = @"正在加载......";
    [self.hv.activityV startAnimating];
    
    self.lat = (NSInteger)([GPUserManager sharedClient].l.latitude*1000000);
    self.lng = (NSInteger)([GPUserManager sharedClient].l.longitude*1000000);
    [self.param setObject:[NSNumber numberWithInteger:self.lat] forKey:@"lat"];
    [self.param setObject:[NSNumber numberWithInteger:self.lng] forKey:@"lng"];
    [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"index"];
    [self.param setObject:[NSNumber numberWithInt:10] forKey:@"size"];
    
    self.lv.hidden = NO;
    [NetOperation getNearByTeamListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.isLoading = NO;
        [self refreshCompleted];
    
        self.data = (NSMutableArray *)orderlist;
        if ([self.data count]==0) {
            self.lv.hidden = YES;
            self.nonlb.hidden= NO;
            
        }
        [self.tableView reloadData];
        
    }];

}

-(void)loadData
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.isLoading = YES;
    self.lv.lbstatus.text = @"正在加载......";
    [self.lv.activityV startAnimating];
    
    self.lat = (NSInteger)([GPUserManager sharedClient].l.latitude*1000000);
    self.lng = (NSInteger)([GPUserManager sharedClient].l.longitude*1000000);
    [self.param setObject:[NSNumber numberWithInteger:self.lat] forKey:@"lat"];
    [self.param setObject:[NSNumber numberWithInteger:self.lng] forKey:@"lng"];
    [self.param setObject:[NSString stringWithFormat:@"%d",[self.data count]] forKey:@"index"];
    [self.param setObject:[NSNumber numberWithInt:10] forKey:@"size"];
    
         self.lv.hidden = NO;
    [NetOperation getNearByTeamListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.isLoading = NO;
        [self loadMoreCompleted];
        if ([orderlist count]==0) {
            self.canLoadMore = NO;
            self.lv.lbstatus.text = @"没有更多了";
        }
        self.data = (NSMutableArray *)[self.data arrayByAddingObjectsFromArray:orderlist];
        if ([self.data count]==0) {
            self.lv.hidden = YES;
            self.nonlb.hidden= NO;
        
        }
        [self.tableView reloadData];
        
    }];

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
    Good *good = [self.data objectAtIndex:indexPath.row];
    
    SaleCell *cell = [[SaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx00"];
    
    cell.titlelb.text = good.partnerTitle;
    cell.discriplb.text = good.product;
    cell.truepricelb.text =[NSString stringWithFormat:@"%.2f",good.team_price];
    cell.discountlb.text =  [NSString stringWithFormat:@"%.2f",good.market_price];
    cell.countlb.text = good.distStr;
    [cell.coverimg setImageWithURL:[NSURL URLWithString:good.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
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
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SaleDetailViewController *salev = [[SaleDetailViewController alloc] init];
    salev.hidesBottomBarWhenPushed = YES;
    salev.good = [self.data objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:salev animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"我附近的";
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
    self.navigationItem.leftBarButtonItem = cp;

    UIButton *mapbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mapbtn.frame = CGRectMake(0.0f, 0.0f, 51.0f, 32.0f);
    [mapbtn setImage:[UIImage imageNamed:@"btn_map"] forState:UIControlStateNormal];
    [mapbtn addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:mapbtn];
    self.navigationItem.rightBarButtonItem = mp;
    
}

-(void)catAction:(id)sender
{
    self.nonlb.hidden= YES;
    self.canLoadMore = YES;
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        Category *cat = (Category *)selectedValue;
        if (cat.fid==-1) {
            [self.param setObject:[NSString stringWithFormat:@"%d",cat.parentID] forKey:@"groupId"];
            
        }else
        {
            [self.param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"groupId"];
            
        }
        
        [self.param setObject:[NSString stringWithFormat:@"%d",cat.cid] forKey:@"subId"];
        [self reloadData];
        
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
    
    NearbyMapController *mpv = [[NearbyMapController alloc] init];
    mpv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mpv animated:YES];
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
