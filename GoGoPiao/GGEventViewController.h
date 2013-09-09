//
//  GGEventViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGNetworkEngine.h"
#import "EGORefreshTableHeaderView.h"

typedef enum EventCategoryTag : NSUInteger{
    SportsTag = 0,
    ConcertsTag = 1,
    ElseTag = 2,
    AllTag = 3
}EventCategoryTag;

@interface GGEventViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>
{
	
	EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
}


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;



- (void)loadEventsArrayWithCategoryTag:(EventCategoryTag)theCategoryTag;

@end
