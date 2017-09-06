//
//  QWHomeDetailTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWHomeDetailTableViewCell.h"

@implementation QWHomeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.typeName.textColor=[UIColor colorWithHexString:@"#4a4a4a"];
    self.typeName.font=[UIFont systemFontOfSize:14];
    self.Nowtime.textColor=[UIColor colorWithHexString:@"#999999"];
    self.Nowtime.font=[UIFont systemFontOfSize:12];
    self.payType.adjustsFontSizeToFitWidth =YES;
//    self.payType.font=[UIFont systemFontOfSize:12];
    self.payType.textColor=[UIColor colorWithHexString:@"#868686"];
    self.moneys.font=[UIFont systemFontOfSize:20];
    self.moneys.textColor=[UIColor colorWithHexString:@"#3a3a3a"];
    self.chedianName.font=[UIFont systemFontOfSize:12];
    self.chedianName.textColor=[UIColor colorWithHexString:@"#868686"];
    self.seeDetailbtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.seeDetailbtn setTitleColor:[UIColor colorFromHex:@"#868686"] forState:BtnNormal];
    self.seeDetailbtn.backgroundColor=[UIColor colorFromHex:@"#eaeaea"];
    
}
//*contentImage;
//@property (weak, nonatomic) IBOutlet UILabel *typeName;
//@property (weak, nonatomic) IBOutlet UILabel *payType;
//@property (weak, nonatomic) IBOutlet UILabel *Nowtime;
//@property (weak, nonatomic) IBOutlet UILabel *moneys;
//@property (weak, nonatomic) IBOutlet UILabel *chedianName;
//@property (weak, nonatomic) IBOutlet UIButton *seeDetailbtn;
-(void)setRecordModel:(QWRecordModel *)RecordModel{
    _RecordModel=RecordModel;
    self.Nowtime.text=RecordModel.CreateDate;
//
    self.moneys.text=RecordModel.RightDes;
    if(RecordModel.ShowType == 2)
    {
        self.typeName.text=@"消费记录";
        self.contentImage.image=[UIImage imageNamed:@"xiaofeijilu"];
        if(RecordModel.ConsumptionType == 1)
        {
            self.payType.text=@"线下门店支付";
//            1.线下门店支付;2.自动扫码洗车;3.自动扫码洗车支付;4.购买洗车卡(当返回类型为2时用到)
            self.moneys.text         = [NSString stringWithFormat:@"￥%@",RecordModel.MiddleDes];
            self.chedianName.text          = RecordModel.BottomDes;
        }
        else if(RecordModel.ConsumptionType == 2)
        {
            self.payType.text=@"自动扫码洗车";
            self.typeName.text         = RecordModel.MiddleDes;
            self.chedianName.text          = [NSString stringWithFormat:@"剩余%@次免费洗车",RecordModel.BottomDes];
        }
        else if(RecordModel.ConsumptionType == 3)
        {
            self.payType.text=@"自动扫码洗车支付";
            self.typeName.text          = RecordModel.MiddleDes;
            self.chedianName.text         = [NSString stringWithFormat:@"支付金额: %@元",RecordModel.BottomDes];
        }
        else if(RecordModel.ConsumptionType == 4)
        {
            self.payType.text=@"购买洗车卡";
            self.chedianName.text         = [NSString stringWithFormat:@"您购买%@",RecordModel.MiddleDes];
           self.chedianName.text          = [NSString stringWithFormat:@"支付金额: %@元",RecordModel.BottomDes];
        }
        
        
        
        
        
        [self.seeDetailbtn setTitle:@"查看详情" forState:BtnNormal]                ;
    }
    
    else if(RecordModel.ShowType == 1)
    {
        self.typeName.text=@"优惠活动";
        self.contentImage.image=[UIImage imageNamed:@"quanyi"];
        self.chedianName.text   = RecordModel.MiddleDes;
        self.chedianName.text    = RecordModel.BottomDes;
        
        [self.seeDetailbtn setTitle:@"立即领取" forState:BtnNormal];
        //        vipString   = @"huiyuanzhuanxiang";
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
