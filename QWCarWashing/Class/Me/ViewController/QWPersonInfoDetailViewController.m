//
//  QWPersonInfoDetailViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPersonInfoDetailViewController.h"
@interface QWPersonInfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *sexString;
@property (nonatomic, strong) UIImageView *userImageView;

@end

@implementation QWPersonInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubView];
}
- (void) createSubView {
//    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
//    [leftButton setImage:[UIImage imageNamed:@"baisefanhui"] forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= [UIBarButtonItem setUibarbutonimgname:@"baisefanhui" andhightimg:@"" Target:self action:@selector(back:) forControlEvents:BtnTouchUpInside];
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth,QWScreenheight) style:UITableViewStyleGrouped];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    self.tableView.tableHeaderView  = [UIView new];
    [self.view addSubview:self.tableView];
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 10.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        
        default:
            break;
    }
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.textLabel.text     = @"头像";
        self.userImageView  = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, cell.contentView.centerY-11, 60, 60) imageName:@"gerenxinxitou"];
        self.userImageView.left          = QWScreenWidth*280/375;
        
        
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text         = @"昵称";
            cell.detailTextLabel.text   = @"15800781856";
            
        }else if (indexPath.row == 1){
            cell.textLabel.text         = @"手机号";
            cell.detailTextLabel.text   = @"15800781856";
        }
        else if(indexPath.row==2) {
            cell.textLabel.text         = @"性别";
            cell.detailTextLabel.text   = self.sexString;
        }else{
            cell.textLabel.text         = @"微信绑定";
            cell.detailTextLabel.text   = @"去绑定";
            
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
