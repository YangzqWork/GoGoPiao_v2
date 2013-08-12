//
//  GGEventTitleView.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventTitleView.h"

@implementation GGEventTitleView

@synthesize titleLabel;
@synthesize titleButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        self.titleButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [self.titleButton setFrame:CGRectMake(65, 5, 20, 20)];
        self.titleLabel.text = @"演唱会";
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.titleButton];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
