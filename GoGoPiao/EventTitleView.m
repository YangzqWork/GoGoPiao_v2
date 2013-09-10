//
//  EventTitleView.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 9/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "EventTitleView.h"

@implementation EventTitleView

+ (id)eventTitleView
{
    EventTitleView *eventTitleView = [[[NSBundle mainBundle] loadNibNamed:@"EventTitleView" owner:nil options:nil] lastObject];
    
    // make sure customView is not nil or the wrong class!
    if ([eventTitleView isKindOfClass:[EventTitleView class]])
        return eventTitleView;
    else
        return nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
