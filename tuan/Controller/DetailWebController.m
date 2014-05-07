//
//  DetailWebController.m
//  tuan
//
//  Created by foolish on 13-4-15.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "DetailWebController.h"

@interface DetailWebController ()

@end

@implementation DetailWebController
@synthesize url=_url;

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
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
   // [webView loadHTMLString:_html baseURL:nil];
    
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"详情";
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
