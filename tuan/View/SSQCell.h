//
//  SSQCell.h
//  tuan
//
//  Created by foolish on 13-4-21.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSQCell : UITableViewCell

@property(nonatomic,strong)UILabel *titlelb;
@property(nonatomic,strong)UILabel *desclb;
@property(nonatomic,strong)UILabel *pricecount;
@property(nonatomic,strong)UILabel *discountlb;
@property(nonatomic,strong)UILabel *countlb;
@property(nonatomic,strong)UILabel *expirelb;
@property(nonatomic,strong)UILabel *secrettitle;
@property(nonatomic,strong)UILabel *secret;
@property(nonatomic,strong)UIButton *btndetail;
@property(nonatomic,strong)UIButton *btnreturn;
@property(nonatomic,strong)UILabel *expiretitle;


@property(nonatomic,strong)UIImageView *coverimg;


@end
