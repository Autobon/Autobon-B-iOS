//
//  GFOneIndentViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/10.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFOneIndentViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFTitleView.h"
#import "GFPartnersMessageViewController.h"
#import "GFNoIndentViewController.h"



@interface GFOneIndentViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    
    CGFloat jianjv1;
}

@property (nonatomic, strong) GFNavigationView *navView;


@property (nonatomic, strong) UIScrollView *scrollerView;

// 灰色提示条
@property (nonatomic, strong) UIButton *tipButton;
// 订单信息
@property (nonatomic, strong) GFTitleView *msgView;
// 示例图
@property (nonatomic, strong) UIButton *imgView;
// 请填写备注
@property (nonatomic, strong) UITextView *txtView;
// 施工时间Lab
@property (nonatomic, strong) UILabel *timeLab;



@property (nonatomic, strong) UILabel *timeLab1;


@end

@implementation GFOneIndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    jiange1 = kHeight * 0.013;
    jiange2 = kHeight * 0.0365;
    jiange3 = kHeight * 0.0157;
    
    jianjv1 = kWidth * 0.0416;
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
}

- (void)_setView {
    
    
    CGFloat scrollerViewW = kWidth;
    CGFloat scrollerViewH = kHeight - 64 - kHeight * 0.0625;
    CGFloat scrollerViewX = 0;
    CGFloat scrollerViewY = CGRectGetMaxY(self.navView.frame);
    self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(scrollerViewX, scrollerViewY, scrollerViewW, scrollerViewH)];
    self.scrollerView.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    self.scrollerView.contentSize = CGSizeMake(0, 1000);
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollerView];
    
    // 订单信息基础视图
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = 500;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = 0;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.scrollerView addSubview:baseView];
    
    // 灰色提示框
    CGFloat tipLabW = kWidth;
    CGFloat tipLabH = kHeight * 0.0625;
    CGFloat tipLabX = 0;
    CGFloat tipLabY = 0;
    self.tipButton = [[UIButton alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
    self.tipButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    self.tipButton.textAlignment = NSTextAlignmentCenter;
//    [_tipButton setTitleColor:<#(nullable UIColor *)#> forState:<#(UIControlState)#>]
//    self.tipButton.textColor = [UIColor whiteColor];
    self.tipButton.titleLabel.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
//    self.tipButton.text = @"有3个未完成订单";
    [_tipButton setTitle:@"有3个未完成订单" forState:UIControlStateNormal];
    [baseView addSubview:self.tipButton];
    [_tipButton addTarget:self action:@selector(tipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 订单信息
    self.msgView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(self.tipButton.frame) + jiange1 Title:@"订单信息"];
    [baseView addSubview:self.msgView];
    
    // 示例图
    CGFloat imgViewW = kWidth - 2 * jianjv1;
    CGFloat imgViewH = kHeight * 0.24;
    CGFloat imgViewX = jianjv1;
    CGFloat imgViewY = CGRectGetMaxY(self.msgView.frame) + jiange2;
    self.imgView = [[UIButton alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
//    self.imgView.backgroundColor = [UIColor redColor];
//    self.imgView.image = [UIImage imageNamed:@"orderImage"];
    [self.imgView setBackgroundImage:[UIImage imageNamed:@"orderImage"] forState:UIControlStateNormal];
    [baseView addSubview:self.imgView];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)-15, CGRectGetMaxY(self.imgView.frame)-15, 30, 30);
    [cameraBtn setBackgroundImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [baseView addSubview:cameraBtn];
    
    [cameraBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.imgView addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(jianjv1, CGRectGetMaxY(self.imgView.frame) + jiange2, kWidth - jianjv1 * 2, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    
    // 请填写备注
    CGFloat txtViewW = imgViewW;
    CGFloat txtViewH = kHeight * 0.21;
    CGFloat txtViewX = jianjv1;
    CGFloat txtViewY = CGRectGetMaxY(lineView1.frame) + kHeight * 0.024;
    self.txtView = [[UITextView alloc] initWithFrame:CGRectMake(txtViewX, txtViewY, txtViewW, txtViewH)];
    [baseView addSubview:self.txtView];
    
    baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(self.txtView.frame) + 20);
    
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.txtView.frame) + 20, kWidth, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    
    // 施工时间
    GFTitleView *timeView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(baseView.frame) + jiange3 Title:@"施工时间"];
    [self.scrollerView addSubview:timeView];
    
    // 施工时间Lab
    UIView *labView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeView.frame), kWidth, kHeight * 0.099)];
    labView.backgroundColor = [UIColor whiteColor];
    [self.scrollerView addSubview:labView];
    CGFloat timeLabW = kWidth - (kWidth * 0.065 * 2);
    CGFloat timeLabH = kHeight * 0.099;
    CGFloat timeLabX = kWidth * 0.065;
    CGFloat timeLabY = 0;
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
    self.timeLab.text = @"2016年02月14日";
    self.timeLab.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    self.timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    [labView addSubview:self.timeLab];
    
    // 边线
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.099, kWidth, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [labView addSubview:lineView3];
    
    
    // 施工项目
    GFTitleView *projectView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(labView.frame) + jiange3 Title:@"施工项目"];
    [self.scrollerView addSubview:projectView];
    
    // 施工项目按钮
    CGFloat butViewW = kWidth;
    CGFloat butViewH = timeLabH;
    CGFloat butViewX = 0;
    CGFloat butViewY = CGRectGetMaxY(projectView.frame);
    UIView *butView = [[UIView alloc] initWithFrame:CGRectMake(butViewX, butViewY, butViewW, butViewH)];
    butView.backgroundColor = [UIColor whiteColor];
    [self.scrollerView addSubview:butView];
    NSArray *nameArr = @[@"隔热膜", @"隐形车衣", @"车身改色", @"美容清洁"];
    for(int i=0; i<4; i++) {
        CGFloat butW = kWidth * 0.218;
        CGFloat butH = kHeight * 0.068;
        CGFloat butX = (kWidth - butW * 4) / 5.0 * (i + 1) + butW * i;
        CGFloat butY = (butViewH - butH) / 2.0;
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(butX, butY, butW, butH);
        [but setBackgroundColor:[UIColor colorWithRed:237 / 255.0 green:238 / 255.0 blue:239 / 255.0 alpha:1]];
        [but setTitle:nameArr[i] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13 /320.0 * kWidth];
        [but setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        but.tag = i + 1;
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius = 17;
        [butView addSubview:but];
    }
    
    // 边线
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, butViewH, kWidth, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [butView addSubview:lineView4];
    
    // 一键下单
    CGFloat signInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signInButH = kHeight * 0.07;
    CGFloat signInButX = kWidth * 0.116;
    CGFloat signInButY = CGRectGetMaxY(butView.frame) + kHeight * 0.0443;
    UIButton *signInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    signInBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signInBut.layer.cornerRadius = 5;
    [signInBut setTitle:@"一键下单" forState:UIControlStateNormal];
    [self.scrollerView addSubview:signInBut];
    [signInBut addTarget:self action:@selector(signInButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.scrollerView.contentSize = CGSizeMake(0, CGRectGetMaxY(signInBut.frame) + kHeight * 0.0443);
    
}


#pragma mark - 未完成订单的响应方法
- (void)tipBtnClick{
    
    GFNoIndentViewController *noIndent = [[GFNoIndentViewController alloc]init];
    [self.navigationController pushViewController:noIndent animated:YES];
    
}


#pragma mark - 一键下单按钮响应方法
- (void)signInButClick {
    
    
}

#pragma mark - 相机按钮的响应方法
- (void)cameraBtnClick{
    
    BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (result) {
        NSLog(@"---支持使用相机---");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self  presentViewController:imagePicker animated:YES completion:^{
        }];
    }else{
        NSLog(@"----不支持使用相机----");
    }
    
}

#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    
        [self.imgView setBackgroundImage:image forState:UIControlStateNormal];
    
}


