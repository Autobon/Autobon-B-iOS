//
//  GFJoinInViewController_2.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/1.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFJoinInViewController_2.h"
#import "GFTitleView.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFAlertView.h"
#import "GFTipView.h"
#import "GFHttpTool.h"
#import "CLDelegateViewController.h"
#import "CLTouchScrollView.h"



@interface GFJoinInViewController_2 () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    CGFloat jianjv1;
    CGFloat jianjv2;
    
    CGFloat tableViewW;
    CGFloat tableViewH;
    CGFloat tableViewX;
    CGFloat tableViewY;
    
    CGFloat suo;
    
    NSArray *_addressArray;
    NSMutableArray *_tableViewArray;
    NSMutableArray *_provinceArray;
    NSInteger _provinceNumber;
    NSInteger _cityNumber;
    
    NSString *_shengString;
    NSString *_shiString;
    NSString *_quString;
    
    UITextView *_txtView;
    
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) CLTouchScrollView *scrollerView;

@property (nonatomic, strong) GFTextField *invoiceHeadTxt;  // 发票抬头
@property (nonatomic, strong) GFTextField *payNumTxt;       // 纳税识别号
@property (nonatomic, strong) GFTextField *postNumTxt;      // 邮政编码

@property (nonatomic, strong) GFTextField *nameTxt;
@property (nonatomic, strong) GFTextField *phoneTxt;


@property (nonatomic, strong) UIButton *shengBut;
@property (nonatomic, strong) UIButton *shiBut;
@property (nonatomic, strong) UIButton *quBut;

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation GFJoinInViewController_2



- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDictionary *addressDictionary = []
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSDictionary *plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//    NSLog(@"----addressDictionary---%@---",plistDictionary);
    _addressArray = plistDictionary[@"address"];
    _tableViewArray = [[NSMutableArray alloc]init];
//    _provinceArray = [[NSMutableArray alloc]init];
    
