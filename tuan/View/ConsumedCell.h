//
//  ConsumedCell.h
//  tuan
//
//  Created by foolish on 13-6-11.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsumedCell : UITableViewCell

@property(nonatomic,strong)UILabel *titlelb;
@property(nonatomic,strong)UILabel *desclb;
@property(nonatomic,strong)UILabel *truepricelb;
@property(nonatomic,strong)UILabel *discountlb;
@property(nonatomic,strong)UILabel *countlb;
@property(nonatomic,strong)UIButton *checkbtn;
@property(nonatomic,strong)UIButton *commentbtn;
@property(nonatomic,strong)UILabel *pricecount;
@property(nonatomic,strong)UILabel *expiretitle;
@property(nonatomic,strong)UILabel *expirelb;
@property(nonatomic,strong)UILabel *lb_orderid;


@property(nonatomic,strong)UIImageView *coverimg;

@end
