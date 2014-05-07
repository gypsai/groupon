//
//  OrderViewController2.m
//  tuan
//
//  Created by foolish on 13-4-24.
//  Copyright (c) 2013年 gypsai. All rights reserved.
//

#import "OrderViewController2.h"
#import "OrderEnsureViewController.h"
#import "NetOperation.h"
#import "GPUserManager.h"
#import "SVProgressHUD.h"
#define NUM_TAG_2 123131212

@interface OrderViewController2 ()

@end

@implementation OrderViewController2
@synthesize order=_order;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)showView
{
    
    //tableview
    CGRect rec = self.view.bounds;
    rec.size.height -= 49;
    self.tableView = [[UITableView alloc] initWithFrame:rec style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:246.0f/255 alpha:1.0f];
    [self.view addSubview:self.tableView];
    
    self.buynum = 1;
    
    UIView *footerv = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    //footerv.backgroundColor = [UIColor greenColor];
    UIButton *btnbuy = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnbuy setImage:[UIImage imageNamed:@"btn_order"] forState:UIControlStateNormal];
    [btnbuy setFrame:CGRectMake(10.0f, 10.0f, 297.0f, 41.0f)];
    [btnbuy addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    [footerv addSubview:btnbuy];
    self.tableView.tableFooterView = footerv;
    
    
    //    UIButton *btnbind = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [btnbind setTitle:@"绑定手机" forState:UIControlStateNormal];
    //    [btnbind setFrame:CGRectMake(200.0f, 100.0f, 100.0f, 40.0f)];
    //    [btnbind addTarget:self action:@selector(gotobind:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btnbind];
    //
	// Do any additional setup after loading the view.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.expressTime = @[@"只工作日送货（双休日、假日不用送，写字楼/商用地客户请选择",@"只双休日、假日送货（工作日不送）",@"学校地址/地址白天没人，请尽量安排其他时间送货（特别安排可能会超出预计送货天数）",@" 工作日与假日均可送货"];
    self.selectDaytag = 0;
    self.selexpressType = EXPRESS_SELFGET;
    [self showView];
   
}


#pragma tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_order.good.expressType == EXPRESS_BOTH) {
        return 4;
    }
    return 3;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_order.good.expressType == EXPRESS_BOTH) {
        switch (section) {
            case 0:
                return 3;
                break;
            case 1:
                return 1;
                break;
            case 2:
                return 6;
                break;
            case 3:
                return 1;
                break;
            default:
                break;
        }
    }else if (_order.good.expressType == EXPRESS_POST)
    {
        switch (section) {
            case 0:
                return 3;
                break;
            case 1:
                return 6;
                break;
            case 2:
                return 1;
                break;
            default:
                break;
        }

    }else if (_order.good.expressType == EXPRESS_SELFGET)
    {
        switch (section) {
            case 0:
                return 3;
                break;
            case 1:
                return 1;
                break;
            case 2:
                return 1;
                break;
            default:
                break;
        }
    
    }
   
    
    return 0;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_order.good.expressType == EXPRESS_BOTH) {
        if (indexPath.section==2&&indexPath.row==5) {
            return 160;
        }
        if (indexPath.section==3) {
            return 50;
        }
    }
    if (_order.good.expressType == EXPRESS_POST) {
        if (indexPath.section==1&&indexPath.row==5) {
            return 160;
        }
        if (indexPath.section==2) {
            return 50;
        }
    }
    if (_order.good.expressType == EXPRESS_SELFGET) {
      
        if (indexPath.section==2) {
            return 50;
        }
    }
    
    return 44;
    
}
-(float)titleHeight
{
    
    NSString *notice = _order.good.product;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15];
    CGSize size = CGSizeMake(300,2000);
    CGSize desclibsize = [notice sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    return desclibsize.height+20;
    
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
//        return [self titleHeight];
//    }
    
    return 50;
    
}

