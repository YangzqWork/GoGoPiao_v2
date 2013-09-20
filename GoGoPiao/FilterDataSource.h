//
//  FilterDataSource.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    FilterTypeRegions = 0,
    FilterTypeEventTypes,
    FilterTypePerformers
}FilterType;

typedef void (^FilterCellConfigurationBlock)(id item, id cell);

@interface FilterDataSource : NSObject

- (id)initWithDataArray:(NSArray *)aDataArray
         cellIdentifier:(NSString *)aCellIdentifier filterConfigurationBlock:(FilterCellConfigurationBlock)aFilterCellConfigurationBlock filterType:(FilterType)aFilterType;

@end
