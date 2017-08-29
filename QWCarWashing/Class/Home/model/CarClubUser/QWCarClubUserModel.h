//
//  QWCarClubUserModel.h
//  QWCarWashing
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QWCarClubUserModel : JSONModel
@property (nonatomic, copy) NSString *Account_Id;
@property (nonatomic)NSInteger ActivityCode;
@property (nonatomic, copy) NSString *Comment;
@property (nonatomic)NSInteger CommentCode;
@property (nonatomic, copy) NSString *CommentDate;
@property (nonatomic, copy) NSString *CommentUserImg;
@property (nonatomic, copy) NSString *CommentUserName;
@property (nonatomic) id<Optional> IsAudite;
@property (nonatomic) NSInteger IsGive;
@property (nonatomic) NSInteger PageIndex;

@property (nonatomic) id<Optional> PageSize;

@property (nonatomic) NSInteger Support;
@end
