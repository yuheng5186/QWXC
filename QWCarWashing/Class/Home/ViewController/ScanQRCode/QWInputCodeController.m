//
//  QWInputCodeController.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWInputCodeController.h"
#import "TFGridInputView.h"
#import<AVFoundation/AVFoundation.h>


@interface QWInputCodeController ()

{
    //输入控件
    TFGridInputView *_inputView;
    UIButton *_textGetButton;
    
    
}
@property (nonatomic, strong) UIButton * flashlightButton;
@property (nonatomic, strong) UILabel * flashlightLabel;


@end

@implementation QWInputCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"编号开锁";

    [self createSubView];
}


- (void) createSubView {
    
    //使用默认大小会拉大高宽，虽然设置100，但实际是6*40+(6+1)*8 = 296，参考布局规则
    _inputView = [[TFGridInputView alloc] initWithFrame:CGRectMake(Main_Screen_Width*15/375, Main_Screen_Height*120/667, 40, 40) row:1 column:7];

    _inputView.keyboardType = UIKeyboardTypeNumberPad;
    //构建一个样式，并调整各种格式
    TFGridInputViewCellStyle *style = [[TFGridInputViewCellStyle alloc] init];
    style.backColor = [UIColor whiteColor];
    style.textColor = [UIColor blackColor];
    style.font      = [UIFont systemFontOfSize:18];
    [_inputView setStyle:style forState:(TFGridInputViewCellStateEmpty)];

    _inputView.DIVBorderColor = [UIColor colorFromHex:@"#ffce36"];
    _inputView.DIVBorderWidth = 0.5;

    
    [self.view addSubview:_inputView];
    
    NSString  *inpotString       = @"确认您输入的洗车机编码正确?";
    UIFont    *inputStringFont   = [UIFont systemFontOfSize:Main_Screen_Height*14/667];
    UILabel   *inputLabel             = [UIUtil drawLabelInView:self.view frame:[UIUtil textRect:inpotString font:inputStringFont]font:inputStringFont text:inpotString isCenter:NO];
    inputLabel.textColor   = [UIColor colorFromHex:@"#b4b4b4"];
    inputLabel.top         = _inputView.bottom +Main_Screen_Height*40/667;
    inputLabel.centerX     = Main_Screen_Width/2;
    
    
    UIButton    *washingButton  = [UIUtil drawDefaultButton:self.view title:@"立即洗车" target:self action:@selector(getInputViewText)];
    washingButton.top           = inputLabel.bottom +Main_Screen_Height*40/667;
    washingButton.centerX       = Main_Screen_Width/2;
    
    
    self.flashlightButton     = [UIUtil drawButtonInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*50/667) iconName:@"qw_shoudiantong" target:self action:@selector(flashlightButtonButtonClcik:)];
    self.flashlightButton.top = washingButton.bottom +Main_Screen_Height*30/667;
    self.flashlightButton.centerX   = Main_Screen_Width/2;;
    
    NSString  *openString           = @"手电筒";
    UIFont    *openStringFont       = [UIFont systemFontOfSize:Main_Screen_Height*12/667];
    self.flashlightLabel            = [UIUtil drawLabelInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*20/667) font:openStringFont text:openString isCenter:NO];
    self.flashlightLabel.textColor  = [UIColor colorFromHex:@"#999999"];
    self.flashlightLabel.top        = self.flashlightButton.bottom;
    self.flashlightLabel.textAlignment  = NSTextAlignmentCenter;
    self.flashlightLabel.centerX    = Main_Screen_Width/2;
    

    
    
}

- (void) flashlightButtonButtonClcik:(UIButton *)sender {

    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"qw_shoudianton"] forState:UIControlStateSelected];
        self.flashlightLabel.text  = @"手电筒";
        //打开闪光灯
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        
        if ([captureDevice hasTorch]) {
            BOOL locked = [captureDevice lockForConfiguration:&error];
            if (locked) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
                [captureDevice unlockForConfiguration];
            }
        }
        
    }else{
        [sender setImage:[UIImage imageNamed:@"qw_shoudiantong"] forState:UIControlStateSelected];
        self.flashlightLabel.text  = @"手电筒";
        //关闭闪光灯
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

-(void)getInputViewText{
    [_textGetButton setTitle:_inputView.text forState:(UIControlStateNormal)];
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