-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_order.good.expressType == EXPRESS_BOTH) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
        
        UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        titlelb.backgroundColor = [UIColor clearColor];
        
        [header addSubview:titlelb];
        
        switch (section) {
            case 0:
//                titlelb.frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
//                [titlelb setNumberOfLines:0];
//                titlelb.lineBreakMode = NSLineBreakByWordWrapping;
//                UIFont *font = [UIFont fontWithName:@"Helvetica" size:15];
//                CGSize size = CGSizeMake(300,2000);
//                titlelb.font = font;
//                CGSize desclibsize = [_order.good.title sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//                titlelb.frame = CGRectMake(10.0f,10.0f,desclibsize.width,desclibsize.height);
                titlelb.text = _order.good.product;
                return titlelb;
                break;
            case 1:
                titlelb.text = @"    配送方式：自提";
                
                self.delivery_1 = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.delivery_1 addTarget:self action:@selector(selecttype:) forControlEvents:UIControlEventTouchUpInside];
                self.delivery_1.frame = CGRectMake(250.0f, 0.0f, 50.0f, 30.0f);
                self.delivery_1.tag = 1;
                if (self.selexpressType==EXPRESS_SELFGET) {
                    [self.delivery_1 setImage:[UIImage imageNamed:@"delivery_checkmark_se"] forState:UIControlStateNormal];
                    self.selectDevlivery = self.delivery_1;
                }else
                {
                    [self.delivery_1 setImage:[UIImage imageNamed:@"delivery_checkmark_un"] forState:UIControlStateNormal];
                    
                }
                [header addSubview:self.delivery_1];
                return header;
                break;
            case 2:
                titlelb.text = @"    配送方式：送货上门";
                
                self.delivery_2 = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.delivery_2 addTarget:self action:@selector(selecttype:) forControlEvents:UIControlEventTouchUpInside];
                self.delivery_2.frame = CGRectMake(250.0f, 0.0f, 50.0f, 30.0f);
                self.delivery_2.tag = 2;
                if (self.selexpressType==EXPRESS_POST) {
                    [self.delivery_2 setImage:[UIImage imageNamed:@"delivery_checkmark_se"] forState:UIControlStateNormal];
                    self.selectDevlivery = self.delivery_2;
                }else
                {
                    [self.delivery_2 setImage:[UIImage imageNamed:@"delivery_checkmark_un"] forState:UIControlStateNormal];
                    
                }
                [header addSubview:self.delivery_2];
                return header;
                break;
            case 3:
                titlelb.text = @"    订单附言";
                return titlelb;
                
                break;
            default:
                break;
        }
        
        return titlelb;

    }
    if (_order.good.expressType == EXPRESS_POST) {
        UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        titlelb.backgroundColor = [UIColor clearColor];
        switch (section) {
            case 0:
                titlelb.text = _order.good.product;
                return titlelb;
                break;
            case 1:
                titlelb.text = @"    配送方式：送货上门";
                return titlelb;
                break;
            case 2:
                titlelb.text = @"    订单附言";
                return titlelb;
                
                break;
            default:
                break;
        }
        
        return titlelb;

    }
    if (_order.good.expressType == EXPRESS_SELFGET) {
        UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        titlelb.backgroundColor = [UIColor clearColor];
        switch (section) {
            case 0:
                titlelb.text = _order.good.product;
                return titlelb;
                break;
            case 1:
                titlelb.text = @"    配送方式：自提";
                return titlelb;
                break;
            case 2:
                titlelb.text = @"    订单附言";
                return titlelb;
                
                break;
            default:
                break;
        }
        
        return titlelb;
    }
    return nil;
}


-(void)remarkCell:(UITableViewCell *)cell
{
    self.textv = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 260.0f, 30.0f)];
    self.textv.placeholder = @"订单附言";
    self.textv.backgroundColor = [UIColor clearColor];
    self.textv.delegate = self;
    self.textv.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textv.tag = 1000;
    [cell.contentView addSubview:self.textv];
    
}
-(void)selecttype:(UIButton *)sender
{
    if (sender == self.selectDevlivery) {
        return;
    }
    [self.selectDevlivery setImage:[UIImage imageNamed:@"delivery_checkmark_un"] forState:UIControlStateNormal];
       [sender setImage:[UIImage imageNamed:@"delivery_checkmark_se"] forState:UIControlStateNormal];
    self.selectDevlivery = sender;
    if (sender.tag==1) {
        self.selexpressType =  EXPRESS_SELFGET;
    }if (sender.tag == 2) {
        self.selexpressType = EXPRESS_POST;
    }
}

