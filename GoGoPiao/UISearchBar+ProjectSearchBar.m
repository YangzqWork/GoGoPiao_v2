//
//  UISearchBar+ProjectSearchBar.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 20/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "UISearchBar+ProjectSearchBar.h"

@implementation UISearchBar (ProjectSearchBar)

- (void)customizeWithSearchFieldImage:(UIImage *)anImage
{
    self.backgroundColor = [UIColor clearColor];
    //去掉搜索框背景
    UITextField *searchField;
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            searchField = (UITextField *)subview;
            break;
        }
    }
    if(!(searchField == nil)) {
        searchField.textColor = [UIColor blackColor];
        [searchField setBackground:anImage];
        [searchField setBorderStyle:UITextBorderStyleNone];
    }
    //    //自定义背景
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_bg.png"]];
    //    [_searchBar insertSubview:imageView atIndex:0];
}

@end
