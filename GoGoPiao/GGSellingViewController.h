//
//  GGSellingViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GGSellingViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * results;
    BOOL isLoading;
    BOOL isLoadOver;
    int allCount;
}

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableResult;


@end
