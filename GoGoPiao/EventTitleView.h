//
//  EventTitleView.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 9/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTitleView : UIView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;

+ (id)eventTitleView;

@end