-(void)firstCell:(UITableViewCell *)cell index:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 60.0f, 21.0f)];
        lbtitle.backgroundColor = [UIColor clearColor];
        lbtitle.text = @"单价:";
        [cell.contentView addSubview:lbtitle];
        
        UILabel *lbcontent = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 10.0f, 100.0f, 21.0f)];
        lbcontent.backgroundColor = [UIColor clearColor];
        lbcontent.text =[NSString stringWithFormat:@"￥%.2f", _order.good.team_price];
        [cell.contentView addSubview:lbcontent];
        
        
    }
    if (indexPath.row==1) {
        UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 60.0f, 21.0f)];
        lbtitle.backgroundColor = [UIColor clearColor];
        lbtitle.text = @"数量:";
        [cell.contentView addSubview:lbtitle];
        
        UIButton *btnplus = [UIButton buttonWithType:UIButtonTypeCustom];
        btnplus.frame = CGRectMake(150.0f, 7.0f, 30.0f, 30.0f);
        [btnplus setImage:[UIImage imageNamed:@"plus_btn"] forState:UIControlStateNormal];
        btnplus.tag = 0;
        [btnplus addTarget:self action:@selector(countControll:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnsub = [UIButton buttonWithType:UIButtonTypeCustom];
        btnsub.frame = CGRectMake(200.0f, 7.0f, 30.0f, 30.0f);
        [btnsub setImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
        btnsub.tag = 1;
        [btnsub addTarget:self action:@selector(countControll:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tfnum = [[UITextField alloc] initWithFrame:CGRectMake(240.0f, 10.0f, 40.0f, 21.0f)];
        //self.tfnum.backgroundColor = [UIColor clearColor];
        self.tfnum.borderStyle = UITextBorderStyleLine;
        self.tfnum.delegate = self;
        self.tfnum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.tfnum.textAlignment = NSTextAlignmentCenter;
        self.tfnum.text = [NSString stringWithFormat:@"%d",self.buynum];
        self.tfnum.tag = NUM_TAG_2;
        [cell.contentView addSubview:self.tfnum];
        [cell.contentView addSubview:btnplus];
        [cell.contentView addSubview:btnsub];
    }
    if (indexPath.row==2) {
        UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 60.0f, 21.0f)];
        lbtitle.backgroundColor = [UIColor clearColor];
        lbtitle.text = @"总额:";
        
        [cell.contentView addSubview:lbtitle];
        
        self.totalpricelb = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 10.0f, 100.0f, 21.0f)];
        self.totalpricelb.backgroundColor = [UIColor clearColor];
        self.totalpricelb.text = [NSString stringWithFormat:@"￥%.2f", _order.good.team_price];
        ;
        self.totalpricelb.textColor=[UIColor redColor];
        
        [cell.contentView addSubview:self.totalpricelb];
    }

}

-(void)selfGetCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{

    UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 120.0f, 21.0f)];
    lbtitle.backgroundColor = [UIColor clearColor];
    lbtitle.text = @"自提费用:";
    [cell.contentView addSubview:lbtitle];
    
    UILabel *lbcontent = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 10.0f, 60.0f, 21.0f)];
    lbcontent.backgroundColor = [UIColor clearColor];
    lbcontent.text =[NSString stringWithFormat:@"￥%.2f",_order.good.selfGetFee];
    [cell.contentView addSubview:lbcontent];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellorder"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_order.good.expressType == EXPRESS_BOTH) {
            switch (indexPath.section) {
                case 0:
                    [self firstCell:cell index:indexPath];
                    break;
                case 1:
                    [self selfGetCell:cell indexPath:indexPath];
                    break;
                case 2:
                    if (indexPath.row!=5) {
                        [self addressCell:indexPath cell:cell];
                        
                    }else
                    {
                        [self deliveryTimeCell:cell];
                    }
                    break;
                case 3:
                    [self remarkCell:cell];
                    break;
                    
                default:
                    break;
            }
            
        }
        if (_order.good.expressType == EXPRESS_POST) {
            switch (indexPath.section) {
                case 0:
                    [self firstCell:cell index:indexPath];
                    break;
                case 1:
                    if (indexPath.row!=5) {
                        [self addressCell:indexPath cell:cell];
                        
                    }else
                    {
                        [self deliveryTimeCell:cell];
                    }
                    break;
                case 2:
                    [self remarkCell:cell];
                    break;
                    
                default:
                    break;
            }
            
        }
        if (_order.good.expressType == EXPRESS_SELFGET) {
            switch (indexPath.section) {
                case 0:
                    [self firstCell:cell index:indexPath];
                    break;
                case 1:
                    [self selfGetCell:cell indexPath:indexPath];
                    break;
                case 2:
                    [self remarkCell:cell];
                    break;
                    
                default:
                    break;
            }
            
        }
        

        
        return cell;
    
}

