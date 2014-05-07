//
//  SaleDetailViewController.m
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "SaleDetailViewController.h"
#import "OrderViewController.h"
#import "OrderViewController2.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "GPUserManager.h"
#import "RegViewController.h"
#import "DetailWebController.h"
#import "NetOperation.h"
#import "StrikeThroughLabel.h"
#import "UIImageView+AFNetworking.h"
#import "NetBase.h"
#import "SVProgressHUD.h"
#import "PhoneBindViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "AppDelegate.h"
#import "ShopMapController.h"
#import "AFNetworking.h"
#import "Comment.h"
#import "CommentCell.h"
@interface SaleDetailViewController ()

@end

@implementation SaleDetailViewController
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
    self.isLoading = YES;
    
    //CLLocationCoordinate2D l = {35.01144,110.996075};
//    self.lat = 3501144;
//    self.lng = 110996075;
    [NetOperation getGoodDetailByID:[NSString stringWithFormat:@"%d",_good.gid] lat:self.lat lng:self.lng  withblock:^(Good *good, NSError *error) {
 
        [SVProgressHUD dismiss];
        self.isLoading = NO;
        if (!error) {
            _good = good;
            [self downloadImageInBackground:_good.imageurl];
            [self setUpView];
            [self.tableView reloadData];
        }
    }];
}

-(void)setUpView
{

    //tableview
    CGRect rec = self.view.bounds;
    self.tableView = [[UITableView alloc] initWithFrame:rec style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    [self.view addSubview:self.tableView];
    
    //cover image view
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 192.0f)];
    UIImageView *coverimg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 192.0f)];
    [coverimg setImageWithURL:[NSURL URLWithString:_good.imageurl] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
    [headerview addSubview:coverimg];
    UILabel *creditlb = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 0.0f, 70.0f, 30.0f)];
    creditlb.backgroundColor = [UIColor redColor];
    creditlb.textColor = [UIColor whiteColor];
    creditlb.text = [NSString stringWithFormat:@"返利%.2f元",_good.credit];
    creditlb.font = [Util parseFont:20.0f];
    creditlb.textAlignment = NSTextAlignmentCenter;
    [headerview addSubview:creditlb];
    if (_good.credit>0) {
        creditlb.hidden = NO;
    }else
    {
        creditlb.hidden = YES;
    }
    [self.tableView setTableHeaderView:headerview];
    
    //footer telephone
    UIView *telview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 88.0f)];
    telview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tel"]];
    UIButton *callbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    callbtn.frame = CGRectMake(0.0f, 0.0f, 320.0f, 88.0f);
    [telview addSubview:callbtn];
    [callbtn addTarget:self action:@selector(callserv:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = telview;
    
    self.collect = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collect.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [self isCollect];
    [self.collect addTarget:self action:@selector(goCollect:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *clt = [[UIBarButtonItem alloc] initWithCustomView:self.collect];
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [share setImage:[UIImage imageNamed:@"share_btn"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(goShare:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *clt2 = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    
    self.navigationItem.rightBarButtonItems = @[clt2,clt];

}

-(void)isCollect
{
    [NetOperation isCollectUID:[GPUserManager sharedClient].user.userid teamid:[NSString stringWithFormat:@"%d",_good.gid] withblock:^(BOOL success, NSError *error) {
        
        if (success) {
            
            [self.collect setImage:[UIImage imageNamed:@"collect_btn_hilighted"] forState:UIControlStateNormal];
            _good.iscollect = YES;
        }else
        {
            [self.collect setImage:[UIImage imageNamed:@"collect_btn"] forState:UIControlStateNormal];
            _good.iscollect = NO;
        }
        
    }];

}

-(void)callserv:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://7777777"]];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
   
    [SVProgressHUD show];
    //test
    self.lat = (NSInteger)([GPUserManager sharedClient].l.latitude*1000000);
    self.lng = (NSInteger)([GPUserManager sharedClient].l.longitude*1000000);
    
    [self loadData];

}


#pragma tableview delegate and datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
        
        case 2:
            return 1;
            break;
        
        case 3:
            return 1;
            break;
        case 4:
        {
            if ([_good.comment_list count]==1) {
                return 2;
            }
            if ([_good.comment_list count]==0) {
                return 0;
            }
            if ([_good.comment_list count]==2) {
                return 3;
            }
            
            return 4;
        }
            //评论列表
            break;
        case 5:
            return 1;
            break;
        case 6:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;

}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.section) {
        case 0:
            return 21;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 180;
            break;
        case 3:
            return 40;
            break;
        case 4:
        {
            if (indexPath.row==0||indexPath.row==3) {
                return 40;
            }
            else
            {
                return 80;
            }
        
        }
            break;
        case 5:
            return 40;
            break;
        case 6:
            return [self cellHeight];
            break;
            
        default:
            break;
    }
    
    return 0;
    
}

-(float)cellHeight
{
    
    NSString *notice = _good.notice;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15];
    CGSize size = CGSizeMake(300,2000);
    CGSize desclibsize = [notice sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    return desclibsize.height+50;

}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section==0) {
        
        UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        CGSize size = CGSizeMake(300,2000);
        CGSize labelsize = [_good.product sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
       
        UIFont *font2 = [UIFont fontWithName:@"Helvetica" size:14];
        CGSize size2 = CGSizeMake(300,2000);
        CGSize labelsize2 = [_good.title sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:NSLineBreakByWordWrapping];
        
        return labelsize.height+labelsize2.height+120;
    }
    return 0;
    
}
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    return  nil;

}

