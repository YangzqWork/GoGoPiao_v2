//
//  CYTableDataSource.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 26/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//
//  Specific in dealing with the data loading in the UITableView

#import <Foundation/Foundation.h>

typedef void (^TableViewConfigureCellBlock)(id cell, id item);

@interface CYTableDataSource : NSObject<UITableViewDataSource>

- (id)itemAtIndextPath:(NSIndexPath *)indexPath;
- (id)initWithDataArray:(NSArray *)anArray
         cellIdentifier:(NSString *)aCellIdentifier
     configureCellBlock:(TableViewConfigureCellBlock)aConfigureCellBlock;

@end