#pragma mark - 压缩图片尺寸
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)butClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if(sender.selected == YES) {
        sender.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    }else {
        [sender setBackgroundColor:[UIColor colorWithRed:237 / 255.0 green:238 / 255.0 blue:239 / 255.0 alpha:1]];
    }
    
    
    NSLog(@"按钮被点击了");
}



- (UIView *)successView {
    
//    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIView *vv = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    vv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    // 基础View
    CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
    CGFloat baseViewH = 300;
    CGFloat baseViewX = kWidth * 0.1;
    CGFloat baseViewY = 130 / 568.0 * kHeight;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [vv addSubview:baseView];
    baseView.layer.cornerRadius = 7.5;
    baseView.clipsToBounds = YES;
    
    // 右上方X按钮
    CGFloat butW = kHeight * 0.06;
    CGFloat butH = butW;
    CGFloat butX = baseViewW - 20 - butW;
    CGFloat butY = 20;
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(butX, butY, butW, butH);
    but.backgroundColor = [UIColor redColor];
    [baseView addSubview:but];
//    [but addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 下单成功
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(but.frame) + 5, baseViewW, kHeight * 0.04)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    lab.text = @"下单成功！";
    [baseView addSubview:lab];
    
    
    // 倒计时按钮
    CGFloat timeLabW = butW * 2.0;
    CGFloat timeLabH = butH;
    CGFloat timeLabX = (baseViewW - timeLabW) / 2.0;
    CGFloat timeLabY = CGRectGetMaxY(lab.frame) + 20;
    self.timeLab1 = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
    self.timeLab1.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView addSubview:self.timeLab1];
    
    baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(self.timeLab.frame) + 40);
    
    
    // 计时器
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeWork) userInfo:nil repeats:YES];
    
    
    return vv;
}

- (void)timeWork {

    
}

- (void)leftButClick {
    
    GFPartnersMessageViewController *partnerView = [[GFPartnersMessageViewController alloc]init];
    [self.navigationController pushViewController:partnerView animated:YES];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
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
