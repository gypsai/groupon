//
//  MoreViewController.m
//  tuan
//
//  Created by foolish on 13-4-1.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutController.h"
#import "NetOperation.h"
#import "AboutPayController.h"
#import "FeedBackController.h"
#import "ActionSheetTimePicker.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

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
    
    //tableview
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    [self.view addSubview:self.tableView];
    
	// Do any additional setup after loading the view.
}

#pragma tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   
    return 6;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellorder"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
//        case 0:
//           cell.textLabel.text = @"分享设置";
//            
//            break;
        case 0:
        {
        
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 150.0f, 21.0f)];
            title.backgroundColor= [UIColor clearColor];
            title.text = @"每日新单提醒";
            [cell.contentView addSubview:title];
            
            UISwitch *switchbtn = [[UISwitch alloc] initWithFrame:CGRectMake(200.0f, 5.0f, 100.0f, 30.0f)];
            [switchbtn addTarget:self action:@selector(notifySwitch:) forControlEvents:UIControlEventValueChanged];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *isNoti = [defaults objectForKey:@"isNoti"];
            if ([isNoti isEqualToString:@"YES"]) {
                switchbtn.on = YES;
            }else
            {
                switchbtn.on = NO;
            }
            [cell.contentView addSubview:switchbtn];
            
        }
            break;
        case 1:
        {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 100.0f, 21.0f)];
            title.backgroundColor= [UIColor clearColor];
            title.text = @"提醒时间";
            [cell.contentView addSubview:title];
            
             self.lbnotitime = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 5.0f, 100.0f, 30.0f)];
            self.lbnotitime.backgroundColor = [UIColor clearColor];
            
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *notitime = [defaults objectForKey:@"NotiTime"];
            NSString *hour = [[notitime componentsSeparatedByString:@" "] objectAtIndex:1];
            self.lbnotitime.text = hour;
            [cell.contentView addSubview:self.lbnotitime];
            
            UIButton *pickTime = [UIButton buttonWithType:UIButtonTypeCustom];
            pickTime.frame = cell.contentView.frame;
            [pickTime addTarget:self action:@selector(pickTime:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:pickTime];
            
        }
            break;
        case 2:
          
            cell.textLabel.text = @"关于搜搜";
            break;
        case 3:
            
            cell.textLabel.text = @"检查更新";
            
            break;
        case 4:
            cell.textLabel.text = @"意见反馈";
            break;
        case 5:
            cell.textLabel.text = @"支付帮助";
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

-(void)notifySwitch:(UISwitch *)sender
{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (sender.on==YES) {
        
        [defaults setObject:@"YES" forKey:@"isNoti"];
        [defaults synchronize];
        [self sendNoti];
    }else
    {
        [defaults setObject:@"NO" forKey:@"isNoti"];
        [defaults synchronize];
        [self sendNoti];
    }


}

-(void)sendNoti
{
    
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in notifications ) {
        NSArray *arr = [notification.userInfo  allKeys];
        NSLog(@"notifys time:%@",notification.fireDate);
        for (NSString *a in arr) {
            NSLog(@"notifys %@",a);
        }
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    [app cancelAllLocalNotifications];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
    NSString *isNoti = [defaults objectForKey:@"isNoti"];
    NSString *notiTime = [defaults objectForKey:@"NotiTime"];
    
    
  
    if ([isNoti isEqualToString:@"NO"]) {
    
        return;
    }
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // 设置notification的属性
    localNotification.fireDate = [Util parseFromString:notiTime]; //出发时间
    
    
    localNotification.alertBody = @"运城搜搜每日新单"; // 消息内容
    localNotification.repeatInterval = NSDayCalendarUnit; // 重复的时间间隔,每天
    localNotification.soundName = UILocalNotificationDefaultSoundName; // 触发消息时播放的声音
    localNotification.applicationIconBadgeNumber = 1; //应用程序Badge数目
    
    // 设置随Notification传递的参数
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"key", @"abcdefg", @"phone", @"hahah", nil];
    localNotification.userInfo = infoDict;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification]; //注册
    


}

-(void)datetest:(NSDate *)date
{

    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/yyy hh:mm"];
   
    NSString *datestr = [formatter stringFromDate:date];
    
    NSLog(@"datetest:%@",datestr);
}

-(void)pickTime:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *isNoti = [defaults objectForKey:@"isNoti"];
    
    if ([isNoti isEqualToString:@"NO"]) {
        return;
    }

    ActionStringDoneBlock done = ^(ActionSheetTimePicker *picker, NSInteger selectedIndex, id selectedValue) {
       
        NSLog(@"select time is:%@",selectedValue);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"M/d/yyy"];
        NSDate *date = [NSDate date];
        NSString *datestr = [formatter stringFromDate:date];
        datestr = [datestr stringByAppendingFormat:@" %@",selectedValue];
        
        [defaults setObject:datestr forKey:@"NotiTime"];
        [defaults synchronize];
        
        
        [self.tableView reloadData];
        
        [self sendNoti];
        
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetTimePicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
  
    [ActionSheetTimePicker showPickerWithTitle:@"选择时间" rows:nil initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    

}
-(void)setAboutV
{

    AboutController *abv = [[AboutController alloc] init];
    abv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:abv animated:YES];
}

-(void)checkVersion
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新版本" message:@"您目前已经是最新版本了喔" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        [alert show];
//    [NetOperation getVersionWithBlock:^(NSString *version, NSError *error) {
//        
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *localversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//        
//        NSLog(@"localversion is:%@",localversion);
//        
//        if (![version isEqualToString:localversion]) {
//            
//            NSString *cnt = [NSString stringWithFormat:@"检测到新版本%@,是否更新？",version];
//            UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:@"新版本" message: cnt delegate:self cancelButtonTitle:@"暂不" otherButtonTitles: @"更新", nil];
//            [createUserResponseAlert show];
//        }else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新版本" message:@"您目前已经是最新版本了喔" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
//            [alert show];
//        }
//        
//        
//    }];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        NSString *iTunesLink = @"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=284417350&mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
        {
        
            
        }
            break;
        case 2:
            [self setAboutV];
            break;
            
        case 3:
            [self checkVersion];
            break;
        case 4:
        {
            FeedBackController *fb = [[FeedBackController alloc] init];
            fb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fb animated:YES];
            
        }
            break;
       case 5:
        {
            AboutPayController *btp = [[AboutPayController alloc] init];
            btp.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:btp animated:YES];
            
        }
            break;
        default:
            break;
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"更多";
    self.navigationItem.titleView = titlelb;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
