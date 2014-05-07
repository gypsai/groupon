//
//  MapList.m
//  tuan
//
//  Created by foolish on 13-7-5.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "MapList.h"
#import "SaleDetailViewController.h"


@implementation MapList
@synthesize data=_data;
@synthesize tableView=_tableView;
@synthesize nav=_nav;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        
//        CGRect rect =  self.tableView.frame;
//        rect.size.height = 120;
//        self.tableView.frame = rect;
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self addSubview:self.tableView];
    
    
    }
    

    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mapcell"];
    Good *good = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.text = good.title;
    cell.textLabel.font = [Util parseFont:17];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        Good *good = [self.data objectAtIndex:indexPath.row];
    SaleDetailViewController *sd = [[SaleDetailViewController alloc] init];
    sd.good = good;
    [self.nav pushViewController:sd animated:YES];

}

@end
