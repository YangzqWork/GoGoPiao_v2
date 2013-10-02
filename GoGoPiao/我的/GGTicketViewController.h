//
//  GGTicketViewController.h
//  GoGoPiao
//
//  Created by yzq on 13-10-2.
//  Copyright (c) 2013年 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTfulEngine.h"

@interface GGTicketViewController : UITableViewController

@property (nonatomic,strong) NSString *urlPath;
@property (nonatomic,strong) RESTfulEngine *netEngine;
@property (nonatomic,strong) NSMutableArray *ticketDataArray;

@end
