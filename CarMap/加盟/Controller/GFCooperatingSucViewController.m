//
//  GFCooperatingSucViewController.m
//  CarMapB
//
//  Created by 陈光法 on 16/11/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFCooperatingSucViewController.h"
#import "GFNavigationView.h"
#import "UIImageView+WebCache.h"
#import "CLImageView.h"
#import "HZPhotoBrowser.h"
#import "UIButton+WebCache.h"

@interface GFCooperatingSucViewController () <HZPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *photoUrlArr;


@end

@implementation GFCooperatingSucViewController

- (UILabel *)setLabel{
    if (_setLabel == nil) {
        _setLabel = [[UILabel alloc]init];
    }
    return _setLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigation];
    
    [self setViewForCooperate];
    
    
    
    
}


#pragma mark - 页面设置
- (void)setViewForCooperate{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    //    scrollView.backgroundColor = [UIColor cyanColor];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    self.photoUrlArr = [[NSMutableArray alloc] init];
    
    //加盟状态
    UILabel *settingLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 100, 30)];
    settingLabel.text = @"加盟状态：";
    [scrollView addSubview:settingLabel];
    
    _setLabel.frame = CGRectMake(100, 20, 100, 30);
    //    _setLabel.text = @"正在审核";
    _setLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    _setLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:_setLabel];
    
    // 加盟信息
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, settingLabel.frame.origin.y + 30+15, self.view.frame.size.width-30, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:lineView];
    
    
    UILabel *idImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
    idImageLabel.center = lineView.center;
    idImageLabel.text = @"加盟信息";
    idImageLabel.textAlignment = NSTextAlignmentCenter;
    idImageLabel.backgroundColor = [UIColor whiteColor];
    idImageLabel.font = [UIFont systemFontOfSize:16];
    idImageLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:idImageLabel];
    
    
     // 营业执照名，号；法人姓名，身份证号
     
     UILabel *licenceName = [[UILabel alloc]init];
     licenceName.text = [NSString stringWithFormat:@"营业执照名：%@",_dataDictionary[@"fullname"]];
     licenceName.frame = CGRectMake(15, lineView.frame.origin.y + 31 , self.view.frame.size.width-30, 30);
     [scrollView addSubview:licenceName];
     
     UILabel *licenceNumber = [[UILabel alloc]init];
     licenceNumber.text = [NSString stringWithFormat:@"营业执照号：%@",_dataDictionary[@"businessLicense"]];
     licenceNumber.frame = CGRectMake(15, licenceName.frame.origin.y + 35, self.view.frame.size.width-30, 30);
     [scrollView addSubview:licenceNumber];
     
     
     UILabel *legalEntity = [[UILabel alloc]init];
     legalEntity.text = [NSString stringWithFormat:@"法人的姓名：%@",_dataDictionary[@"corporationName"]];
     legalEntity.frame = CGRectMake(15, licenceNumber.frame.origin.y + 35, self.view.frame.size.width-30, 30);
     [scrollView addSubview:legalEntity];
     
     
     UILabel *legalEntityId = [[UILabel alloc]init];
     legalEntityId.text = [NSString stringWithFormat:@"法人身份证：%@",_dataDictionary[@"corporationIdNo"]];
     legalEntityId.frame = CGRectMake(15, legalEntity.frame.origin.y + 35, self.view.frame.size.width-30, 30);
     [scrollView addSubview:legalEntityId];
     
     
     // 营业执照副本
     UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(15, legalEntityId.frame.origin.y + 30+15, self.view.frame.size.width-30, 1)];
     lineView2.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
     [scrollView addSubview:lineView2];
     
     
     UILabel *licenceDuplicate = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
     licenceDuplicate.center = lineView2.center;
     licenceDuplicate.text = @"营业执照副本";
     licenceDuplicate.textAlignment = NSTextAlignmentCenter;
     licenceDuplicate.backgroundColor = [UIColor whiteColor];
     licenceDuplicate.font = [UIFont systemFontOfSize:16];
     licenceDuplicate.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
     [scrollView addSubview:licenceDuplicate];
     
    
    UIButton *licenceDuplicateBut = [UIButton buttonWithType:UIButtonTypeCustom];
    licenceDuplicateBut.frame = CGRectMake(30, lineView2.frame.origin.y + 30, self.view.frame.size.width-60, (self.view.frame.size.width-60)*9/14.0);