-(void)buyInfoCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    
    cell.backgroundView.layer.borderColor = [[UIColor clearColor] CGColor];
    UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 21.0f, 15.0f)];
    [icon1 setImage:[UIImage imageNamed:@"buy_num"]];
    
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(36.0f, 0.0f, 90.0f, 21.0f)];
    lb1.backgroundColor = [UIColor clearColor];
    lb1.text = [NSString stringWithFormat:@"%d人已购买",_good.now_number];
    lb1.font = [Util parseFont:20.3];
    
    UIImageView *icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(150.0f, 0.0f, 20.0f, 20.0f)];
    [icon2 setImage:[UIImage imageNamed:@"exp_icon"]];
    
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(176.0f, 0.0f, 90.0f, 21.0f)];
    lb2.backgroundColor = [UIColor clearColor];
    lb2.text = _good.exp_date;
    lb2.font = [Util parseFont:20.3];
    
    [cell.contentView addSubview:icon1];
    [cell.contentView addSubview:icon2];
    [cell.contentView addSubview:lb1];
    [cell.contentView addSubview:lb2];
    

}

-(void)goDetaiCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    
    cell.userInteractionEnabled = YES;

//    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 8.0f, 15.0f, 15.0f)];
//    [icon setImage:[UIImage imageNamed:@"taocan_icon"]];
//    [cell.contentView addSubview:icon];
//    
//    UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 7.0f, 160.0f, 21.0f)];
//    titlelbl.text = @"套餐";
//    titlelbl.backgroundColor = [UIColor clearColor];
//    titlelbl.font = [UIFont fontWithName:@"Helvetica" size:27.86/2]; //[Util parseFont:27.86];
//    [cell.contentView addSubview:titlelbl];
//    
//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 38.0f, 280.0f, 1.0f)];
//    line.backgroundColor = [UIColor grayColor];
//    [cell.contentView addSubview:line];
//    
//    UIButton *goDetail = [UIButton buttonWithType:UIButtonTypeCustom];
//    [goDetail addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
//    goDetail.tag = indexPath.section;
//    goDetail.frame = CGRectMake(10.0f, 44.0f, 280.0f, 30.0f);
//    [goDetail setTitle:@"查看图文详情 >>>" forState:UIControlStateNormal];
//    goDetail.titleLabel.font = [Util parseFont:20.3];
//    [goDetail setTitleColor:[UIColor colorWithRed:91.0f/255 green:141.0f/255 blue:255.0f/255 alpha:1.0f] forState:UIControlStateNormal];
//    [cell.contentView addSubview:goDetail];
//
  
    cell.backgroundView.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(75.0f, 2.0f, 137.0f, 42.0f);
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_common"] forState:UIControlStateNormal];
    [cell.contentView addSubview:btn];
    [btn addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    switch (indexPath.section) {
        case 1:
            [btn setTitle:@"本单详情" forState:UIControlStateNormal] ;
            btn.tag = 0;
            break;
        case 3:
            [btn setTitle:@"套餐简介" forState:UIControlStateNormal] ;
            btn.tag =1;
            break;
        case 5:
            [btn setTitle:@"公司简介" forState:UIControlStateNormal] ;
            btn.tag = 2;
            break;
        default:
            break;
    }
    
}

