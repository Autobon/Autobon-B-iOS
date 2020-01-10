//
//  CLEvaluateTechTableViewCell.h
//  CarMapB
//
//  Created by inCarL on 2020/1/8.
//  Copyright © 2020 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLEvaluateTechTableViewCell : UITableViewCell<UITextViewDelegate>
{
    NSMutableArray *_starBtnArray;
    NSMutableArray *_selectBtnArray;
    NSInteger _star;
    UITextView *_otherTextView;
    NSMutableArray *_starImageArray;
}

@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orderNumberValueLabel;

@property (nonatomic, strong) NSDictionary *modelDict;
@property (nonatomic, strong) NSMutableDictionary *commentDict;
@end

NS_ASSUME_NONNULL_END