//    [licenceDuplicateBut sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLHOST,_dataDictionary[@"bussinessLicensePic"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userImage"]];
    [licenceDuplicateBut sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp,_dataDictionary[@"bussinessLicensePic"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userImage"]];
    [scrollView addSubview:licenceDuplicateBut];
    licenceDuplicateBut.tag = 1;
    [licenceDuplicateBut addTarget:self action:@selector(imgButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoUrlArr addObject:[NSString stringWithFormat:@"%@%@",BaseHttp,_dataDictionary[@"bussinessLicensePic"]]];
//    licenceDuplicateBut.backgroundColor = [UIColor redColor];
    
//     UIImageView *licenceDuplicateImage = [[CLImageView alloc]init];
//     licenceDuplicateImage.frame = CGRectMake(30, lineView2.frame.origin.y + 30, self.view.frame.size.width-60, (self.view.frame.size.width-60)*9/14.0);
//     licenceDuplicateImage.contentMode = UIViewContentModeScaleAspectFit;
//     //    licenceDuplicateImage.backgroundColor = [UIColor darkGrayColor];
//     extern NSString* const URLHOST;
//     [licenceDuplicateImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLHOST,_dataDictionary[@"bussinessLicensePic"]]] placeholderImage:[UIImage imageNamed:@"userImage"]];
//     //    NSLog(@"-------_dataDictionary---%@",_dataDictionary[@"bussinessLicensePic"]);
//     //    licenceDuplicateImage.backgroundColor = [UIColor cyanColor];
//     [scrollView addSubview:licenceDuplicateImage];
    
     // 法人身份证正面照
     
     UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(15, licenceDuplicateBut.frame.origin.y + licenceDuplicateBut.frame.size.height + 30, self.view.frame.size.width-30, 1)];
     lineView3.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
     [scrollView addSubview:lineView3];
     
     
     UILabel *legalEntityIdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
     legalEntityIdLabel.center = lineView3.center;
     legalEntityIdLabel.text = @"法人身份证正面照";
     legalEntityIdLabel.textAlignment = NSTextAlignmentCenter;
     legalEntityIdLabel.backgroundColor = [UIColor whiteColor];
     legalEntityIdLabel.font = [UIFont systemFontOfSize:16];
    legalEntityIdLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
     
     [scrollView addSubview:legalEntityIdLabel];
     
    UIButton *legalEntityIdBut = [UIButton buttonWithType:UIButtonTypeCustom];
    legalEntityIdBut.frame = CGRectMake(30, lineView3.frame.origin.y + 30, self.view.frame.size.width-60, (self.view.frame.size.width-60)*9/14.0);
    [legalEntityIdBut sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp,_dataDictionary[@"corporationIdPicA"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userImage"]];
    [scrollView addSubview:legalEntityIdBut];
    legalEntityIdBut.tag = 2;
    [legalEntityIdBut addTarget:self action:@selector(imgButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoUrlArr addObject:[NSString stringWithFormat:@"%@%@",BaseHttp,_dataDictionary[@"corporationIdPicA"]]];
    
//     UIImageView *legalEntityIdImage = [[CLImageView alloc]init];
//     legalEntityIdImage.frame = CGRectMake(30, lineView3.frame.origin.y + 30, self.view.frame.size.width-60, (self.view.frame.size.width-60)*9/14.0);
//     //    legalEntityIdImage.backgroundColor = [UIColor darkGrayColor];
//     legalEntityIdImage.contentMode = UIViewContentModeScaleAspectFit;
//     [legalEntityIdImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLHOST,_dataDictionary[@"corporationIdPicA"]]] placeholderImage:[UIImage imageNamed:@"userImage"]];
//     [scrollView addSubview:legalEntityIdImage];
    
     
     // 发票信息
     UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(15, legalEntityIdBut.frame.origin.y + licenceDuplicateBut.frame.size.height + 30, self.view.frame.size.width-30, 1)];
     lineView4.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
     [scrollView addSubview:lineView4];
     
     
     UILabel *invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
     invoiceLabel.center = lineView4.center;
     invoiceLabel.text = @"发票信息";
     invoiceLabel.textAlignment = NSTextAlignmentCenter;
     invoiceLabel.backgroundColor = [UIColor whiteColor];
     invoiceLabel.font = [UIFont systemFontOfSize:16];
     invoiceLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
     [scrollView addSubview:invoiceLabel];
     
     
     // 发票抬头，纳税识别号，邮政编号
     UILabel *invoiceName = [[UILabel alloc]init];
     invoiceName.text = [NSString stringWithFormat:@"发票抬头名：%@",_dataDictionary[@"invoiceHeader"]];
     invoiceName.frame = CGRectMake(15, lineView4.frame.origin.y + 31 , self.view.frame.size.width-30, 30);
     [scrollView addSubview:invoiceName];
     
     
     UILabel *payNumber = [[UILabel alloc]init];
     payNumber.text = [NSString stringWithFormat:@"纳税识别号：%@",_dataDictionary[@"taxIdNo"]];
     payNumber.frame = CGRectMake(15, invoiceName.frame.origin.y + 35 , self.view.frame.size.width-30, 30);
     [scrollView addSubview:payNumber];
     
     UILabel *postcode = [[UILabel alloc]init];
     postcode.text = [NSString stringWithFormat:@"邮政编码号：%@",_dataDictionary[@"postcode"]];
     postcode.frame = CGRectMake(15, payNumber.frame.origin.y + 31 , self.view.frame.size.width-30, 30);
     [scrollView addSubview:postcode];
     
     
     UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(15, postcode.frame.origin.y + 40, self.view.frame.size.width-30, 1)];
     lineView5.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
     [scrollView addSubview:lineView5];
     
     
     // 邮寄地址，商户位置
     
     
     UILabel *addressLabel = [[UILabel alloc]init];
     addressLabel.text = [NSString stringWithFormat:@"邮寄地址：%@%@%@%@",_dataDictionary[@"province"],_dataDictionary[@"city"],_dataDictionary[@"district"],_dataDictionary[@"address"]];
     CGSize detailSize = [addressLabel.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT)];
     addressLabel.numberOfLines = 0;
     addressLabel.frame = CGRectMake(15, lineView5.frame.origin.y + 11 , self.view.frame.size.width-30, detailSize.height);
     [scrollView addSubview:addressLabel];
     
     
     UILabel *placeLabel = [[UILabel alloc]init];
     placeLabel.text = [NSString stringWithFormat:@"商户位置：%@%@%@%@",_dataDictionary[@"province"],_dataDictionary[@"city"],_dataDictionary[@"district"],_dataDictionary[@"address"]];
     placeLabel.numberOfLines = 0;
     detailSize = [placeLabel.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT)];
     placeLabel.frame = CGRectMake(15, CGRectGetMaxY(addressLabel.frame) + 5 , self.view.frame.size.width-30, detailSize.height);
     [scrollView addSubview:placeLabel];
    
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(placeLabel.frame) + 40);
}


- (void)imgButClick:(UIButton *)sender {
    
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = sender.superview;
    
    browser.imageCount = 2;
    
    browser.currentImageIndex = sender.tag - 1;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    
    UIImage *img = [UIImage imageNamed:@"userImage"];
    
    return img;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    NSURL *url = [NSURL URLWithString:self.photoUrlArr[index]];
    
    return url;
}

#pragma mark - 设置导航条
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"合作商加盟" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    //    navView.hidden = YES;
}

- (void)backBtnClick{
    
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
