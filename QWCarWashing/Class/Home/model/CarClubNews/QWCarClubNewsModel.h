//
//  QWCarClubNewsModel.h
//  QWCarWashing
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QWCarClubNewsModel : JSONModel
@property (copy, nonatomic)NSString <Optional>*Account_Id;
@property NSInteger ActivityCode;//活动编号
@property (copy, nonatomic)NSString <Optional>*Area;//城市名称
@property (copy, nonatomic)NSString <Optional>*ActivityName;//活动名称
@property (copy, nonatomic)NSString <Optional>*Comment;//活动内容
@property NSInteger CommentCount;//评论次数
@property NSInteger GiveCount;//点赞次数
@property (copy, nonatomic)NSString <Optional>*FromusrName;//文章作者
@property (copy, nonatomic)NSString <Optional>*FromusrImg;//文章作者
@property (copy, nonatomic)NSString <Optional>*IndexImg;//首页图片
@property (copy, nonatomic)NSString <Optional>*ActDate;//创建时间
@property (nonatomic)NSInteger IsGive;//是否点赞
@property (nonatomic)NSInteger PageIndex;
@property (nonatomic)NSInteger PageSize;
@property (nonatomic)NSInteger Readcount;//阅读次数
@property (copy, nonatomic)NSMutableArray <Optional>*actModelList;//评论集合
@end
