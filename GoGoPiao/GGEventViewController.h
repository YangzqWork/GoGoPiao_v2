//
//  GGEventViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGNetworkEngine.h"

@interface GGEventViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *concertTableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end
