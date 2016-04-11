//
//  GFJoinInViewController_1.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/2.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFJoinInViewController_1.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFTitleView.h"
#import "PoiSearchDemoViewController.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "UIButton+WebCache.h"
#import "CLTouchScrollView.h"


@interface GFJoinInViewController_1 ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate> {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    CGFloat jiange4;
    CGFloat jiange5;
    CGFloat jiange6;
    
    CGFloat jianjv1;
    
    UIView *_chooseView;
    UIButton *_certificateImage;
    UIButton *_idImageViewBtn;
    BOOL _isCertificate;
    
    
    BOOL _isUpCertificate;
    BOOL _isUpidImageView;
    
    NSMutableDictionary *_dataDictionary;
    
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) CLTouchScrollView *scrollerView;


@property (nonatomic, strong) GFTextField *yingyeNameTxt;
@property (nonatomic, strong) GFTextField *zhizhaohaoTxt;
@property (nonatomic, strong) GFTextField *nameTxt;
@property (nonatomic, strong) GFTextField *idCardTxt;



@end

@implementation GFJoinInViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataDictionary = [[NSMutableDictionary alloc]init];
    
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    jiange1 = kHeight * 0.0183;
    jiange2 = kWidth * 0.008;
    jiange3 = kHeight * 0.021;
    jiange4 = kHeight * 0.0573;
    jiange5 = jiange3;
    jiange6 = kHeight * 0.0365;
    
    jianjv1 = kWidth * 0.18;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // scrollerView
    self.scrollerView = [[CLTouchScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollerView.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    self.scrollerView.contentSize = CGSizeMake(0, 1000);
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollerView];
    
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"合作商加盟" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    
    // 英卡科技
    GFTitleView *kejiView = [[GFTitleView alloc] initWithY:46 + jiange1 Title:@"英卡科技"];
    [self.scrollerView addSubview:kejiView];
    
    // 营业执照的工商注册名称
    self.yingyeNameTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(kejiView.frame) + jiange2 withPlaceholder:@"营业执照的工商注册名称"];
    [self.scrollerView addSubview:self.yingyeNameTxt];
    
    // 营业执照号
    self.zhizhaohaoTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.yingyeNameTxt.frame) + jiange2 withPlaceholder:@"营业执照号"];
    self.zhizhaohaoTxt.delegate = self;
    self.zhizhaohaoTxt.tag = 2;
    self.zhizhaohaoTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollerView addSubview:self.zhizhaohaoTxt];
    
    // 法人姓名
    self.nameTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.zhizhaohaoTxt.frame) + jiange2 withPlaceholder:@"法人姓名"];
    self.nameTxt.delegate = self;
    self.nameTxt.tag = 3;
    [self.scrollerView addSubview:self.nameTxt];
    
    // 法人身份证号
    self.idCardTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.nameTxt.frame) + jiange2 withPlaceholder:@"法人身份证号"];
    self.idCardTxt.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.scrollerView addSubview:self.idCardTxt];
    
    // 上传营业执照副本
    GFTitleView *zhizhaoView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(self.idCardTxt.frame) + jiange2 Title:@"上传营业执照副本"];
    [self.scrollerView addSubview:zhizhaoView];
    
    // 示例图1
    CGFloat baseView1W = kWidth;
    CGFloat baseView1H = 0.3125 * kHeight;
    CGFloat baseView1X = 0;
    CGFloat baseView1Y = CGRectGetMaxY(zhizhaoView.frame);
    UIView *baseView1 = [[UIView alloc] initWithFrame:CGRectMake(baseView1X, baseView1Y, baseView1W, baseView1H)];
    [self.scrollerView addSubview:baseView1];
    baseView1.backgroundColor = [UIColor whiteColor];
    // 图片
    CGFloat imgView1W = kWidth - jianjv1 * 2.0;
    CGFloat imgView1H = baseView1H - jiange3 - jiange4;
    CGFloat imgView1X = jianjv1;
    CGFloat imgView1Y = jiange3;
    _certificateImage = [[UIButton alloc] initWithFrame:CGRectMake(imgView1X, imgView1Y, imgView1W, imgView1H)];
    [_certificateImage setBackgroundImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
//    imgView1.image = [UIImage imageNamed:@"userImage"];
    [baseView1 addSubview:_certificateImage];
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, baseView1H, baseView1W, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView1 addSubview:lineView1];
    
