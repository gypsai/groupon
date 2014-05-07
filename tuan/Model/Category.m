//
//  Category.m
//  tuan
//
//  Created by foolish on 13-4-15.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "Category.h"

@implementation Category
@synthesize name=_name;
@synthesize ename=_ename;
@synthesize fid=_fid;
@synthesize cid=_cid;
@synthesize childCategoryList=_childCategoryList;
@synthesize count=_count;
@synthesize hasChild=_hasChild;

-(id)initWithDic:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"name"];
        self.ename = [dic objectForKey:@"ename"];
        
        if ([dic objectForKey:@"fid"]==[NSNull null]) {
            self.fid = -1;
        }else
        {
            self.fid = [[dic objectForKey:@"fid"] integerValue];
            
        }
        
        self.cid = [[dic objectForKey:@"id"] integerValue];
        if ([dic objectForKey:@"count"]!=[NSNull null]) {
        
            self.count = [[dic objectForKey:@"count"] integerValue];
            
        }
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if ([dic objectForKey:@"childCategoryList"]!=[NSNull null]) {
            for (NSDictionary *cdic in [dic objectForKey:@"childCategoryList"]) {
                Category *ca = [[Category alloc] initWithDic:cdic];
                ca.parentID = self.cid;
                [arr addObject:ca];
            }
            self.childCategoryList = arr;
             self.hasChild = true;
        }else
        {
             self.hasChild = false;
        }
        
        
    }
    
    return self;
    
}

+(NSArray *)parseThirdType
{

    NSMutableArray *tp = [[NSMutableArray alloc] init];
    
    Category *cat0 = [[Category alloc] init];
    cat0.cid = 0;
    cat0.name = @"默认排序";
    cat0.hasChild = false;
    
    Category *cat1 = [[Category alloc] init];
    cat1.cid = 1;
    cat1.name = @"人气下降";
    cat1.hasChild = false;
    
    Category *cat2 = [[Category alloc] init];
    cat2.cid = 2;
    cat2.name = @"折扣上升";
    cat2.hasChild = false;
    
    Category *cat3 = [[Category alloc] init];
    cat3.cid = 3;
    cat3.name = @"价格上升";
    cat3.hasChild = false;
    
    Category *cat4 = [[Category alloc] init];
    cat3.cid = 4;
    cat3.name = @"距离排序";
    cat3.hasChild = false;
    
    [tp addObject:cat0];
    [tp addObject:cat1];
    [tp addObject:cat2];
    [tp addObject:cat3];
    [tp addObject:cat4];
    
    return tp;
    
}

@end
