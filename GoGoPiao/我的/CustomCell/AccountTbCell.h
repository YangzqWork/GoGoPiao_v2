//
//  AccountTbCell.h
//  GoGoPiao
//
//  Created by yzq on 13-9-28.
//  Copyright (c) 2013年 Cho-Yeung Lam. All rights reserved.
//
#define kScreenBoundsSize [UIScreen mainScreen].bounds.size
#define kKeyMyTitle @"myCellTitle"
#define kKeyMyIcon @"myCellicon"

#import <UIKit/UIKit.h>

@interface AccountTbCell : UITableViewCell{
    UIImageView *_iconView;
    BOOL needToLayout;
}
@property (nonatomic,strong) NSDictionary *dataDiction;
@property (nonatomic,strong) UILabel *titleLabel;

@end