#pragma mark - 上传营业执照副本的相机按钮
    UIButton *certificateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    certificateBtn.frame = CGRectMake(CGRectGetMaxX(_certificateImage.frame)-15, CGRectGetMaxY(_certificateImage.frame)-15, 30, 30);
    [certificateBtn setBackgroundImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [baseView1 addSubview:certificateBtn];
    _certificateImage.tag =1;
    certificateBtn.tag = 1;
    [_certificateImage addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [certificateBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 法人身份证正面照
    GFTitleView *idCardView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(baseView1.frame) + jiange5 Title:@"法人身份证正面照"];
    [self.scrollerView addSubview:idCardView];
    
    
    // 示例图2
    CGFloat baseView2W = kWidth;
    CGFloat baseView2H = 0.3125 * kHeight;
    CGFloat baseView2X = 0;
    CGFloat baseView2Y = CGRectGetMaxY(idCardView.frame);
    UIView *baseView2 = [[UIView alloc] initWithFrame:CGRectMake(baseView2X, baseView2Y, baseView2W, baseView2H)];
    [self.scrollerView addSubview:baseView2];
    baseView2.backgroundColor = [UIColor whiteColor];
    // 图片
    CGFloat imgView2W = kWidth - jianjv1 * 2.0;
    CGFloat imgView2H = baseView1H - jiange3 - jiange4;
    CGFloat imgView2X = jianjv1;
    CGFloat imgView2Y = jiange3;
    _idImageViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(imgView2X, imgView2Y, imgView2W, imgView2H)];
    [_idImageViewBtn setBackgroundImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
//    imgView2.image = [UIImage imageNamed:@"userImage"];
//    imgView2.backgroundColor = [UIColor redColor];
    [baseView2 addSubview:_idImageViewBtn];
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, baseView2H, baseView2W, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView2 addSubview:lineView2];
    
#pragma mark - 法人身份证正面照照片按钮
    UIButton *idImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    idImageBtn.frame = CGRectMake(CGRectGetMaxX(_idImageViewBtn.frame)-15, CGRectGetMaxY(_idImageViewBtn.frame)-15, 30, 30);
    [idImageBtn setBackgroundImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [baseView2 addSubview:idImageBtn];
    
    _idImageViewBtn.tag = 2;
    idImageBtn.tag = 2;
    
    [_idImageViewBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [idImageBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 注册按钮
    CGFloat nextButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat nextButH = kHeight * 0.07;
    CGFloat nextButX = kWidth * 0.116;
    CGFloat nextButY = CGRectGetMaxY(baseView2.frame) + jiange6;
    UIButton *nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBut.frame = CGRectMake(nextButX, nextButY, nextButW, nextButH);
    nextBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    nextBut.layer.cornerRadius = 5;
    [nextBut setTitle:@"下一步" forState:UIControlStateNormal];
    [self.scrollerView addSubview:nextBut];
    [nextBut addTarget:self action:@selector(nextButClick) forControlEvents:UIControlEventTouchUpInside];

    if (![_dataDictionary isKindOfClass:[NSNull class]]) {
        if (_dataForPastDictionary) {
            
            self.yingyeNameTxt.text = _dataForPastDictionary[@"fullname"];
            self.zhizhaohaoTxt.text = _dataForPastDictionary[@"businessLicense"];
            self.nameTxt.text = _dataForPastDictionary[@"corporationName"];
            self.idCardTxt.text = _dataForPastDictionary[@"corporationIdNo"];
            [_certificateImage sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345%@",_dataForPastDictionary[@"bussinessLicensePic"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userImage"]];
            [_dataDictionary setObject:_dataForPastDictionary[@"bussinessLicensePic"] forKey:@"bussinessLicensePic"];
            [_idImageViewBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345%@",_dataForPastDictionary[@"corporationIdPicA"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userImage"]];
            [_dataDictionary setObject:_dataForPastDictionary[@"corporationIdPicA"] forKey:@"corporationIdPicA"];
            _isUpCertificate = YES;
            _isUpidImageView = YES;
        }
    }
    
    
    
    self.scrollerView.contentSize = CGSizeMake(0, CGRectGetMaxY(nextBut.frame) + 50);
}



#pragma mark - 相机按钮的响应方法
- (void)cameraBtnClick:(UIButton *)button{
    NSLog(@"--请选择照片－－");
    [self.view endEditing:YES];
    if (button.tag == 1) {
        _isCertificate = YES;
    }else{
        _isCertificate = NO;
    }
    
    _chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 80)];
    _chooseView.center = self.view.center;
    _chooseView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    _chooseView.layer.cornerRadius = 15;
    _chooseView.clipsToBounds = YES;
    [self.view addSubview:_chooseView];
    
    // 相机和相册按钮
    UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 40)];
    [cameraButton setTitle:@"相册" forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(imageChoose:) forControlEvents:UIControlEventTouchUpInside];
    cameraButton.tag = 1;
    [_chooseView addSubview:cameraButton];
    
    UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-100, 40)];
    [photoButton setTitle:@"相机" forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(imageChoose:) forControlEvents:UIControlEventTouchUpInside];
    photoButton.tag = 2;
    [_chooseView addSubview:photoButton];
    
    
    
}