-(void)countControll:(UIButton *)sender
{
    if (sender.tag == 0) {
        self.buynum += 1;
    }
    if (sender.tag == 1) {
        if (self.buynum>=2) {
            self.buynum -=1;
        }
    }
    self.totalpricelb.text = [NSString stringWithFormat:@"￥%.2f",_order.good.team_price*self.buynum];
    self.tfnum.text=[NSString stringWithFormat:@"%d",self.buynum];

}

-(void)addressCell:(NSIndexPath *)index cell:(UITableViewCell *)cell
{

    NSArray *arr = @[@"真实姓名:",@"送货地址:",@"邮编:",@"手机号:",@"快递费用:"];
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 10.0f, 100.0f, 21.0f)];
    titlelb.text = [arr objectAtIndex:index.row];
    titlelb.textAlignment = NSTextAlignmentRight;
    titlelb.backgroundColor = [UIColor clearColor];
    
    UITextField *tfcontent = [[UITextField alloc] initWithFrame:CGRectMake(110.0f, 10.0f, 150.0f, 21.0f)];
    tfcontent.delegate = self;
    tfcontent.backgroundColor = [UIColor clearColor];
    
    switch (index.row) {
        case 0:
            tfcontent.placeholder = [GPUserManager sharedClient].user.realname;
            break;
        case 1:
            tfcontent.placeholder = [GPUserManager sharedClient].user.address;
            break;
        case 2:
            tfcontent.placeholder = [GPUserManager sharedClient].user.zipcode;
            break;
        case 3:
            tfcontent.placeholder = _order.bind_mobile;
            break;
        case 4:
            tfcontent.placeholder = [NSString stringWithFormat:@"%.2f",_order.good.expressFee];
            tfcontent.enabled = NO;
            break;
            
        default:
            break;
    }
    
    [cell.contentView addSubview:titlelb];
    [cell.contentView addSubview:tfcontent];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==1000) {
        NSIndexPath *idp = [NSIndexPath indexPathForRow:0 inSection:2];
        
        [self.tableView scrollToRowAtIndexPath:idp atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        // CGPoint point = self.tableView.contentOffset;
        // point .y -= self.tableView.rowHeight;
        CGSize size = self.tableView.contentSize;
        size.height +=300;
        self.tableView.contentSize = size;
        self.tableView.contentOffset = CGPointMake(0.0f, size.height-500);
    }
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    return YES;
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==1000)
    {
        CGSize size = self.tableView.contentSize;
        size.height -=300;
        self.tableView.contentSize = size;
    }
    if (textField.tag==NUM_TAG_2) {
        
        self.buynum = [self.tfnum.text integerValue];
        self.totalpricelb.text = [NSString stringWithFormat:@"￥%.2f",_order.good.team_price*self.buynum];
        
    }
    
}


