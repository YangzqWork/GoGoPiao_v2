//
//  FilterDataSource.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "FilterDataSource.h"

@interface FilterDataSource ()

@property (strong, nonatomic) NSArray *indices;
@property (strong, nonatomic) NSDictionary *dataDictionary;
@property (strong, nonatomic) NSString *cellIdentifier;
@property (strong, nonatomic) NSString *filterTypeObjectString;
@property (strong, nonatomic) FilterCellConfigurationBlock filterCellConfigurationBlock;

@end

@implementation FilterDataSource

- (id)initWithDataArray:(NSArray *)aDataArray cellIdentifier:(NSString *)aCellIdentifier filterConfigurationBlock:(FilterCellConfigurationBlock)aFilterCellConfigurationBlock filterTypeObjectString:(NSString *)aFilterTypeObjectString
{
    self = [super init];
    if (self) {
        self.dataDictionary = [self packupDataFromArray:aDataArray FilterObjectType:aFilterTypeObjectString];
        self.indices = [[self.dataDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        self.cellIdentifier = aCellIdentifier;
        self.filterTypeObjectString = aFilterTypeObjectString;
        self.filterCellConfigurationBlock = aFilterCellConfigurationBlock;
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indices count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.indices objectAtIndex:section];
    return [[self.dataDictionary objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    
    NSString *key = [self.indices objectAtIndex:indexPath.section];
    NSArray *dataArray = [self.dataDictionary objectForKey:key];
    
    id item = [dataArray objectAtIndex:indexPath.row];
    
    __typeof (&*cell) __weak weakCell = cell;
    self.filterCellConfigurationBlock(weakCell, item);
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indices;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.indices indexOfObject:title];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.indices objectAtIndex:section];
}

#pragma mark - 整理源数据

- (NSDictionary *)packupDataFromArray:(NSArray *)originalArray FilterObjectType:(NSString *)filterObjectType
{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    
    // initialize places with an array for each letter
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for (int x = 0; x < 26; x++) {
        NSString *letter = [alphabet substringWithRange:NSMakeRange(x, 1)];
        resultDict[letter] = [NSMutableArray arrayWithCapacity:10];
    }
    
    // then put each place in the array corresponding to its first letter
    for (NSDictionary *item in originalArray) {
        NSString *firstLetter = [[item[filterObjectType][@"aka"] substringWithRange:NSMakeRange(0, 1)] uppercaseString];
        NSMutableArray *letterArray = [resultDict objectForKey:firstLetter];
        [letterArray addObject:item];
    }
    
    return resultDict;
}

@end
