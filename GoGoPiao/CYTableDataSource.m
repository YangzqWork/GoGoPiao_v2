//
//  CYTableDataSource.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 26/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "CYTableDataSource.h"
#import "GGEventsCell.h"
#import "GGListingsCell.h"

@interface CYTableDataSource ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) TableViewConfigureCellBlock configureCellBlock;
@property TableViewType tableViewType;

@end

@implementation CYTableDataSource

- (id)init
{
    return nil;
}

- (id)initWithDataArray:(NSArray *)anArray cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewConfigureCellBlock)aConfigureCellBlock tableViewType:(TableViewType)aTableViewType
{
    self = [super init];
    if (self) {
        self.dataArray = anArray;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
        self.tableViewType = aTableViewType;
    }
    
    return self;
}

- (id)itemAtIndextPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:(NSUInteger)indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选择背景颜色
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor redColor];
    
    //加载更多功能，只针对TableViewTypeLoadMore
    if (self.tableViewType == TableViewTypeLoadMore && indexPath.row == [self.dataArray count]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadMoreCell"];
        cell.selectedBackgroundView = selectedView;
        cell.textLabel.text = @"加载更多...";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {  
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    cell.selectedBackgroundView = selectedView;

    
    id item = [self itemAtIndextPath:indexPath];
    
    __typeof (&*cell) __weak weakCell = cell;
    self.configureCellBlock(weakCell, item);
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableViewType == TableViewTypeLoadMore)
        return [self.dataArray count] + 1;
    else
        return [self.dataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Robust - Default to be 1
    return 1;
}

@end