-(void)goDetail:(UIButton *)sender
{
    NSString *type = nil;
    switch (sender.tag) {
        case 0:
            type=@"bdxq";
            break;
        case 1:
            type = @"xmjj";
            break;
        case 2:
            type = @"gsjj";
            break;
            
        default:
            break;
    }
    
    NSString *url = [TEST_SERVER_BASE stringByAppendingString:@"TeamAction_getPropertyHtml?id="];
    url = [url stringByAppendingFormat:@"%d",_good.gid];
    url = [url stringByAppendingFormat:@"&property=%@",type];
    
    DetailWebController *dwc = [[DetailWebController alloc] init];
    dwc.url = url;
    [self.navigationController pushViewController:dwc animated:YES];
}

-(void)taoCanCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 8.0f, 20.0f, 20.0f)];
    [icon setImage:[UIImage imageNamed:@"shopinfo"]];
    [cell.contentView addSubview:icon];
    
    UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 7.0f, 160.0f, 21.0f)];
    titlelbl.text = @"商家信息";
    titlelbl.backgroundColor = [UIColor clearColor];
    titlelbl.font = [UIFont fontWithName:@"Helvetica" size:27.86/2]; //[Util parseFont:27.86];
    [cell.contentView addSubview:titlelbl];
    
    UIImageView *antline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ant_line"]];
    antline.frame=CGRectMake(10.0f, 33.0f, 280.0f, 1.0f);
    antline.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:antline];
    
    UILabel *namelb = [[UILabel alloc] initWithFrame:CGRectMake(17.0f, 43.0f, 240.0f, 21.0f)];
    namelb.backgroundColor = [UIColor clearColor];
    namelb.font = [UIFont fontWithName:@"Helvetica" size:27.8/2];
    namelb.text = _good.partnerTitle;
    
    UILabel *addresslb = [[UILabel alloc] initWithFrame:CGRectMake(17.0f, 64.0f, 240.0f, 40.0f)];
    addresslb.font = [UIFont fontWithName:@"Helvetica" size:25.0f/2];
    addresslb.numberOfLines = 2;
    addresslb.textColor = [UIColor colorWithRed:166.0f/255 green:166.0f/255 blue:166.0f/255 alpha:1.0f];
    addresslb.text = _good.shopAddress;
    addresslb.backgroundColor = [UIColor clearColor];
    
    UILabel *buslb = [[UILabel alloc] initWithFrame:CGRectMake(17.0f, 104.0f, 240.0f, 40.0f)];
    buslb.font = [UIFont fontWithName:@"Helvetica" size:25.0f/2];
    buslb.numberOfLines = 2;
    buslb.textColor = [UIColor colorWithRed:166.0f/255 green:166.0f/255 blue:166.0f/255 alpha:1.0f];
    buslb.text = _good.traffic;
    buslb.backgroundColor = [UIColor clearColor];
    
    UIButton *shopmapbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopmapbtn.frame = CGRectMake(17.0f, 43.0f, 240.0f, 90.0f);
    [shopmapbtn addTarget:self action:@selector(shopMapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *disicon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"distance_icon"]];
    disicon.frame = CGRectMake(17.0f, 148.0f, 11.0f, 20.0f);
    [cell.contentView addSubview:disicon];
    
    UILabel *distancelb = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 146.0f, 240.0f, 21.0f)];
    distancelb.font = [UIFont fontWithName:@"Helvetica" size:25.0f/2];
    distancelb.backgroundColor = [UIColor clearColor];
    distancelb.textColor = [UIColor colorWithRed:166.0f/255 green:166.0f/255 blue:166.0f/255 alpha:1.0f];
    distancelb.text = _good.distStr;
    distancelb.backgroundColor = [UIColor clearColor];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(257.0f, 43.0f, 1.0f, 110.0f)];
    line.backgroundColor = [UIColor blackColor];
    
    UIButton *gocall = [UIButton buttonWithType:UIButtonTypeCustom];
    gocall.frame = CGRectMake(264.0f, 61.0f, 30.0f, 50.0f);
    [gocall setImage:[UIImage imageNamed:@"call_icon"] forState:UIControlStateNormal];
    [gocall addTarget:self action:@selector(goCall:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.contentView addSubview:namelb];
    [cell.contentView addSubview:addresslb];
    [cell.contentView addSubview:line];
    [cell.contentView addSubview:gocall];
    [cell.contentView addSubview:distancelb];
    [cell.contentView addSubview:buslb];
    [cell.contentView addSubview:shopmapbtn];
    
    
}