-(void)deliveryTimeCell:(UITableViewCell *)cell
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 10.0f, 150.0f, 21.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"希望送货时间:";
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(5.0f, 35.0f, 260.0f, 30.0f);
    if (self.selectDaytag==0) {
        [btn1 setImage:[UIImage imageNamed:@"cycle_sel"] forState:UIControlStateNormal];
        self.selectedDay = btn1;
    }else
    {
        [btn1 setImage:[UIImage imageNamed:@"cycle"] forState:UIControlStateNormal];
        
    }
    btn1.tag = 0;
    [btn1 addTarget:self action:@selector(selecte:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *contentlb1 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 35.0f, 250.0f, 30.0f)];
    contentlb1.backgroundColor = [UIColor clearColor];
    contentlb1.numberOfLines = 2;
    contentlb1.font = [Util parseFont:17.57];
    contentlb1.text = @"只工作日送货（双休日、假日不用送，写字楼/商用地客户请选择）";
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(5.0f, 65.0f, 260.0f, 30.0f);
    if (self.selectDaytag==1) {
        [btn2 setImage:[UIImage imageNamed:@"cycle_sel"] forState:UIControlStateNormal];
        self.selectedDay = btn2;
    }else
    {
        [btn2 setImage:[UIImage imageNamed:@"cycle"] forState:UIControlStateNormal];
        
    }btn2.tag = 1;
    [btn2 addTarget:self action:@selector(selecte:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *contentlb2 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 65.0f, 250.0f, 21.0f)];
    contentlb2.backgroundColor = [UIColor clearColor];
    contentlb2.numberOfLines = 1;
    contentlb2.font = [Util parseFont:17.57];
    contentlb2.text = @"只双休日、假日送货（工作日不送）";

    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(5.0f, 95.0f, 260.0f, 30.0f);
    if (self.selectDaytag==2) {
        [btn3 setImage:[UIImage imageNamed:@"cycle_sel"] forState:UIControlStateNormal];
        self.selectedDay = btn3;
    }else
    {
        [btn3 setImage:[UIImage imageNamed:@"cycle"] forState:UIControlStateNormal];
        
    }btn3.tag = 2;
    [btn3 addTarget:self action:@selector(selecte:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *contentlb3 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 95.0f, 250.0f, 30.0f)];
    contentlb3.backgroundColor = [UIColor clearColor];
    contentlb3.numberOfLines = 2;
    contentlb3.font = [Util parseFont:17.57];
    contentlb3.text = @"学校地址/地址白天没人，请尽量安排其他时间送货（特别安排可能会超出预计送货天数）";
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(5.0f, 125.0f, 260.0f, 30.0f);
    if (self.selectDaytag==3) {
        [btn4 setImage:[UIImage imageNamed:@"cycle_sel"] forState:UIControlStateNormal];
        self.selectedDay = btn3;
    }else
    {
        [btn4 setImage:[UIImage imageNamed:@"cycle"] forState:UIControlStateNormal];
        
    }btn4.tag = 3;
    [btn4 addTarget:self action:@selector(selecte:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *contentlb4 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 125.0f, 250.0f, 21.0f)];
    contentlb4.backgroundColor = [UIColor clearColor];
    contentlb4.numberOfLines = 1;
    contentlb4.font = [Util parseFont:17.57];
    contentlb4.text = @"工作日与假日均可送货";
    

    [cell.contentView addSubview:titlelb];

    [cell.contentView addSubview:contentlb1];
    [cell.contentView addSubview:contentlb2];
    [cell.contentView addSubview:contentlb3];
    [cell.contentView addSubview:contentlb4];
    
    [cell.contentView addSubview:btn1];
    [cell.contentView addSubview:btn2];
    [cell.contentView addSubview:btn3];
    [cell.contentView addSubview:btn4];
    
    
    
}

-(void)selecte:(UIButton *)sender
{
   
    if (sender == self.selectedDay) {
        return;
    }
   
    [self.selectedDay setImage:[UIImage imageNamed:@"cycle"] forState:UIControlStateNormal];
    
    [sender setImage:[UIImage imageNamed:@"cycle_sel"] forState:UIControlStateNormal];
    self.selectedDay = sender;
    self.selectDaytag = sender.tag;
}



