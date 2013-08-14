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

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) TableViewConfigureCellBlock configureCellBlock;

//添加索引
@property (nonatomic, strong) NSMutableArray *indexList;

@end

@implementation CYTableDataSource

@synthesize dataArray;
@synthesize cellIdentifier;
@synthesize configureCellBlock;
@synthesize indexList;

#pragma mark - Public Methods

- (id)initWithDataArray:(NSArray *)_array cellIdentifier:(NSString *)_cellIdentifier configureCellBlock:(TableViewConfigureCellBlock)_configureCellBlock
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] initWithArray:_array copyItems:YES];
        self.cellIdentifier = _cellIdentifier;
        self.configureCellBlock = _configureCellBlock;
    }
    
    return self;
}

- (id)itemAtIndextPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:(NSUInteger)indexPath.row];
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"identifier %@", self.cellIdentifier);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
//    if (cell == nil) {
//        if ([self.cellIdentifier isEqualToString:@"GGEventsCell"])
//            cell = (GGEventsCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"GGEventsCell" owner:self options:nil]  lastObject];
//        else if ([self.cellIdentifier isEqualToString:@"GGListingsCell"])
//            cell = (GGListingsCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"GGListingsCell" owner:self options:nil]  lastObject];
//    }
    id item = [self itemAtIndextPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//Default to be 1
    return 1;
}

#pragma mark - 索引部分
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [self.indexList objectAtIndex:section];
    return title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexList;
}

@end