-(void)shopMapAction:(id)sender
{
    ShopMapController *sc = [[ShopMapController alloc] init];
    sc.good = _good;
    [self.navigationController pushViewController:sc animated:YES];

}

-(void)goCall:(id)sender
{

    NSString *url = [NSString stringWithFormat:@"tel://"];
    url = [url stringByAppendingFormat:@"%@",_good.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}

-(void)autoLogin
{
    
    self.view.userInteractionEnabled = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [UserOperation loginWithUserName:[GPUserManager sharedClient].user.email password:[GPUserManager sharedClient].user.password withblock:^(User *user, NSError *error) {
        
        self.view.userInteractionEnabled = YES;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (!error) {
            [LocalDB storeUserInfo:user];
            [GPUserManager sharedClient].user = user;
            [GPUserManager sharedClient].accessToken = user.userkey;
            [GPUserManager sharedClient].needAutoLogin = NO;
            
        }
        else
        {
            
        }
        
        
    }];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx00"];
    //cell.textLabel.text = @"xxoox";
   // cell.userInteractionEnabled = NO;
    cell.backgroundColor = [UIColor whiteColor];
    //cell.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    //cell.contentView.layer.shadowOffset = CGSizeMake(280.0f, 1.0f);
    //cell.layer.shadowOpacity = 0.5;
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    //cell.backgroundView.backgroundColor = [UIColor whiteColor];
    //cell.backgroundView.layer.shadowColor = [[UIColor grayColor] CGColor];
    //cell.backgroundView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    //cell.backgroundView.layer.shadowOpacity = YES;
    cell.backgroundView.layer.borderWidth = 0.6f;
    cell.backgroundView.layer.borderColor = [[UIColor grayColor] CGColor];
    //cell.backgroundView.backgroundColor = [UIColor redColor];
    //cell.backgroundView.layer.cornerRadius = 0.1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 0:
            [self buyInfoCell:cell indexPath:indexPath];
            break;
        case 1:
            [self goDetaiCell:cell indexPath:indexPath];
            break;
        case 2:
            [self taoCanCell:cell indexPath:indexPath];
            break;
        case 3:
            [self goDetaiCell:cell indexPath:indexPath];
            break;
        case 4:
        {
            if (indexPath.row==0) {
                
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 8.0f, 20.0f, 20.0f)];
                [icon setImage:[UIImage imageNamed:@"shopinfo"]];
                [cell.contentView addSubview:icon];
                
                UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 7.0f, 160.0f, 21.0f)];
                titlelbl.text = @"商品评论";
                titlelbl.backgroundColor = [UIColor clearColor];
                titlelbl.font = [UIFont fontWithName:@"Helvetica" size:27.86/2]; //[Util parseFont:27.86];
                [cell.contentView addSubview:titlelbl];
                
            }
            if (indexPath.row==3&&([_good.comment_list count]>2)) {
                UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 7.0f, 160.0f, 21.0f)];
                titlelbl.text = @"查看更多>>>";
                titlelbl.textColor = [UIColor colorWithRed:44.0f/255 green:145.0f/255 blue:178.0f/255 alpha:1.0f];
                titlelbl.backgroundColor = [UIColor clearColor];
                titlelbl.font = [UIFont fontWithName:@"Helvetica" size:30/2]; //[Util parseFont:27.86];
                [cell.contentView addSubview:titlelbl];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = cell.contentView.bounds;
                [btn addTarget:self action:@selector(moreComment:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];
                
            }else if(indexPath.row==1||indexPath.row==2)
            {
                // Initialization code
                UILabel *lb_user = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 250.0f, 21.0f)];
                lb_user.textColor = [UIColor redColor];
                lb_user.font = [UIFont fontWithName:@"Helvetica" size:15];
                
                UILabel *lb_content = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 32.0f, 260.0f, 21.0f)];
                lb_content.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
                
                UILabel *lb_time = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 54.0f, 260.0f, 21.0f)];
                lb_time.font = [UIFont fontWithName:@"Helvetica" size:15];
                // self.lb_time.textColor = [UIColor colorWithRed:144.0f green:144.0f blue:144.0f alpha:1.0f];
                lb_time.textColor = [UIColor grayColor];
                
                
                lb_user.backgroundColor = [UIColor clearColor];
                lb_content.backgroundColor = [UIColor clearColor];
                lb_time.backgroundColor = [UIColor clearColor];
                
                [cell.contentView addSubview:lb_user];
                [cell.contentView  addSubview:lb_content];
                [cell.contentView addSubview:lb_time];