//    _tableViewArray = _provinceArray;
    
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
    jiange3 = kHeight * 0.0234;
    
    jianjv1 = kWidth * 0.0417;
    jianjv2 = kWidth * 0.0324;
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // scrollerView
    self.scrollerView = [[CLTouchScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
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
    
   
    
    suo = 0;
    
    
    
    // 发票信息
    GFTitleView *invoiceMsgView = [[GFTitleView alloc] initWithY:jiange1 + 64 Title:@"发票信息"];
    [self.scrollerView addSubview:invoiceMsgView];
    
    // 发票抬头
    self.invoiceHeadTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(invoiceMsgView.frame) + jiange2 withPlaceholder:@"发票抬头"];
    [self.scrollerView addSubview:self.invoiceHeadTxt];
    
    // 纳税识别号
    self.payNumTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.invoiceHeadTxt.frame) + jiange2 withPlaceholder:@"纳税识别号"];
    [self.scrollerView addSubview:self.payNumTxt];
    
    // 邮政编码
    self.postNumTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.payNumTxt.frame) + jiange2 withPlaceholder:@"邮政编码"];
    self.postNumTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollerView addSubview:self.postNumTxt];
    
    
    // 地址
    GFTitleView *addressView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(self.postNumTxt.frame) + jiange1 Title:@"地址"];
    [self.scrollerView addSubview:addressView];
    
    // 省、市、区选择
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = kHeight * 0.104;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = CGRectGetMaxY(addressView.frame) + jiange2;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    baseView.userInteractionEnabled = YES;
    [self.scrollerView addSubview:baseView];
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH, baseViewW, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    // 请选择省份
    CGFloat shengButW = (kWidth - jianjv1 * 2 - jianjv2 * 2) / 3.0;
    CGFloat shengButH = baseViewH - 2 * jiange3;
    CGFloat shengButX = jianjv1;
    CGFloat shengButY = jiange3;
    self.shengBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shengBut.frame = CGRectMake(shengButX, shengButY, shengButW, shengButH);
    [self.shengBut setTitle:@"请选省份" forState:UIControlStateNormal];
    [self.shengBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 1, 0, 10)];
    [self.shengBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.shengBut.titleLabel.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.shengBut];
    [self.shengBut addTarget:self action:@selector(shengButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.shengBut setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
//    self.shengBut.layer.borderWidth = 1;
    // 请选择市
    CGFloat shiButW = shengButW;
    CGFloat shiButH = shengButH;
    CGFloat shiButX = CGRectGetMaxX(self.shengBut.frame) + jianjv2;
    CGFloat shiButY = shengButY;
    self.shiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shiBut.frame = CGRectMake(shiButX, shiButY, shiButW, shiButH);
    [self.shiBut setTitle:@"请选择市" forState:UIControlStateNormal];
    [self.shiBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 1, 0, 10)];
    [self.shiBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.shiBut.titleLabel.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.shiBut];
    [self.shiBut addTarget:self action:@selector(shiButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.shiBut setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
//    self.shiBut.layer.borderWidth = 1;
    // 请选择区
    CGFloat quButW = shengButW;
    CGFloat quButH = shengButH;
    CGFloat quButX = CGRectGetMaxX(self.shiBut.frame) + jianjv2;
    CGFloat quButY = shengButY;
    self.quBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quBut.frame = CGRectMake(quButX, quButY, quButW, quButH);
    [self.quBut setTitle:@"请选择区" forState:UIControlStateNormal];
    [self.quBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 1, 0, 10)];
    [self.quBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.quBut.titleLabel.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.quBut];
    [self.quBut addTarget:self action:@selector(quButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.quBut setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
//    self.quBut.layer.borderWidth = 1;
    // tableView
    tableViewW = shengButW;
    tableViewH = 100;
    tableViewX = shengButX;
    tableViewY = CGRectGetMaxY(baseView.frame) - jiange3;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.layer.borderWidth = 1;
    self.tableView.hidden = YES;
    
    // 请填写发票邮寄地址
    CGFloat baseView2W = kWidth;
    CGFloat baseView2H = 0.214 * kHeight;
    CGFloat baseView2X = 0;
    CGFloat baseView2Y = CGRectGetMaxY(baseView.frame);
    UIView *baseView2 = [[UIView alloc] initWithFrame:CGRectMake(baseView2X, baseView2Y, baseView2W, baseView2H)];
//    baseView2.backgroundColor = [UIColor greenColor];
    [self.scrollerView addSubview:baseView2];
    _txtView = [[UITextView alloc] initWithFrame:CGRectMake(kWidth * 0.075, kHeight * 0.026, kWidth - (kWidth * 0.075) * 2, baseView2H - (kHeight * 0.026) * 2)];
    _txtView.text = @"请填写发票邮寄地址";
    _txtView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
//    txtView.backgroundColor = [UIColor redColor];
    
    _txtView.delegate = self;
    [baseView2 addSubview:_txtView];
    
    [self.scrollerView addSubview:self.tableView];
    
    // 联系人姓名
    self.nameTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(baseView2.frame) + jiange2 withPlaceholder:@"联系人姓名"];
    [self.scrollerView addSubview:self.nameTxt];
    
    
    // 联系人电话
    self.phoneTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.nameTxt.frame) + jiange2 withPlaceholder:@"联系人电话"];
    self.phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollerView addSubview:self.phoneTxt];
    
    
    // 加盟
    CGFloat joinInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat joinInButH = kHeight * 0.07;
    CGFloat joinInButX = kWidth * 0.116;
    CGFloat joinInButY = CGRectGetMaxY(self.phoneTxt.frame) + kHeight * 0.0443;
    UIButton *joinInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    joinInBut.frame = CGRectMake(joinInButX, joinInButY, joinInButW, joinInButH);
    joinInBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    joinInBut.layer.cornerRadius = 5;
    [joinInBut setTitle:@"加盟" forState:UIControlStateNormal];
    [self.scrollerView addSubview:joinInBut];
    [joinInBut addTarget:self action:@selector(joinInButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 车邻邦合作商加盟服务协议
    CGFloat agreeLabW = kWidth;
    CGFloat agreeLabH = kHeight * 0.024;
    CGFloat agreeLabX = 0;
    CGFloat agreeLabY = CGRectGetMaxY(joinInBut.frame) + jiange2 * 1.5;
    UILabel *agreeLab = [[UILabel alloc] initWithFrame:CGRectMake(agreeLabX, agreeLabY, agreeLabW, agreeLabH)];
    [self.scrollerView addSubview:agreeLab];
    agreeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    agreeLab.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *MAStr = [[NSMutableAttributedString alloc] initWithString:@"点击“注册”代表本人已阅读并同意《车邻邦合作商加盟服务协议》"];
    [MAStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] range:NSMakeRange(16, 14)];
    agreeLab.attributedText = MAStr;
    agreeLab.font = [UIFont systemFontOfSize:10.5 / 320.0 * kWidth];
    agreeLab.userInteractionEnabled = YES;
    
    CGFloat agreeButW = kWidth / 2.0;
    CGFloat agreeButH = agreeLabH;
    CGFloat agreeButX = kWidth / 2.0;
    CGFloat agreeButY = 0;
    UIButton *agreeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBut.frame = CGRectMake(agreeButX, agreeButY, agreeButW, agreeButH);
    [agreeLab addSubview:agreeBut];
    [agreeBut addTarget:self action:@selector(agreeButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSLog(@"---_dataForPast---%@---",_dataForPastDictionary);
    if (_dataForPastDictionary) {
        self.invoiceHeadTxt.text = _dataForPastDictionary[@"invoiceHeader"];
        self.payNumTxt.text = _dataForPastDictionary[@"taxIdNo"];
        self.postNumTxt.text = _dataForPastDictionary[@"postcode"];
        [self.shengBut setTitle:_dataForPastDictionary[@"province"] forState:UIControlStateNormal];
        [self.shengBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shengString = _dataForPastDictionary[@"province"];
        [self.shiBut setTitle:_dataForPastDictionary[@"city"] forState:UIControlStateNormal];
        [self.shiBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shiString = _dataForPastDictionary[@"city"];
        [self.quBut setTitle:_dataForPastDictionary[@"district"] forState:UIControlStateNormal];
        [self.quBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _quString = _dataForPastDictionary[@"district"];
        _txtView.text = _dataForPastDictionary[@"address"];
        _txtView.textColor = [UIColor blackColor];
        self.nameTxt.text = _dataForPastDictionary[@"contact"];
        self.phoneTxt.text = _dataForPastDictionary[@"contactPhone"];
        
    }
    
}

#pragma mark - 加盟按钮的响应方法
- (void)joinInButClick {
    [self.view endEditing:YES];
    if (self.invoiceHeadTxt.text.length == 0) {
        [self addAlertView:@"请填写发票抬头"];
    }else{
        if (self.payNumTxt.text.length == 0) {
            [self addAlertView:@"请填写纳税识别号"];
        }else{
            if (self.postNumTxt.text.length == 0) {
                [self addAlertView:@"邮政编码"];
            }else{
                if (!_shengString) {
                    [self addAlertView:@"请选择省份"];
                }else{
                    if (!_shiString) {
                        [self addAlertView:@"请选择城市"];
                    }else{
                        if (!_quString) {
                            [self addAlertView:@"请选择地区"];
                        }else{
                            if ([_txtView.text isEqualToString:@"请填写发票邮寄地址"]) {
                                [self addAlertView:@"请填写发票邮寄地址"];
                            }else{
                                if (self.nameTxt.text.length == 0) {
                                    [self addAlertView:@"请填写用户名"];
                                }else{
                                    if ([self isPhoneNumber:_phoneTxt.text]) {
                                        
                                        [_dataDictionary setObject:_invoiceHeadTxt.text forKey:@"invoiceHeader"];
                                        [_dataDictionary setObject:_payNumTxt.text forKey:@"taxIdNo"];
                                        [_dataDictionary setObject:_postNumTxt.text forKey:@"postcode"];
                                        [_dataDictionary setObject:_shengString forKey:@"province"];
                                        [_dataDictionary setObject:_shiString forKey:@"city"];
                                        [_dataDictionary setObject:_quString forKey:@"district"];
                                        [_dataDictionary setObject:_txtView.text forKey:@"address"];
                                        [_dataDictionary setObject:_nameTxt.text forKey:@"contact"];
                                        [_dataDictionary setObject:_phoneTxt.text forKey:@"contactPhone"];
                                        
                                        NSLog(@"---_dataDictionary--%@---",_dataDictionary);
                                        
                                        [GFHttpTool postCheckForUser:_dataDictionary success:^(id responseObject) {
                                            if ([responseObject[@"result"] integerValue] == 1) {
                                                [self.navigationController popToRootViewControllerAnimated:YES];
                                            }else{
                                                [self addAlertView:responseObject[@"message"]];
                                            }
                                            NSLog(@"－－－请求成功－－%@---",responseObject);
                                            
                                        } failure:^(NSError *error) {
                                            
                                            NSLog(@"失败原因--%@--",error);
                                            
                                        }];
                                        
                                    }else{
                                        [self addAlertView:@"请填写合法的手机号"];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
//    GFAlertView *alertView = [[GFAlertView alloc] initWithTipName:@"提交成功" withTipMessage:@"恭喜您资料提交成功，我们将会在一个工作日内审核信息并以短信的形式告知结果，请注意查收" withButtonNameArray:@[@"OK"]];
//    [alertView.okBut addTarget:self action:@selector(OKBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:alertView];
    
}

- (void)OKBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}




- (void)agreeButClick {

    CLDelegateViewController *delegateView = [[CLDelegateViewController alloc]init];
    [self.navigationController pushViewController:delegateView animated:YES];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {

    if ([textView.text isEqualToString:@"请填写发票邮寄地址"]) {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"请填写发票邮寄地址";
        textView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    }
}
#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}
#pragma mark - 判断输入字符串是否是手机号
- (BOOL)isPhoneNumber:(NSString *)number{
    
    number =  [number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if ([phoneTest evaluateWithObject:number])
    {
        return YES;
    }else{
        return NO;
    }
}


- (void)shengButClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (suo != 1) {
        __block NSMutableArray *array = [[NSMutableArray alloc]init];
        [_addressArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:obj[@"name"]];
        }];
        _tableViewArray = [[NSMutableArray alloc]initWithArray:array];
        self.tableView.frame = CGRectMake(sender.frame.origin.x, tableViewY, tableViewW+30, tableViewH);
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        suo = 1;
    }else{
        suo = 0;
        self.tableView.hidden = YES;
    }
    
    NSLog(@"省－－－%@-",_tableViewArray);
    
    
}

- (void)shiButClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    
    if (suo != 2) {
        self.tableView.frame = CGRectMake(sender.frame.origin.x, tableViewY, tableViewW+20, tableViewH);
        self.tableView.hidden = NO;
        
        NSDictionary *dictionary = _addressArray[_provinceNumber];
        NSArray *cityArray = dictionary[@"sub"];
        //        [_tableViewArray removeAllObjects];
        __block NSMutableArray *array = [[NSMutableArray alloc]init];
        [cityArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:obj[@"name"]];
        }];
        _tableViewArray = [[NSMutableArray alloc]initWithArray:array];
        
        
        
        [self.tableView reloadData];
        suo = 2;
    }else{
        suo = 0;
        self.tableView.hidden = YES;
    }
    
    
    
    
}

- (void)quButClick:(UIButton *)sender {
     [self.view endEditing:YES];
    
    if (suo != 3) {
        suo = 3;
        self.tableView.frame = CGRectMake(sender.frame.origin.x, tableViewY, tableViewW+20, tableViewH);
        self.tableView.hidden = NO;
        
        NSDictionary *dictionary = _addressArray[_provinceNumber];
        NSArray *cityArray = dictionary[@"sub"];
        NSLog(@"-----cityArray----%@----_cityNumber---%ld--",cityArray,(long)_cityNumber);
        NSDictionary *areaDictionary = cityArray[_cityNumber];
        _tableViewArray = areaDictionary[@"sub"];
        
        
        [self.tableView reloadData];
        suo = 3;
    }else{
        suo = 0;
        self.tableView.hidden = YES;
    }
    
    
   
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = _tableViewArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(suo == 1) {
        
        [self.shengBut setTitle:_tableViewArray[indexPath.row] forState:UIControlStateNormal];
        [self.shengBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _provinceNumber = indexPath.row;
        _shengString = _tableViewArray[indexPath.row];
        
    }else if(suo == 2) {
        
        [self.shiBut setTitle:_tableViewArray[indexPath.row] forState:UIControlStateNormal];
        [self.shiBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cityNumber = indexPath.row;
        _shiString = _tableViewArray[indexPath.row];
    }else if(suo == 3) {
        [self.quBut setTitle:_tableViewArray[indexPath.row] forState:UIControlStateNormal];
        [self.quBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _quString = _tableViewArray[indexPath.row];
    
    }
    self.tableView.hidden = YES;
    suo = 0;
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
