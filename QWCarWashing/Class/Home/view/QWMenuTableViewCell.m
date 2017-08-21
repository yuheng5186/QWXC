//
//  QWMenuTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMenuTableViewCell.h"
#import "QWSubCollectionViewCell.h"


@interface QWMenuTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectiveView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) int selectOption;//选择选项

@property(nonatomic,strong)NSArray *mutableArrImage,*mutableArr;


@end


@implementation QWMenuTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void) setContentAndImgArr :(NSArray *)arrImage andContentArr :(NSArray *)contentArr{
    self.mutableArrImage =  arrImage;
    self.mutableArr =  contentArr;
    if (self.mutableArrImage.count >4) {
        
    }
    [self.collectiveView setHeight: [QWMenuTableViewCell cellHeightContent:self.mutableArrImage.count ]];
    [self.collectiveView reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _mutableArrImage=[NSArray array];
        _mutableArr = [NSArray array];
        
        _selectTitle = [NSString string];
        if (!_collectiveView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            
            _collectiveView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, QWScreenWidth-20, self.contentView.frame.size.height+20) collectionViewLayout:layout];
            self.collectiveView.scrollEnabled = NO;
            [self.collectiveView setBackgroundView:nil];
            [self.collectiveView setBackgroundColor:[UIColor whiteColor]];
            //            self.collectiveView.layer.borderWidth=1;
            //            self.collectiveView.layer.borderColor=RGBACOLOR(243, 239, 235, 1).CGColor;
            self.collectiveView.layer.cornerRadius=5;
            [self.collectiveView registerClass:[QWSubCollectionViewCell class] forCellWithReuseIdentifier:QWCellIdentifier_MenuTableViewCell];
            self.collectiveView.dataSource = self;
            self.collectiveView.delegate = self;
            [self.contentView addSubview:self.collectiveView];
            
            layout.itemSize = CGSizeMake((QWScreenWidth - 70) / 4, self.contentView.frame.size.height+20);
            layout.minimumLineSpacing = 10;
            layout.minimumInteritemSpacing = 10;
        }
    }
    return self;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QWSubCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QWCellIdentifier_MenuTableViewCell forIndexPath:indexPath];
    if (self.mutableArrImage.count >4) {
        [cell setSmailImages:self.mutableArrImage[indexPath.row] andName:self.mutableArr[indexPath.row]];
    }else{
        [cell setImages:self.mutableArrImage[indexPath.row] andName:self.mutableArr[indexPath.row]];
        
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.mutableArr.count >0){
        return self.mutableArr.count;
    }else{
        return 0;
    }
}
- (void)setCurTweet:(id )curTweet{
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selecOptionIndexs(indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    H1_FilterViewCCell *cell = (H1_FilterViewCCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.subviews[0].backgroundColor = [UIColor colorWithWhite:0.950 alpha:1.000];
    //    cell.titleLabel.textColor = [UIColor blackColor];
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    return UIEdgeInsetsMake(15,autoScaleW(15),10, autoScaleW(5));
}
+ (CGFloat)cellHeightContent:(NSInteger )contentIndex{
    CGFloat cellHeight = 0;
    NSInteger row;
    if (contentIndex <= 0) {
        row = 0;
    }else{
        row = ceilf((float)contentIndex /4.0);
    }
    cellHeight = ([QWSubCollectionViewCell ccellSize].height +20) *row;
    return cellHeight;
}
+ (CGFloat)cellHeight:(NSInteger )contentIndex{
    return  [QWMenuTableViewCell cellHeightContent:contentIndex ] +10;
}


@end