#pragma mark - 选择照片
- (void)imageChoose:(UIButton *)button{
    [_chooseView removeFromSuperview];
//    _scrollView.userInteractionEnabled = YES;
    if (button.tag == 1) {
        
        
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.delegate =self;

        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        NSLog(@"打开相机");
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
    
    
}

#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_isCertificate) {
        [_certificateImage setBackgroundImage:image forState:UIControlStateNormal];
        CGSize imagesize;
        imagesize.width = image.size.width/2;
        imagesize.height = image.size.height/2;
        UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
        NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.3);
        [GFHttpTool postcertificateImage:imageData success:^(id responseObject) {
            NSLog(@"上传成功－－%@--",responseObject);
            if ([responseObject[@"result"] integerValue] == 1) {
                _isUpCertificate = YES;
                [_dataDictionary setObject:responseObject[@"data"] forKey:@"bussinessLicensePic"];
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"上传失败－－%@---",error);
        }];
        
    }else{
        [_idImageViewBtn setBackgroundImage:image forState:UIControlStateNormal];
        //        _haveIdentityImage = YES;
//        _identityButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        CGSize imagesize;
        imagesize.width = image.size.width/2;
        imagesize.height = image.size.height/2;
        UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
        NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.3);
        [GFHttpTool postIdImageViewImage:imageData success:^(id responseObject) {
            
            NSLog(@"－－－－上传成功－－－%@--",responseObject);
            if ([responseObject[@"result"] integerValue] == 1) {
                _isUpidImageView = YES;
                [_dataDictionary setObject:responseObject[@"data"] forKey:@"corporationIdPicA"];
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"---请求失败－－－error---%@---",error);
            
        }];
        
    }
    
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"---%@--",@(range.length));
    
    if (textField.tag == 2) {
        
        
        
        if (textField.text.length>14 && range.length==0) {
            return NO;
            
        }else{
            return [self isNumber:string];
        }
    }else if (textField.tag == 3){
        if (textField.text.length>9 && range.length==0) {
            return NO;
            
        }
    }
    
    return YES;
}
- (BOOL)isNumber:(NSString *)string{
    
    BOOL flag;
    if (string.length <= 0) {
        flag = YES;
        return flag;
    }
    NSString *regex2 = @"^[0-9]*$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:string];
    
    
    return YES;
}

#pragma mark - 下一步
- (void)nextButClick {
    
//    PoiSearchDemoViewController *poiSearchView = [[PoiSearchDemoViewController alloc]init];
//    poiSearchView.dataDictionary = [[NSMutableDictionary alloc]initWithDictionary:@{@"title":@"Autobon"}];
//    [self.navigationController pushViewController:poiSearchView animated:YES];
    
    if (_yingyeNameTxt.text.length == 0) {
        [self addAlertView:@"请填写营业执照的工商注册名称"];
    }else{
        if (_zhizhaohaoTxt.text.length != 15) {
            [self addAlertView:@"请输入正确的营业执照号"];
        }else{
            if (_nameTxt.text.length == 0) {
                [self addAlertView:@"请输入法人姓名"];
            }else{
                if (![self validateIdentityCard:_idCardTxt.text]) {
                    [self addAlertView:@"请输入正确的身份证号"];
                }else{
                    if (_isUpCertificate) {
                        if (_isUpidImageView) {
                         
                            [_dataDictionary setObject:_yingyeNameTxt.text forKey:@"fullname"];
                            [_dataDictionary setObject:_zhizhaohaoTxt.text forKey:@"businessLicense"];
                            [_dataDictionary setObject:_nameTxt.text forKey:@"corporationName"];
                            [_dataDictionary setObject:_idCardTxt.text forKey:@"corporationIdNo"];
                            
                            PoiSearchDemoViewController *poiSearchView = [[PoiSearchDemoViewController alloc]init];
                            poiSearchView.dataDictionary = _dataDictionary;
                             NSLog(@"---——dataForPast--%@-",_dataForPastDictionary);
                            poiSearchView.dataForPastDictionary = _dataForPastDictionary;
                            
                            [self.navigationController pushViewController:poiSearchView animated:YES];
                            
                        }else{
                            [self addAlertView:@"请上传法人身份证正面照"];
                        }
                    }else{
                        [self addAlertView:@"请上传营业执照副本"];
                    }
                    
                    
                }
            }
        }
    }
    
    
    
    
    NSLog(@"下一步");

}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

#pragma mark - 身份证号正则表达式
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
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
