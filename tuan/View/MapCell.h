//
//  MapCell.h
//  tuan
//
//  Created by foolish on 13-4-28.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"

@interface MapCell : UIView

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titlelb;
@property(nonatomic,strong)UILabel *pricelb;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIImageView *accessory;
@property(nonatomic,strong)StrikeThroughLabel *discountlb;

@end
