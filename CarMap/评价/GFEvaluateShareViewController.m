//
//  GFEvaluateAfterViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/3.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFEvaluateShareViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "GFHttpTool.h"



@interface GFEvaluateShareViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
}

@property (nonatomic, strong) GFNavigationView *navView;


@end

@implementation GFEvaluateShareViewController

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
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"评价" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    // 技师头像栏
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight * 0.15625)];
    iconView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:iconView];
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.15625, kWidth, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [iconView addSubview:lineView1];
    // 头像
    CGFloat iconImgViewW = 0.181 * kWidth;
    CGFloat iconImgViewH = iconImgViewW;
    CGFloat iconImgViewX = kWidth * 0.088;
    CGFloat iconImgViewY = (kHeight * 0.15625 - iconImgViewH) / 2.0;
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
    iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
    iconImgView.clipsToBounds = YES;
//    iconImgView.backgroundColor =[UIColor redColor];
//    [iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"23"]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
    iconImgView.image = [UIImage imageNamed:@"userHeadImage"];
    [iconView addSubview:iconImgView];
    // 姓名
    NSString *nameStr = @"技  师";
    NSMutableDictionary *nameDic = [[NSMutableDictionary alloc] init];
    nameDic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
    nameDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect nameRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nameDic context:nil];
    CGFloat nameLabW = nameRect.size.width;
    CGFloat nameLabH = nameRect.size.height;
    CGFloat nameLabX = CGRectGetMaxX(iconImgView.frame) + kWidth * 0.0463;
    CGFloat nameLabY = kHeight * 0.04;
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
    nameLab.text = nameStr;
    nameLab.font = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
//    nameLab.backgroundColor = [UIColor blueColor];
    [iconView addSubview:nameLab];
    // 订单数
    NSString *indentStr = @"订单数";
    NSMutableDictionary *indentDic = [[NSMutableDictionary alloc] init];
    indentDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    indentDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect indentRect = [indentStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:indentDic context:nil];
    CGFloat indentLabW = indentRect.size.width;
    CGFloat indentLabH = indentRect.size.height;
    CGFloat indentLabX = nameLabX;
    CGFloat indentLabY = CGRectGetMaxY(nameLab.frame) + kHeight * 0.0183;
    UILabel *indentLab = [[UILabel alloc] initWithFrame:CGRectMake(indentLabX, indentLabY, indentLabW, indentLabH)];
    indentLab.text = indentStr;
    indentLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
