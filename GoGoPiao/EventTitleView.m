//
//  EventTitleView.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 29/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "EventTitleView.h"

@implementation EventTitleView

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"EventTitleView" bundle:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
