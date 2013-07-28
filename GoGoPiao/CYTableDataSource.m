//
//  CYTableDataSource.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 26/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "CYTableDataSource.h"
#import "GGEventsCell.h"

@interface CYTableDataSource ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) TableViewConfigureCellBlock configureCellBlock;

@end

@implementation CYTableDataSource

@synthesize dataArray;
@synthesize cellIdentifier;
@synthesize configureCellBlock;

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
    GGEventsCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
//    if (cell == nil)
//        cell = (GGEventsCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"GGEventsCell" owner:self options:nil]  lastObject];
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

@end