-(void)buy:(id)sender
{
//    Integer userid     用户ID
//	String  userkey    密钥
//	String  teamid     团购项目ID
//	Integer buyCount   购买数量
//    Integer express_id 快递ID   //不是快递类型就传0
//    String  shouhuoren 收货人        //不是快递类型就不传
//    String  zipcode    邮编             //不是快递类型就不传
//    String  shaddress  收货地址   //不是快递类型就不传
//    String  express_xx 送货时间   //不是快递类型就不传
//    String  mobile     手机号
//    String  referer    订单来源    ios / android
//    String  remark     留言
    self.param = [[NSMutableDictionary alloc] init];
    [self.param setObject:[GPUserManager sharedClient].user.userid forKey:@"userid"];
    [self.param setObject:[GPUserManager sharedClient].user.userkey forKey:@"userkey"];
    
    
    NSInteger num = [self.tfnum.text integerValue];
    if ((_order.good.per_number>0)&&(_order.good.per_number<num)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"超过最大购买限制%d个",_order.good.per_number] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    if ((_order.good.permin_number>0)&&(_order.good.permin_number>num)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"至少买%d个",_order.good.permin_number] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [self.param setObject:self.tfnum.text forKey:@"buyCount"];
    
    
    [self.param setObject:[NSNumber numberWithInteger:_order.good.gid] forKey:@"teamid"];
    [self.param setObject:_order.bind_mobile forKey:@"mobile"];
    [self.param setObject:[GPUserManager sharedClient].user.realname forKey:@"shouhuoren"];
    [self.param setObject:@"ios" forKey:@"referer"];
    if (self.textv.text == nil) {
        self.textv.text = @" ";
    }
    [self.param setObject:self.textv.text forKey:@"remark"];
    if (_order.good.expressType==EXPRESS_BOTH) {
        if (self.selexpressType==EXPRESS_POST) {
            [self.param setObject:[self.expressTime objectAtIndex:self.selectedDay.tag] forKey:@"express_xx"];
            [self.param setObject:[NSNumber numberWithInteger:_order.good.expressID] forKey:@"express_id"];
            [self.param setObject:[GPUserManager sharedClient].user.zipcode forKey:@"zipcode"];
            [self.param setObject:[GPUserManager sharedClient].user.address forKey:@"shaddress"];
            
        }
        if (self.selexpressType==EXPRESS_SELFGET) {
            [self.param setObject:[NSNumber numberWithInteger:_order.good.selfGetID] forKey:@"express_id"];
        }
    }
    if (_order.good.expressType==EXPRESS_POST) {
        [self.param setObject:[self.expressTime objectAtIndex:self.selectedDay.tag] forKey:@"express_xx"];
        [self.param setObject:[NSNumber numberWithInteger:_order.good.expressID] forKey:@"express_id"];
        [self.param setObject:[GPUserManager sharedClient].user.zipcode forKey:@"zipcode"];
        [self.param setObject:[GPUserManager sharedClient].user.address forKey:@"shaddress"];
        
    }
    if (_order.good.expressType==EXPRESS_SELFGET) {
        [self.param setObject:[NSNumber numberWithInteger:_order.good.selfGetID] forKey:@"express_id"];
        
    }
    
    [SVProgressHUD show];
    
    [NetOperation CreateOrderWithParam:self.param withblock:^(Order *order, NSError *error) {
        [SVProgressHUD dismiss];
        
        NSArray *arr1 = [self.param allKeys];
        NSArray *arr2 = [self.param allValues];
        
        for (NSInteger i=0; i<[arr2  count]; i++) {
            NSLog(@"%@:%@",[arr1 objectAtIndex:i],[arr2 objectAtIndex:i]);
        }
        
        if (!error) {
            Order *temporder = [[Order alloc] init];
            temporder = order;
            temporder.good = self.order.good;
            temporder.bind_mobile = self.order.bind_mobile;
            self.order = temporder;
            
            OrderEnsureViewController *odev = [[OrderEnsureViewController alloc] init];
            odev.order = self.order;
            [self.navigationController pushViewController:odev animated:YES];
            
        }else
        {
            NSLog(@"error is:%@",error);
        }
        
    }];
    
   
}



-(void)viewWillAppear:(BOOL)animated
{
    UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.text = @"提交订单";
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    titlelb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titlelb;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *bk = [UIButton buttonWithType:UIButtonTypeCustom];
    bk.frame = CGRectMake(0.0f, 0.0f, 55.0f, 33.0f);
    [bk setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [bk addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mp = [[UIBarButtonItem alloc] initWithCustomView:bk];
    self.navigationItem.leftBarButtonItem = mp;
    
}

-(void)goMap:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
