//
//  Category.h
//  tuan
//
//  Created by foolish on 13-4-15.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

//{
//    "childCategoryList": null,
//    "count": 902,
//    "czone": null,
//    "display": null,
//    "ename": null,
//    "fid": null,
//    "id": "0",
//    "letter": null,
//    "name": "全部分类",
//    "relate_data": null,
//    "sort_order": null,
//    "zone": null
//},

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *ename;
@property(nonatomic,assign)NSInteger fid;
@property(nonatomic,assign)NSInteger cid;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSArray *childCategoryList;
@property(nonatomic,assign)BOOL hasChild;
@property(nonatomic,assign)NSInteger parentID;

-(id)initWithDic:(NSDictionary *)dic;
+(NSArray *)parseThirdType;

@end
