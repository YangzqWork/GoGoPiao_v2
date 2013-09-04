//
//  GGEventsCell.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 22/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGEventsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *eventsImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventsSubtitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventsThirdLabel;

@property (strong, nonatomic) NSString *idNumber;

+ (UINib *)nib;
- (void)showEventData:(NSDictionary *)thisEvent;

@end
