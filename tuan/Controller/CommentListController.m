//
//  CommentListController.m
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "CommentListController.h"
#import "Comment.h"

@interface CommentListController ()

@end

@implementation CommentListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.comments count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sfa"];
    
    // Initialization code
    UILabel *lb_user = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 250.0f, 21.0f)];
    lb_user.textColor = [UIColor redColor];
    lb_user.font = [UIFont fontWithName:@"Helvetica" size:15];
    
    UILabel *lb_content = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 36.0f, 260.0f, 21.0f)];
    lb_content.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    UILabel *lb_time = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 62.0f, 260.0f, 21.0f)];
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
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    
    lb_user.text = comment.username;
    lb_content.text = comment.comment_content;
    lb_time.text = comment.comment_time;

    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    
    CGFloat h = [self cellHeight:comment.comment_content];
    
    return h+70;

}

-(float)cellHeight:(NSString *)content
{
    
    NSString *notice = content;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15];
    CGSize size = CGSizeMake(300,2000);
    CGSize desclibsize = [notice sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    return desclibsize.height;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    titlelb.text = @"所有评价";
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


@end