//                CommentCell *ccell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx00"];
//                NSLog(@"indexes:%d,%d",indexPath.section,indexPath.row);
                Comment *comment = [_good.comment_list objectAtIndex:indexPath.row-1];
                lb_user.text = comment.username;
                lb_content.text = comment.comment_content;
                lb_time.text = comment.comment_time;
//                return ccell;
            
            }
            
           
        }
            break;
        case 5:
            [self goDetaiCell:cell indexPath:indexPath];
            break;
        case 6:
            [self noticeCell:cell indexPath:indexPath];
            break;
            
        default:
            break;
    }
   
    
    
    return cell;

}

-(void)moreComment:(id)sender
{

    CommentListController *clv = [[CommentListController alloc] init];
    clv.hidesBottomBarWhenPushed = YES;
    clv.comments = _good.comment_list;
    [self.navigationController pushViewController:clv animated:YES];

}

-(void)noticeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    
    NSString *notice = _good.notice;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 8.0f, 15.0f, 15.0f)];
    [icon setImage:[UIImage imageNamed:@"taocan_icon"]];
    [cell.contentView addSubview:icon];
    
    UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 7.0f, 160.0f, 21.0f)];
    titlelbl.text = @"购买须知";
    titlelbl.backgroundColor = [UIColor clearColor];
    titlelbl.font = [UIFont fontWithName:@"Helvetica" size:27.86/2]; //[Util parseFont:27.86];
    [cell.contentView addSubview:titlelbl];
    
    UIImageView *antline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ant_line"]];
    antline.frame=CGRectMake(10.0f, 33.0f, 280.0f, 1.0f);
    antline.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:antline];
    
    /*
    UILabel *contentlb = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [contentlb setNumberOfLines:0];
    contentlb.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15];
    CGSize size = CGSizeMake(300,2000);
    contentlb.font = font;
    CGSize desclibsize = [notice sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    contentlb.frame = CGRectMake(0.0f,titlelbl.frame.origin.y+titlelbl.frame.size.height+10,desclibsize.width,desclibsize.height);
    contentlb.text = notice;
    contentlb.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:contentlb];
     */
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15];
    CGSize size = CGSizeMake(300,2000);
    CGSize desclibsize = [notice sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rec = CGRectMake(0.0f,titlelbl.frame.origin.y+titlelbl.frame.size.height+10,desclibsize.width,desclibsize.height);
    
    UIWebView *noticeweb = [[UIWebView alloc] initWithFrame:rec];
    [noticeweb  loadHTMLString:notice baseURL:nil];
    //noticeweb.scrollView.scrollEnabled = NO;
    noticeweb.backgroundColor = [UIColor clearColor];
    noticeweb.opaque = NO;
    [cell.contentView addSubview:noticeweb];
    

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (section==0) {
        
        UIView *sheader = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 200.0f)];
        sheader.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
        
       //price view
        UIView *priceview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 57.0f)];
        priceview.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
        
        UIImageView *buyinfoline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyinfo_line"]];
        buyinfoline.frame = CGRectMake(0.0f, 52.0f, 320.0f, 5.0f);
        [priceview addSubview:buyinfoline];
        
        CGSize cutsize = CGSizeMake(320,30);
        UIFont *cutfont = [UIFont fontWithName:@"Helvetica-Bold" size:30.0f];
        CGSize cutdis = [[NSString stringWithFormat:@"%.2f",_good.team_price] sizeWithFont:cutfont constrainedToSize:cutsize lineBreakMode:NSLineBreakByWordWrapping];
       // CGSize cutdis = [[NSString stringWithFormat:@"105.00"] sizeWithFont:cutfont constrainedToSize:cutsize lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rec = CGRectMake(3.0f, 19.0f, cutdis.width, 30.0f);
        
        
        UILabel *lbcutprice = [[UILabel alloc] initWithFrame:rec];
        lbcutprice.backgroundColor = [UIColor clearColor];
        lbcutprice.textColor = [UIColor colorWithRed:44.0f/255 green:145.0f/255 blue:178.0f/255 alpha:1.0f];
        lbcutprice.font = cutfont;
        lbcutprice.text = [NSString stringWithFormat:@"%.2f",_good.team_price];

        
        UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(lbcutprice.frame.origin.x+lbcutprice.frame.size.width, 32.0f, 16.0f, 14.0f)];
        yuan.backgroundColor = [UIColor clearColor];
        yuan.textColor = [UIColor colorWithRed:44.0f/255 green:145.0f/255 blue:178.0f/255 alpha:1.0f];
        yuan.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.0f];;
        yuan.text = @"元";
        
        StrikeThroughLabel *trueprice = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(yuan.frame.origin.x+yuan.frame.size.width+2, 30.0f, 60.0f, 15.0f)];
        trueprice.backgroundColor = [UIColor clearColor];
        trueprice.textColor = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        trueprice.font = [Util parseFont:22];
        [trueprice setStrikeThroughEnabled:YES];
        trueprice.lineBreakMode = NSLineBreakByClipping;
        trueprice.text = [NSString stringWithFormat:@"%.2f元",_good.market_price];
        
        UIButton *btnbuy = [UIButton buttonWithType:UIButtonTypeCustom];
        if ((_good.teamState==STATE_EXPIRED)||(_good.teamState==STATE_PENDING)) {
            [btnbuy setImage:[UIImage imageNamed:@"buy_end"] forState:UIControlStateNormal];
            [btnbuy setEnabled:NO];
        }
        else if ((_good.teamState==STATE_OUT)||(_good.teamState==STATE_OUTNUMBER)) {
            [btnbuy setImage:[UIImage imageNamed:@"buy_out"] forState:UIControlStateNormal];
            [btnbuy setEnabled:NO];
            
        }else{
            [btnbuy setImage:[UIImage imageNamed:@"btn_buy"] forState:UIControlStateNormal];
            
        }
    
     
        [btnbuy setFrame:CGRectMake(172.0f, 10.0f, 134.0f, 40.0f)];
        [btnbuy addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
        [priceview addSubview:btnbuy];
        [priceview addSubview:lbcutprice];
        [priceview addSubview:yuan];
        [priceview addSubview:trueprice];
        
        [sheader addSubview:priceview];
        
        
        //desc view
        UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        [titlelb setNumberOfLines:0];
        titlelb.lineBreakMode = NSLineBreakByWordWrapping;
        UIFont *font1 = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        titlelb.font = font1;
        CGSize size = CGSizeMake(300,2000);
        CGSize labelsize = [_good.product sizeWithFont:font1 constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        titlelb.frame = CGRectMake(10.0f,13.0f,labelsize.width,labelsize.height);
        titlelb.text = _good.product;
        titlelb.backgroundColor = [UIColor clearColor];
        
        UILabel *desclb = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        [desclb setNumberOfLines:0];
        CGSize size2 = CGSizeMake(300,2000);
        UIFont *font2 = [UIFont fontWithName:@"Helvetica" size:14];
        desclb.lineBreakMode = NSLineBreakByWordWrapping;
        desclb.font = font2;
        NSString *cntt = _good.title;
        CGSize desclibsize = [cntt sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:NSLineBreakByWordWrapping];
        desclb.frame = CGRectMake(10.0f,titlelb.frame.origin.y+titlelb.frame.size.height+10,desclibsize.width,desclibsize.height);
        desclb.text = cntt;
        desclb.backgroundColor = [UIColor clearColor];
//
        //退款条件
        UIImageView *tui = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, desclb.frame.origin.y+desclb.frame.size.height+10, 17.0f, 17.0f)];
        [tui setImage:[UIImage imageNamed:@"tui"]];
        
        UILabel *tuilb = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, desclb.frame.origin.y+desclb.frame.size.height+10, 100.0f, 21.0f)];
        tuilb.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
        tuilb.textColor = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        tuilb.backgroundColor = [UIColor clearColor];
        
        if (_good.allowrefund) {
            tuilb.text = @"支持随时退款";
            [tui setImage:[UIImage imageNamed:@"tui"]];
        }else
        {
            tuilb.text = @"不支持随时退款";
            [tui setImage:[UIImage imageNamed:@"butui"]];
        }
        
        UIImageView *tui2 = [[UIImageView alloc] initWithFrame:CGRectMake(142.0f, desclb.frame.origin.y+desclb.frame.size.height+10, 17.0f, 17.0f)];
        [tui2 setImage:[UIImage imageNamed:@"tui"]];
         UILabel *tuilb2 = [[UILabel alloc] initWithFrame:CGRectMake(162.0f, desclb.frame.origin.y+desclb.frame.size.height+10, 120.0f, 21.0f)];
        tuilb2.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
        tuilb2.textColor = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        tuilb2.backgroundColor = [UIColor clearColor];
        
        if (!_good.booking) {
            tuilb2.text = @"无需预订";
            [tui2 setImage:[UIImage imageNamed:@"butui"]];
        }else
        {
            tuilb2.text = @"需要预订";
            [tui2 setImage:[UIImage imageNamed:@"tui"]];
        }
        
        UIView *descview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 58.0f, 320.0f, desclb.frame.origin.y+desclb.frame.size.height+30)];
        [descview addSubview:titlelb];
        [descview addSubview:desclb];
        [descview addSubview:tui];
        [descview addSubview:tui2];
        [descview addSubview:tuilb];
        [descview addSubview:tuilb2];
        [sheader addSubview:descview];
        
        
        
        return sheader;
        
    }

    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}