//    indentLab.backgroundColor = [UIColor blueColor];
    [iconView addSubview:indentLab];
   
    // 订单数目
    CGFloat numLabW = 100;
    CGFloat numLabH = indentLabH;
    CGFloat numLabX = CGRectGetMaxX(indentLab.frame) + 5 / 320.0 * kWidth;
    CGFloat numLabY = indentLabY;
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(numLabX, numLabY, numLabW, numLabH)];
//    numLab.text = @"200";
    numLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    numLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [iconView addSubview:numLab];
    
    
    // 星星
    for(int i=0; i<5-_star; i++) {
        
        CGFloat imgViewW = (kWidth - kWidth * 0.25 * 2) / 5.0;
        CGFloat imgViewH = imgViewW - 4 / 320.0 * kWidth;
        CGFloat imgViewX = kWidth * 0.21 + (imgViewW + 1 / 320.0 * kWidth) * (i+_star);
        CGFloat imgViewY = CGRectGetMaxY(iconView.frame) + kHeight * 0.09375;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        [self.view addSubview:imgView];
        imgView.image = [UIImage imageNamed:@"detailsStarDark"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
//        imgView.backgroundColor = [UIColor redColor];
    }
    
    for(int i=0; i<_star; i++) {
        
        CGFloat imgViewW = (kWidth - kWidth * 0.25 * 2) / 5.0;
        CGFloat imgViewH = imgViewW - 4 / 320.0 * kWidth;
        CGFloat imgViewX = kWidth * 0.21 + (imgViewW + 1 / 320.0 * kWidth) * i;
        CGFloat imgViewY = CGRectGetMaxY(iconView.frame) + kHeight * 0.09375;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        [self.view addSubview:imgView];
        imgView.image = [UIImage imageNamed:@"information"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
//        imgView.backgroundColor = [UIColor greenColor];
    }

    [GFHttpTool GetTechnicianParameters:@{@"orderId":_orderId} success:^(id responseObject) {
        NSLog(@"请求成功－－－%@---",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSDictionary *technicianDictionary = dataDictionary[@"technician"];
            [iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345%@",technicianDictionary[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
            nameLab.text = technicianDictionary[@"name"];
            numLab.text = [NSString stringWithFormat:@"%@",dataDictionary[@"totalOrders"]];
            
            
            
            
            // 橘色星星
            for(int i=0; i<round([dataDictionary[@"starRate"] floatValue]); i++) {
                
                CGFloat starImgViewW = nameLabH;
                CGFloat starImgViewH = nameLabH;
                CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + kHeight * 0.014 + starImgViewW * i;
                CGFloat starImgViewY = nameLabY;
                UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
                starImgView.contentMode = UIViewContentModeScaleAspectFit;
                //        starImgView.backgroundColor = [UIColor redColor];
                starImgView.image = [UIImage imageNamed:@"information"];
                [iconView addSubview:starImgView];
            }
            
            
            
            // 灰色星星
            for(int i=0; i < 5-round([dataDictionary[@"starRate"] floatValue]); i++) {
                
                CGFloat starImgViewW = nameLabH;
                CGFloat starImgViewH = nameLabH;
                CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + kHeight * 0.014 + starImgViewW * (i + round([dataDictionary[@"starRate"] floatValue]));
                CGFloat starImgViewY = nameLabY;
                UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
                starImgView.contentMode = UIViewContentModeScaleAspectFit;
                //        starImgView.backgroundColor = [UIColor greenColor];
                starImgView.image = [UIImage imageNamed:@"detailsStarDark"];
                [iconView addSubview:starImgView];
            }
            
            
            
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败－－－%@---",error);
    }];
    
    
    // 感谢您
    CGFloat thankLabW = 0.717 * kWidth;
    CGFloat thankLabH = kHeight * 0.073;
    CGFloat thankLabX = (kWidth - thankLabW) / 2.0;
    CGFloat thankLabY = CGRectGetMaxY(iconView.frame) + kHeight * 0.183;
    UILabel *thankLab = [[UILabel alloc] initWithFrame:CGRectMake(thankLabX, thankLabY, thankLabW, thankLabH)];
    thankLab.numberOfLines = 0;
    thankLab.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    thankLab.text = @"感谢您对本次技师提交的评价，赶快分享赢现金红包！";
    [self.view addSubview:thankLab];
    
    // 分享按钮
    CGFloat shareButW = kWidth * 0.172;
    CGFloat shareButH = shareButW;
    CGFloat shareButX = kWidth * 0.213;
    CGFloat shareButY = kHeight - shareButH - kHeight * 0.052;
    UIButton *shareBut = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBut.frame = CGRectMake(shareButX, shareButY, shareButW, shareButH);
//    shareBut.layer.borderWidth = 1;
//    shareBut.layer.borderColor = [[UIColor blackColor] CGColor];
//    shareBut.layer.cornerRadius = shareButW * 0.5;
//    [shareBut setTitle:@"分享" forState:UIControlStateNormal];
    [shareBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    shareBut.backgroundColor = [UIColor redColor];
    [shareBut addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shareBut setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.view addSubview:shareBut];
    
    
    // 首页按钮
    CGFloat homeButW = kWidth * 0.172;
    CGFloat homeButH = homeButW;
    CGFloat homeButX = kWidth - homeButW - kWidth * 0.213;
    CGFloat homeButY = kHeight - homeButH - kHeight * 0.052;
    UIButton *homeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBut.frame = CGRectMake(homeButX, homeButY, homeButW, homeButH);
//    homeBut.layer.borderWidth = 1;
//    homeBut.layer.borderColor = [[UIColor blackColor] CGColor];
//    homeBut.layer.cornerRadius = homeButW * 0.5;
//    [homeBut setTitle:@"首页" forState:UIControlStateNormal];
    [homeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    homeBut.backgroundColor = [UIColor redColor];
    [homeBut addTarget:self action:@selector(homeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [homeBut setBackgroundImage:[UIImage imageNamed:@"Home"] forState:UIControlStateNormal];
    [self.view addSubview:homeBut];
    
    
    
    
}


#pragma mark - 分享按钮响应方法
- (void)shareBtnClick{
    NSLog(@"分享");
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"564d41b4e0f55a596d003fe4"
                                      shareText:@"车邻邦测试分享消息"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToSina,nil]
                                       delegate:self];
}


#pragma mark - 首页按钮响应方法
- (void)homeBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}




- (void)leftButClick {
    
    UIViewController *view = self.navigationController.viewControllers[2];
    [self.navigationController popToViewController:view animated:YES];
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
