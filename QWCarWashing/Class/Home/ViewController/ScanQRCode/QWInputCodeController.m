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

    
//    //用这个按钮来获取输入框的文本，测试文本是否正确
//    _textGetButton = [[UIButton alloc] initWithFrame:(CGRectMake(30, 70, 300, 30))];
//    _textGetButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
//    [_textGetButton setTitleColor:[UIColor darkTextColor] forState:(UIControlStateNormal)];
//    [_textGetButton addTarget:self action:@selector(getInputViewText) forControlEvents:(UIControlEventTouchUpInside)];
//    [_textGetButton setTitle:@"点击获取文本" forState:(UIControlStateNormal)];
//    [self.view addSubview:_textGetButton];
    
    //使用默认大小会拉大高宽，虽然设置100，但实际是6*40+(6+1)*8 = 296，参考布局规则
    
    if (QWScreenheight==480) {
        //4s
        _inputView = [[TFGridInputView alloc] initWithFrame:CGRectMake(Main_Screen_Width*12/375, Main_Screen_Height*80/667, Main_Screen_Width*80/375, Main_Screen_Height*80/667) row:1 column:6];

    }else if(QWScreenheight==568) {
        //5
        _inputView = [[TFGridInputView alloc] initWithFrame:CGRectMake(Main_Screen_Width*12/375, Main_Screen_Height*80/667, Main_Screen_Width*80/375, Main_Screen_Height*80/667) row:1 column:6];

    }else if(QWScreenheight==667){
        //6
        _inputView = [[TFGridInputView alloc] initWithFrame:CGRectMake(Main_Screen_Width*39/375, Main_Screen_Height*80/667, Main_Screen_Width*80/375, Main_Screen_Height*80/667) row:1 column:6];

    }else if(QWScreenheight==736){
        //6p
        _inputView = [[TFGridInputView alloc] initWithFrame:CGRectMake(Main_Screen_Width*50/375, Main_Screen_Height*80/667, Main_Screen_Width*80/375, Main_Screen_Height*80/667) row:1 column:6];

    }else{
        _inputView = [[TFGridInputView alloc] initWithFrame:CGRectMake(Main_Screen_Width*50/375, Main_Screen_Height*80/667, Main_Screen_Width*80/375, Main_Screen_Height*80/667) row:1 column:6];

    }

    _inputView.keyboardType = UIKeyboardTypeNumberPad;
    //构建一个样式，并调整各种格式
    TFGridInputViewCellStyle *style = [[TFGridInputViewCellStyle alloc] init];
    style.backColor = [UIColor whiteColor];
    style.textColor = [UIColor blackColor];
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
    
    NSString  *openString           = @"打开手电筒";
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
        self.flashlightLabel.text  = @"关闭手电筒";
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
        self.flashlightLabel.text  = @"打开手电筒";
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
