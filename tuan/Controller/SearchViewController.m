//
//  SearchViewController.m
//  tuan
//
//  Created by foolish on 13-4-4.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "SearchViewController.h"
#import "SaleCell.h"
#import "NetOperation.h"
#import "SaleDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize param=_param;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setTag
{
    
    CGRect rec = self.view.bounds;
    rec.size.height -= 36;
    rec.origin.y += 36;
    
     self.tagv = [[UIView alloc] initWithFrame:rec];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn1.layer.borderWidth = 1.0f;
    [btn1 setTitle:@"电影" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(15.0f, 30.0f, 85.0f, 36.0f);
    [btn1 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1;
    [self.tagv addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn2.layer.borderWidth = 1.0f;
    [btn2 setTitle:@"温泉" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(115.0f, 30.0f, 85.0f, 36.0f);
    [btn2 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 2;
    [self.tagv addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn3.layer.borderWidth = 1.0f;
    [btn3 setTitle:@"蛋糕" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn3.frame = CGRectMake(215.0f, 30.0f, 85.0f, 36.0f);
    [btn3 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag = 3;
    [self.tagv addSubview:btn3];
   
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn4.layer.borderWidth = 1.0f;
    [btn4 setTitle:@"酒吧" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn4.frame = CGRectMake(15.0f, 85.0f, 85.0f, 36.0f);
    [btn4 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = 4;
    [self.tagv addSubview:btn4];
    
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn5.layer.borderWidth = 1.0f;
    [btn5 setTitle:@"美甲" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn5.frame = CGRectMake(115.0f, 85.0f, 85.0f, 36.0f);
    [btn5 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn5.tag = 5;
    [self.tagv addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn6.layer.borderWidth = 1.0f;
    [btn6 setTitle:@"酒店" forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn6.frame = CGRectMake(215.0f, 85.0f, 85.0f, 36.0f);
    [btn6 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn6.tag = 6;
    [self.tagv addSubview:btn6];
    
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn7.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn7.layer.borderWidth = 1.0f;
    [btn7 setTitle:@"火锅" forState:UIControlStateNormal];
    [btn7 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn7.frame = CGRectMake(15.0f, 140.0f, 85.0f, 36.0f);
    [btn7 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn7.tag = 7;
    [self.tagv addSubview:btn7];
    
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn8.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn8.layer.borderWidth = 1.0f;
    [btn8 setTitle:@"美发" forState:UIControlStateNormal];
    [btn8 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn8.frame = CGRectMake(115.0f, 140.0f, 85.0f, 36.0f);
    [btn8 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn8.tag = 8;
    [self.tagv addSubview:btn8];
    
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn9.layer.borderColor = [[UIColor colorWithRed:155.0f/255 green:155.0f/255 blue:155.0f/255 alpha:0.6f] CGColor];
    btn9.layer.borderWidth = 1.0f;
    [btn9 setTitle:@"KTV" forState:UIControlStateNormal];
    [btn9 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn9.frame = CGRectMake(215.0f, 140.0f, 85.0f, 36.0f);
    [btn9 addTarget:self action:@selector(tagSearch:) forControlEvents:UIControlEventTouchUpInside];
    btn9.tag = 9;
    [self.tagv addSubview:btn9];

    
    
    
    [self.view addSubview:self.tagv];

}

-(void)tagSearch:(UIButton *)sender
{

    NSArray *tags = @[@"电影",@"温泉",@"蛋糕",@"酒吧",@"美甲",@"酒店",@"火锅",@"美发",@"KTV"];
    self.searchBar.text = [tags objectAtIndex:sender.tag-1];
    [self.param setObject:[tags objectAtIndex:sender.tag-1] forKey:@"title"];
    self.data = nil;
    self.data = [[NSMutableArray alloc] init];
    self.canLoadMore = YES;
    [self loadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nonlb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)];
    self.nonlb.text = @"没有相关数据~";
    self.nonlb.textAlignment = NSTextAlignmentCenter;
    self.nonlb.center = self.view.center;
    self.nonlb.hidden = YES;
    [self.view addSubview:self.nonlb];
    
    self.searchBar  = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 36.0f)];
    self.searchBar.delegate = self;
   // [self.searchBar setBackgroundImage:[UIImage imageNamed:@"searchbarbg"]];
   // [self.searchBar setTranslucent:YES];
    self.searchBar.tintColor = [UIColor colorWithRed:219.0f/255 green:219.0f/255 blue:219.0f/255 alpha:1.0f];
    [self.view addSubview:self.searchBar];
    
    [self setTag];
    
    CGRect rec = self.view.bounds;
    rec.size.height -= 36;
    rec.origin.y += 36;
    self.tableView.frame = rec;
    
    self.pullToRefreshEnabled = NO;
    self.data = [[NSMutableArray alloc] init];
    self.lv= [[LoadStatusView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    self.lv.backgroundColor = [UIColor whiteColor];
    self.footerView = self.lv;
    
    //self.param = [[NSMutableDictionary alloc] init];
    //[self loadData];
    // Do any additional setup after loading the view.
}

-(void)loadData
{
    
    
    [self.param setObject:[NSString stringWithFormat:@"%d",[self.data count]] forKey:@"index"];
    [self.param setObject:@"10" forKey:@"size"];
    self.lv.lbstatus.text = @"正在加载......";
    [self.lv.activityV startAnimating];
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    self.tagv.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.lv.hidden = NO;
    
    [NetOperation getGoodListWithParam:self.param withblock:^(NSArray *orderlist, NSError *error) {
        
        self.isLoading = NO;
        if (!error) {
            
            NSLog(@"params|| index:%@,size:%@,title:%@,ordertype:%@,groupid:%@,cityid:%@",[self.param objectForKey:@"index"],[self.param objectForKey:@"size"],[self.param objectForKey:@"title"],[self.param objectForKey:@"orderType"],[self.param objectForKey:@"groupId"],[self.param objectForKey:@"cityId"]);
            NSLog(@"count:%d",[orderlist count]);
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self loadMoreCompleted];
            if ([orderlist count]==0) {
                self.canLoadMore = NO;
                self.lv.lbstatus.text = @"没有更多了";
            }
            self.data = (NSMutableArray *)[self.data arrayByAddingObjectsFromArray:orderlist];
            if ([self.data count]==0) {
                self.lv.hidden = YES;
                self.nonlb.hidden = NO;
            }
            [self.tableView reloadData];
            
        }else
        {
            
        }
        
    }];
    
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.data = nil;
    self.data = [[NSMutableArray alloc] init];
    self.canLoadMore = YES;
    self.nonlb.hidden = YES;
    [self.param setObject:self.searchBar.text forKey:@"title"];
    [self loadData];
    [self.searchBar resignFirstResponder];

}



#pragma stable

- (void) willBeginLoadingMore
{
    if ([self.param objectForKey:@"title"]==nil) {
        
        self.canLoadMore = NO;
        
        return;
    }
    else
    {
    
        self.canLoadMore = YES;
    
    }
    
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
    cell.truepricelb.text =[NSString stringWithFormat:@"%.2f",good.team_price];
    cell.discountlb.text = [NSString stringWithFormat:@"%.2f",good.market_price];
    cell.countlb.text = good.buy_number_str;
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



-(void)viewWillAppear:(BOOL)animated
{


    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"搜索";
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
