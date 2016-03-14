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
//#import "GFHttpTool.h"


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
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UIScrollView *scrollerView;

@property (nonatomic, strong) GFTextField *invoiceHeadTxt;  // 发票抬头
@property (nonatomic, strong) GFTextField *payNumTxt;       // 纳税识别号
@property (nonatomic, strong) GFTextField *postNumTxt;      // 邮政编码

@property (nonatomic, strong) GFTextField *nameTxt;
@property (nonatomic, strong) GFTextField *phoneTxt;


@property (nonatomic, strong) UIButton *shengBut;
@property (nonatomic, strong) UIButton *shiBut;
@property (nonatomic, strong) UIButton *quBut;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *shengArr;
@property (nonatomic, strong) NSArray *shiArr;
@property (nonatomic, strong) NSArray *quArr;
@property (nonatomic, strong) NSArray *showArr;

@end

@implementation GFJoinInViewController_2

- (NSArray *)showArr {
    
    if(_showArr == nil) {
        _showArr = [[NSArray alloc] init];
    }
    
    return _showArr;
}

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
    
    jiange1 = kHeight * 0.0183;
    jiange2 = kWidth * 0.008;
    jiange3 = kHeight * 0.0234;
    
    jianjv1 = kWidth * 0.0417;
    jianjv2 = kWidth * 0.0324;
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // scrollerView
    self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
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
    
    self.shengArr = @[@"浙江省", @"河北省", @"河南省", @"湖北省", @"湖南省", @"四川省", @"甘肃省"];
    self.shiArr = @[@"温州市", @"武汉市", @"北京市", @"上海市"];
    self.quArr = @[@"龙湾区", @"鹿城区", @"瓯海区"];
    
    suo = 0;
    
    
    self.showArr = [NSArray arrayWithArray:self.shengArr];
    
    
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
    [self.shengBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.shengBut.titleLabel.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.shengBut];
    [self.shengBut addTarget:self action:@selector(shengButClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shengBut.layer.borderWidth = 1;
    // 请选择市
    CGFloat shiButW = shengButW;
    CGFloat shiButH = shengButH;
    CGFloat shiButX = CGRectGetMaxX(self.shengBut.frame) + jianjv2;
    CGFloat shiButY = shengButY;
    self.shiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shiBut.frame = CGRectMake(shiButX, shiButY, shiButW, shiButH);
    [self.shiBut setTitle:@"请选择市" forState:UIControlStateNormal];
    [self.shiBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.shiBut.titleLabel.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.shiBut];
    [self.shiBut addTarget:self action:@selector(shiButClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shiBut.layer.borderWidth = 1;
    // 请选择区
    CGFloat quButW = shengButW;
    CGFloat quButH = shengButH;
    CGFloat quButX = CGRectGetMaxX(self.shiBut.frame) + jianjv2;
    CGFloat quButY = shengButY;
    self.quBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quBut.frame = CGRectMake(quButX, quButY, quButW, quButH);
    [self.quBut setTitle:@"请选择区" forState:UIControlStateNormal];
    [self.quBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.quBut.titleLabel.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.quBut];
    [self.quBut addTarget:self action:@selector(quButClick:) forControlEvents:UIControlEventTouchUpInside];
    self.quBut.layer.borderWidth = 1;
    // tableView
    tableViewW = shengButW;
    tableViewH = 100;
    tableViewX = shengButX;
    tableViewY = CGRectGetMaxY(baseView.frame) - jiange3;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor redColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.layer.borderWidth = 1;
    self.tableView.hidden = YES;
    [self.scrollerView addSubview:self.tableView];
    // 请填写发票邮寄地址
    CGFloat baseView2W = kWidth;
    CGFloat baseView2H = 0.214 * kHeight;
    CGFloat baseView2X = 0;
    CGFloat baseView2Y = CGRectGetMaxY(baseView.frame);
    UIView *baseView2 = [[UIView alloc] initWithFrame:CGRectMake(baseView2X, baseView2Y, baseView2W, baseView2H)];
    baseView2.backgroundColor = [UIColor greenColor];
    [self.scrollerView addSubview:baseView2];
    UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(kWidth * 0.075, kHeight * 0.026, kWidth - (kWidth * 0.075) * 2, baseView2H - (kHeight * 0.026) * 2)];
    txtView.backgroundColor = [UIColor redColor];
    txtView.delegate = self;
    [baseView2 addSubview:txtView];
    
    
    // 联系人姓名
    self.nameTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(baseView2.frame) + jiange2 withPlaceholder:@"联系人姓名"];
    [self.scrollerView addSubview:self.nameTxt];
    
    
    // 联系人电话
    self.phoneTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.nameTxt.frame) + jiange2 withPlaceholder:@"联系人电话"];
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
    
}

- (void)joinInButClick {

    
    GFAlertView *alertView = [[GFAlertView alloc] initWithTipName:@"提交成功" withTipMessage:@"恭喜您资料提交成功，我们将会在一个工作日内审核信息并以短信的形式告知结果，请注意查收" withButtonNameArray:@[@"OK"]];
    [self.view addSubview:alertView];
    
}

- (void)agreeButClick {

    NSLog(@"协议");
}

- (void)textViewDidBeginEditing:(UITextView *)textView {

    
    
}

- (void)shengButClick:(UIButton *)sender {
    self.tableView.frame = CGRectMake(sender.frame.origin.x, tableViewY, tableViewW, tableViewH);
    self.showArr = [NSArray arrayWithArray:self.shengArr];
    [self.tableView reloadData];
    
    if(suo == 1 || suo == 0) {
        
        NSLog(@"请选择省份%@", self.shengArr);
        self.tableView.hidden = !self.tableView.hidden;
    }else {
        
        self.tableView.hidden = NO;
        
    }
    
    suo = 1;
    
    
    
}

- (void)shiButClick:(UIButton *)sender {
    
    self.tableView.frame = CGRectMake(sender.frame.origin.x, tableViewY, tableViewW, tableViewH);
    self.showArr = [NSArray arrayWithArray:self.shiArr];
    [self.tableView reloadData];
    
    if(suo == 2 || suo == 0) {
    
        NSLog(@"请选择市 %@", self.shiArr);
        
        
        
        self.tableView.hidden = !self.tableView.hidden;
    }else {
    
        self.tableView.hidden = NO;
        
    }
    
    suo = 2;
}

- (void)quButClick:(UIButton *)sender {
    self.tableView.frame = CGRectMake(sender.frame.origin.x, tableViewY, tableViewW, tableViewH);
    self.showArr = [NSArray arrayWithArray:self.quArr];
    [self.tableView reloadData];
    
    if(suo == 3 || suo == 0) {
        
        NSLog(@"请选择区%@", self.quArr);
        
        
        
        
        
        self.tableView.hidden = !self.tableView.hidden;
    
    }else {
        
        self.tableView.hidden = NO;
        
    }
    
    suo = 3;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.showArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.showArr[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(suo == 1) {
        
        [self.shengBut setTitle:self.showArr[indexPath.row] forState:UIControlStateNormal];
        self.tableView.hidden = YES;
    
    }else if(suo == 2) {
        
        [self.shiBut setTitle:self.showArr[indexPath.row] forState:UIControlStateNormal];
        self.tableView.hidden = YES;
    
    }else if(suo == 3) {
        
        [self.quBut setTitle:self.showArr[indexPath.row] forState:UIControlStateNormal];
        self.tableView.hidden = YES;
    
    }
    
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
