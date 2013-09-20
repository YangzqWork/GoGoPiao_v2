//
//  UIBarButtonItem+ProjectButton.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 20/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "UIBarButtonItem+ProjectButton.h"

@implementation UIBarButtonItem (ProjectButton)

+(UIBarButtonItem *)createButtonWithImage:(UIImage *)anImage WithTarget:(id)target action:(SEL)action
{
    UIImage *buttonImage = anImage;
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];//or you can set bgImage
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return customBarItem;
}

@end
