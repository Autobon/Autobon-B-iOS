//
//  CLEvaluateTechTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2020/1/8.
//  Copyright © 2020 mll. All rights reserved.
//

#import "CLEvaluateTechTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CLEvaluateTechTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _starImageArray = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        UIView *baseView = [[UIView alloc]init];
        [self addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        
        UIView *headerView = [[UIView alloc]init];
        headerView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(baseView);
            make.height.mas_offset(100);
        }];
        
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.image = [UIImage imageNamed:@"right-close"];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        [headerView addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.right.equalTo(headerView).offset(-30);
            make.width.mas_offset(12);
            make.height.mas_offset(12);
        }];
        
        
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.image = [UIImage imageNamed:@"userHeadImage"];
        _headerImageView.layer.cornerRadius = 35;
        _headerImageView.clipsToBounds = YES;
        [headerView addSubview:_headerImageView];
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.left.equalTo(headerView).offset(30);
            make.width.mas_offset(70);
            make.height.mas_offset(70);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"";
        [headerView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImageView.mas_right).offset(15);
            make.bottom.equalTo(self.headerImageView.mas_centerY).offset(-5);
            make.height.mas_offset(20);
        }];
        
        UILabel *orderNumerTitleLabel = [[UILabel alloc] init];
        orderNumerTitleLabel.text = @"订单数";
        orderNumerTitleLabel.font = [UIFont systemFontOfSize:11];
        [headerView addSubview:orderNumerTitleLabel];
        [orderNumerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImageView.mas_right).offset(15);
            make.top.equalTo(self.headerImageView.mas_centerY).offset(5);
            make.height.mas_offset(20);
        }];
        
        _orderNumberValueLabel = [[UILabel alloc] init];
        _orderNumberValueLabel.text = @"";
        _orderNumberValueLabel.font = [UIFont systemFontOfSize:11];
        _orderNumberValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [headerView addSubview:_orderNumberValueLabel];
        [_orderNumberValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orderNumerTitleLabel.mas_right).offset(5);
            make.centerY.equalTo(orderNumerTitleLabel);
            make.height.mas_offset(20);
        }];
        
        UIView *detailBaseView = [[UIView alloc]init];
        detailBaseView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:detailBaseView];
        [detailBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(baseView);
            make.top.equalTo(headerView.mas_bottom).offset(5);
            make.bottom.equalTo(baseView).offset(-5);
        }];
    
        _starBtnArray = [[NSMutableArray alloc]init];
        for(int i=0; i<5; i++) {
            
            UIButton *starBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + 40 * i, 20, 30, 30)];
            [detailBaseView addSubview:starBtn];
            [starBtn setBackgroundImage:[UIImage imageNamed:@"information"] forState:UIControlStateNormal];
            [_starBtnArray addObject:starBtn];
            starBtn.tag = i+1;
            [starBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        _selectBtnArray = [[NSMutableArray alloc]init];
        
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat jiange1 = kWidth * 0.033;
        CGFloat jiange2 = kWidth * 0.065;
        
        CGFloat jianjv3 = kHeight * 0.02865;
        CGFloat jianjv4 = kHeight * 0.02;
        
        // 准时到达
        UIView *daodaView = [self messageButView:@"准时到达" withSelected:YES withX:jiange2 withY:90];
        [detailBaseView addSubview:daodaView];
        
        // 准时完工
        UIView *wangongView = [self messageButView:@"准时完工" withSelected:YES withX:kWidth * 0.676 withY:90];
        [detailBaseView addSubview:wangongView];
        
        // 技术专业
        UIView *zhuanyeView = [self messageButView:@"技术专业" withSelected:YES withX:jiange2 withY:CGRectGetMaxY(wangongView.frame) + jianjv4];
        [detailBaseView addSubview:zhuanyeView];
        
        // 着装整洁
        UIView *zhengjieView = [self messageButView:@"着装整洁" withSelected:YES withX:kWidth * 0.676 withY:CGRectGetMaxY(wangongView.frame) + jianjv4];
        [detailBaseView addSubview:zhengjieView];
        
        // 车辆保护超级棒
        UIView *bangView = [self messageButView:@"车辆保护超级棒" withSelected:YES withX:jiange2 withY:CGRectGetMaxY(zhengjieView.frame) + jianjv4];
        [detailBaseView addSubview:bangView];
        
        // 态度好
        UIView *haoView = [self messageButView:@"态度好" withSelected:YES withX:kWidth * 0.676 withY:CGRectGetMaxY(zhengjieView.frame) + jianjv4];
        [detailBaseView addSubview:haoView];
        
        // 边线
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(haoView.frame) - 1 + jianjv3, kWidth - jiange1 * 2, 1)];
        lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [detailBaseView addSubview:lineView2];
        
        // 其他意见和建议
        CGFloat otherLabW = kWidth - jiange2 * 2;
        CGFloat otherLabH = 80;
        CGFloat otherLabX = jiange2;
        CGFloat otherLabY = CGRectGetMaxY(lineView2.frame) + jianjv4;
        _otherTextView = [[UITextView alloc] initWithFrame:CGRectMake(otherLabX, otherLabY, otherLabW, otherLabH)];
        _otherTextView.backgroundColor = [UIColor clearColor];
        _otherTextView.delegate = self;
        _otherTextView.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        _otherTextView.text = @"其他意见和建议";
        _otherTextView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        //    otherLab.backgroundColor = [UIColor redColor];
        [detailBaseView addSubview:_otherTextView];
        
        
    }
    return self;
}

