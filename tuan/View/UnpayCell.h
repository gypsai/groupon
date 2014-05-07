//
//  UnpayCell.h
//  tuan
//
//  Created by foolish on 13-4-20.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnpayCell : UITableViewCell

@property(nonatomic,strong)UILabel *titlelb;
@property(nonatomic,strong)UILabel *desclb;
@property(nonatomic,strong)UILabel *truepricelb;
@property(nonatomic,strong)UILabel *discountlb;
@property(nonatomic,strong)UILabel *countlb;
@property(nonatomic,strong)UIButton *paybtn;
@property(nonatomic,strong)UIButton *removebtn;
@property(nonatomic,strong)UILabel *pricecount;
@property(nonatomic,strong)UILabel *expiretitle;
@property(nonatomic,strong)UILabel *expirelb;


@property(nonatomic,strong)UIImageView *coverimg;


@end
