//
//  CallOutAnnotationView.h
//  tuan
//
//  Created by foolish on 13-4-27.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "BMKAnnotationView.h"
#import "MapCell.h"
#import "MapList.h"

@interface CallOutAnnotationView : BMKAnnotationView


@property(nonatomic,retain) UIView *contentView;
@property(nonatomic,strong)MapCell *mc;
@property(nonatomic,strong)MapList *ml;

@end
