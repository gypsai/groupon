//
//  AboutController.m
//  tuan
//
//  Created by foolish on 13-4-20.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

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
    
    self.view.backgroundColor=[UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    CGRect rec = self.view.bounds;
    rec.size.height -=44;
    UIImageView *aboutv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 443.0f)];
    [aboutv setImage:[UIImage imageNamed:@"about"]];
    
    UIScrollView *scro = [[UIScrollView alloc] initWithFrame:rec];
    scro.contentSize = CGSizeMake(320.0f, 443.0f);
    [scro addSubview:aboutv];
    
    [self.view addSubview:scro];

//    UIImageView *aboutv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 443.0f)];
//    [aboutv setImage:[UIImage imageNamed:@"about"]];
//    self.view.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
//    [self.view addSubview:aboutv];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{

    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"关于";
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
