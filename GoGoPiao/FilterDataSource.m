//
//  FilterDataSource.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "FilterDataSource.h"

@interface FilterDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) FilterCellConfigurationBlock filterCellConfigurationBlock;
@property FilterType filterType;

@end

@implementation FilterDataSource

- (id)initWithDataArray:(NSArray *)aDataArray cellIdentifier:(NSString *)aCellIdentifier filterConfigurationBlock:(FilterCellConfigurationBlock)aFilterCellConfigurationBlock filterType:(FilterType)aFilterType
{
    self = [super init];
    if (self == nil) {
        self.dataArray = aDataArray;
        self.filterType = aFilterType;
        self.filterCellConfigurationBlock = aFilterCellConfigurationBlock;
    }
    
    return self;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
