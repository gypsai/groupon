//
//  SaleCell.h
//  tuan
//
//  Created by foolish on 13-4-2.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"

@interface SaleCell : UITableViewCell

@property(nonatomic,strong)UILabel *titlelb;
@property(nonatomic,strong)UILabel *discriplb;
@property(nonatomic,strong)UILabel *truepricelb;
@property(nonatomic,strong)StrikeThroughLabel *discountlb;
@property(nonatomic,strong)UILabel *countlb;
@property(nonatomic,strong)UIImageView *isnewimg;
@property(nonatomic,strong)UILabel *creditlb;


@property(nonatomic,strong)UIImageView *coverimg;

@end
