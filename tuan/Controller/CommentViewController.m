//
//  CommentViewController.m
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "CommentViewController.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import <QuartzCore/QuartzCore.h>

@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize orderid=_orderid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)subAction:(id)sender
{
    
    //Integer userid            评价人ID
    //String  userkey           评价人的登录后的密钥
    //Integer orderid           订单ID
    //String  comment_grade     满意度("good"--满意；"none"--一般；"bad"--失望)
    //String  comment_wantmore  愿意再去(Y-是；N-否)
    //String  comment_content   点评内容
    [self.param setObject:[GPUserManager sharedClient].user.userid forKey:@"userid"];
    [self.param setObject:[GPUserManager sharedClient].user.userkey forKey:@"userkey"];
    [self.param setObject:self.orderid forKey:@"orderid"];
    
    NSArray *grade = @[@"满意",@"一般",@"失望"];
    [self.param setObject:[grade objectAtIndex:self.isconf] forKey:@"comment_grade"];
    [self.param setObject:self.tf_comment.text forKey:@"comment_content"];
    
    NSString *yon;
    if (self.isback==0) {
        yon = @"Y";
    }
    if (self.isback==1) {
        yon = @"N";
    }
    [self.param setObject:yon forKey:@"comment_wantmore"];
    
    [NetOperation commentWithParams:self.param withblock:^(BOOL success, NSError *error) {
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评价成功" message:@"感谢您的评价，我们讲继续改进！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.param = [[NSMutableDictionary alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scro = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    UIImageView *bgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"commentbg"]];
    bgv.frame = CGRectMake(10.0f, 10.0f, 278.0f, 223.0f);
    [self.scro addSubview:bgv];
    
    
    UISegmentedControl *seg1 = [[UISegmentedControl alloc] initWithItems:@[@"满意",@"一般",@"不满意"]];
    [seg1 addTarget:self action:@selector(seg1Action:) forControlEvents:UIControlEventValueChanged];
    seg1.frame = CGRectMake(20.0f, 90.0f, 280.0f, 30.0f);
    seg1.selectedSegmentIndex = 0;
    [self.scro addSubview:seg1];
    
    UISegmentedControl *seg2 = [[UISegmentedControl alloc] initWithItems:@[@"是",@"否"]];
    seg2.frame = CGRectMake(20.0f, 160.0f, 150.0f, 30.0f);
    [seg2 addTarget:self action:@selector(seg2Action:) forControlEvents:UIControlEventValueChanged];
    seg2.selectedSegmentIndex = 0;
    [self.scro addSubview:seg2];
    
    
    self.tf_comment = [[UITextField alloc] initWithFrame:CGRectMake(12.0f, 240.0f, 280.0f, 30.0f)];
    self.tf_comment.borderStyle = UITextBorderStyleLine;
    self.tf_comment.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tf_comment.tag = 2;
    self.tf_comment.layer.borderColor = [[UIColor colorWithRed:160.0f/255 green:160.0f/255 blue:160.0f/255 alpha:1.0f] CGColor];
    self.tf_comment.delegate = self;
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(32.0f, 300.0f, 256.0f, 43.0f);
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setBackgroundImage:[UIImage imageNamed:@"submitcomment"] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scro addSubview:self.tf_comment];
    [self.scro addSubview:submit];
    [self.view addSubview:self.scro];
	// Do any additional setup after loading the view.
}

-(void)seg1Action:(UISegmentedControl *)sender
{
    self.isconf = sender.selectedSegmentIndex;
    
}

-(void)seg2Action:(UISegmentedControl *)sender
{
    self.isback = sender.selectedSegmentIndex;
    
}




-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
       CGSize size= self.scro.contentSize;
        size.height +=300;
        
        self.scro.contentSize = size;
        self.scro.contentOffset = CGPointMake(0.0f, size.height-200);
    
        return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
        CGSize size= self.scro.contentSize;
        size.height -=300;
        self.scro.contentSize = size;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)viewWillAppear:(BOOL)animated
{

    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"评价";
    self.navigationItem.titleView = titlelb;
    
    
    UIButton *bk = [UIButton buttonWithType:UIButtonTypeCustom];
    bk.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [bk setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [bk addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:bk];
    self.navigationItem.leftBarButtonItem = mp;


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