-(void)loadOrder
{
    
    [SVProgressHUD show];
    [NetOperation OrderBuyWithUid:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey teamid:_good.gid withblock:^(Order *order, NSError *error) {
        [SVProgressHUD dismiss];
        
        if (!error) {
            if (_good.delivery==EXPRESS) {
                OrderViewController2 *orderv = [[OrderViewController2 alloc] init];
                orderv.order = order;
                [self.navigationController pushViewController:orderv animated:YES];
            }else if(_good.delivery==COUPON)
            {
                OrderViewController *odv = [[OrderViewController alloc] init];
                odv.order = order;
                [self.navigationController pushViewController:odv animated:YES];
                
            }
        }else
        {
            if (error.code==-4) {
                UIAlertView *choice = [[UIAlertView alloc] initWithTitle:@"请绑定手机" message:@"您未帮定手机，不能购买，是否现在帮定？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                choice.tag = 22222;
                [choice show];
            }else
            {
            UIAlertView *choice = [[UIAlertView alloc] initWithTitle:@"提示" message:@"达到购买上限，赶快去关注其它产品吧~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
         
            [choice show];
            }
        }
            
        
    }];
    
    
}

-(void)buy:(id)sender
{
    
    if ([[GPUserManager sharedClient] isLogin]) {
        [self loadOrder];
    }
    else
    {
        UIAlertView *choice = [[UIAlertView alloc] initWithTitle:@"请登录后继续购买" message:@"" delegate:self cancelButtonTitle:@"有账号，现在登陆" otherButtonTitles:@"没账号，马上注册", nil];
        choice.tag = 11111;
        [choice show];
    
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==22222) {
        if (buttonIndex==0) {
            PhoneBindViewController *pb = [[PhoneBindViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pb];
            
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
        if (buttonIndex==1) {
            
         
        }
    }
    if (alertView.tag==11111) {
        if (buttonIndex==0) {
            LoginViewController *loginv = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginv];
            
            [self presentViewController:nav animated:YES completion:^{
                
                //  OrderViewController *orderv = [[OrderViewController alloc] init];
                //  [self.navigationController pushViewController:orderv animated:YES];
            }];
        }
        if (buttonIndex==1) {
            
            RegViewController *regv = [[RegViewController alloc] init];
            [GPUserManager sharedClient].needAutoLogin = YES;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:regv];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
  

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    
    if ([GPUserManager sharedClient].needAutoLogin) {
        [self autoLogin];
    }
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"团购详情";
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titlelb;
    
    UIButton *bk = [UIButton buttonWithType:UIButtonTypeCustom];
    bk.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [bk setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [bk addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:bk];
    self.navigationItem.leftBarButtonItem = mp;
    
   
    
}



-(void)goCollect:(id)sender
{

    if ([[GPUserManager sharedClient] isLogin]) {

        if (_good.iscollect) {
            [NetOperation decollectWithUID:[GPUserManager sharedClient].user.userid userkey:[GPUserManager sharedClient].user.userkey teamid:[NSString stringWithFormat:@"%d",_good.gid] withblock:^(BOOL success, NSError *error) {
                if (success) {
                    [self.collect setImage:[UIImage imageNamed:@"collect_btn"] forState:UIControlStateNormal];
                    _good.iscollect = NO;
                    UIAlertView *choice = [[UIAlertView alloc] initWithTitle:@"取消成功" message:@"取消收藏成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [choice show];
                }
            }];

        }else
        {
            [NetOperation addCollectWithUid:[GPUserManager sharedClient].user.userid key:[GPUserManager sharedClient].user.userkey teamid:_good.gid withblock:^(BOOL success, NSError *error) {
                if (success) {
                    [self.collect setImage:[UIImage imageNamed:@"collect_btn_hilighted"] forState:UIControlStateNormal];
                    _good.iscollect = YES;
                    UIAlertView *choice = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:@"恭喜您，收藏成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                    [choice show];
                }
                
                
            }];
        
        }
    
        
        
    }
    else
    {
        UIAlertView *choice = [[UIAlertView alloc] initWithTitle:@"请登录后继续购买" message:@"" delegate:self cancelButtonTitle:@"有账号，现在登陆" otherButtonTitles:@"没账号，马上注册", nil];
        choice.tag = 11111;
        
        [choice show];
        
    }
}



- (void)downloadImageInBackground:(NSString *)imagurl{
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imagurl]];
    
  
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
        self.imagedata = UIImageJPEGRepresentation(image, 30);
    }];
    
    [operation start];
}

-(void)goShare:(id)sender
{
    
    //定义菜单分享列表
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeTencentWeibo, ShareTypeRenren, ShareTypeKaixin, ShareTypeSohuWeibo, ShareType163Weibo,ShareTypeWeixiSession, nil];
    
    //创建分享内容
    NSString *sharecontent = _good.title;
    sharecontent = [sharecontent stringByAppendingFormat:@"http://tuan.ycss.com/team.php?id=%d",_good.gid];
    
   // UIImage *image = [UIImage ima];
    
    NSLog(@"the image url is:%@",_good.imageurl);
    
    id<ISSContent> publishContent = [ShareSDK content:sharecontent
                                       defaultContent:@""
                                                image:[ShareSDK imageWithData:self.imagedata fileName:@"精品团" mimeType:@"jpg"]
                                                title:@"运城搜搜团"
                                                  url:@"http://tuan.ycss.com"
                                          description:@"来自运城搜搜团"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //显示分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:[ShareSDK authOptionsWithAutoAuth:YES
                                                       allowCallback:YES
                                                       authViewStyle:SSAuthViewStyleModal
                                                        viewDelegate:nil
                                             authManagerViewDelegate:nil]
                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                          oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                           qqButtonHidden:NO
                                                    wxSessionButtonHidden:NO
                                                   wxTimelineButtonHidden:NO
                                                     showKeyboardOnAppear:NO
                                                        shareViewDelegate:nil
                                                      friendsViewDelegate:nil
                                                    picViewerViewDelegate:nil]
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

-(void)goBack:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