- (void)setModelDict:(NSDictionary *)modelDict{
    _modelDict = modelDict;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp,modelDict[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
    self.nameLabel.text = modelDict[@"name"];
    self.orderNumberValueLabel.text = [NSString stringWithFormat:@"%@", modelDict[@"totalOrders"]];
    [_starImageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [_starImageArray removeAllObjects];
    // 橘色星星
    for(int i=0; i<round([modelDict[@"starRate"] floatValue]); i++) {
        
        UIImageView *starImgView = [[UIImageView alloc] init];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        starImgView.image = [UIImage imageNamed:@"information"];
        [self addSubview:starImgView];
        [starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(10 + 20*i);
            make.centerY.equalTo(self.nameLabel);
            make.height.mas_offset(16);
            make.width.mas_offset(16);
        }];
        [_starImageArray addObject:starImgView];
    }
    
    // 灰色星星
    for(int i=round([modelDict[@"starRate"] floatValue]); i < 5; i++) {
        
        UIImageView *starImgView = [[UIImageView alloc] init];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        //        starImgView.backgroundColor = [UIColor greenColor];
        starImgView.image = [UIImage imageNamed:@"detailsStarDark"];
        [self addSubview:starImgView];
        [starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(10 + 20*i);
            make.centerY.equalTo(self.nameLabel);
            make.height.mas_offset(16);
            make.width.mas_offset(16);
        }];
        [_starImageArray addObject:starImgView];
    }
}

- (void)setCommentDict:(NSMutableDictionary *)commentDict{
    _commentDict = commentDict;
    NSString *adviceString = commentDict[@"advice"];
    if (adviceString.length == 0 || [adviceString isEqualToString:@""]) {
        _otherTextView.text = @"其他意见和建议";
        _otherTextView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    }
    
    NSArray *keyArray = @[@"arriveOnTime", @"completeOnTime", @"professional", @"dressNeatly", @"carProtect", @"goodAttitude"];
    [_selectBtnArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL buttonType = commentDict[keyArray[idx]];
        if (buttonType == true){
            obj.selected = YES;
        }else{
            obj.selected = NO;
        }
    }];
    
}





#pragma mark - 评星按钮的响应方法
- (void)starBtnClick:(UIButton *)button{
    
    _star = button.tag;
    
    [_starBtnArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setBackgroundImage:[UIImage imageNamed:@"detailsStarDark"] forState:UIControlStateNormal];
    }];
    for (int i = 0; i < button.tag; i++) {
        UIButton *starBtn = _starBtnArray[i];
        [starBtn setBackgroundImage:[UIImage imageNamed:@"information"] forState:UIControlStateNormal];
    }
    
    
}

- (UIView *)messageButView:(NSString *)messageStr withSelected:(BOOL)select withX:(CGFloat)x withY:(CGFloat)y{
    
    UIButton *imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBut.frame = CGRectMake(0, 0, 150, 17);
    imgBut.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 130);
//    imgBut.backgroundColor = [UIColor cyanColor];
//    [imgBut setImage:[UIImage imageNamed:@"over.png"] forState:UIControlStateSelected];
//    [imgBut setImage:[UIImage imageNamed:@"overClick.png"] forState:UIControlStateNormal];
    [imgBut setImage:[UIImage imageNamed:@"over.png"] forState:UIControlStateNormal];
    [imgBut setImage:[UIImage imageNamed:@"overClick.png"] forState:UIControlStateSelected];
    imgBut.selected = select;
    [imgBut addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtnArray addObject:imgBut];
    
    NSString *fenStr = messageStr;
    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    
    CGFloat labW = fenRect.size.width;
    CGFloat labH = 20;
    CGFloat labX = 20;
    CGFloat labY = 0;
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(labX, labY, labW, labH);
    lab.font = [UIFont systemFontOfSize:15];
    lab.text = messageStr;
    
//    CGFloat baseViewW = labX + labW;
    CGFloat baseViewH = labH;
    CGFloat baseViewX = x;
    CGFloat baseViewY = y;
    UIButton *baseView = [[UIButton alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, 150, baseViewH)];
    [baseView addSubview:imgBut];
    [baseView addSubview:lab];
    
    return baseView;
}

- (void)selectBtnClick:(UIButton *)button{
    button.selected = !button.selected;
    
    NSArray *keyArray = @[@"arriveOnTime", @"completeOnTime", @"professional", @"dressNeatly", @"carProtect", @"goodAttitude"];
    [_selectBtnArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.selected == YES){
            self.commentDict[keyArray[idx]] = @(true);
        }else{
            self.commentDict[keyArray[idx]] = @(false);
        }
    }];
    ICLog(@"self.commentDict---%@--",self.commentDict);
}

#pragma mark - textView的协议方法
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"其他意见和建议"]) {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"其他意见和建议";
        textView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    }else{
        self.commentDict[@"advice"] = textView.text;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    ICLog(@"textViewChange---%@---", textView.text);
    if (textView.text.length == 0) {
        textView.text = @"其他意见和建议";
        textView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    }else{
        self.commentDict[@"advice"] = textView.text;
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
