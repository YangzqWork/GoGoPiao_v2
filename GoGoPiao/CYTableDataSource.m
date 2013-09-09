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

//添加索引
@property (nonatomic, strong) NSMutableArray *indexList;

@end

@implementation CYTableDataSource

- (id)init
{
    return nil;
}

- (id)initWithDataArray:(NSArray *)anArray cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewConfigureCellBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.dataArray = anArray;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    
    return self;
}

- (id)itemAtIndextPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:(NSUInteger)indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataArray count]) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadMoreCell"];
        cell.textLabel.text = @"加载更多...";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndextPath:indexPath];
    
    __typeof (&*cell) __weak weakCell = cell;
    self.configureCellBlock(weakCell, item);
//    if ([self.cellIdentifier isEqual: @"GGEventsCell"]) {
//        [(GGEventsCell *)cell showEventData:item];
//    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"CYTableViewDataSource : %d", [self.dataArray count]);
    return [self.dataArray count] + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Robust - Default to be 1
    return 1;
}

@end
