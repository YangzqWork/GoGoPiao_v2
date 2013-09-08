//
//  GGEventsCell.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 22/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "AppDelegate.h"
#import "GGEventsCell.h"
#import "Constants.h"
#import "UIImageView+MKNetworkKitAdditions.h"

@implementation GGEventsCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"GGEventsCell" bundle:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showEventData:(NSDictionary *)thisEvent
{
    self.eventsTitleLabel.text = thisEvent[@"title"];
    self.eventsSubtitleLabel.text = thisEvent[@"start_time"];
    self.eventsThirdLabel.text = thisEvent[@"description"];
    self.idNumber = thisEvent[@"id"];
    
    NSString *posterURLString = [NSString stringWithFormat:@"%@", thisEvent[@"poster_url"]];
    NSLog(@"%@", posterURLString);
    
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithURLString:posterURLString params:nil httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [self.eventsImageView setImage:[completedOperation responseImage]];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Image Error : %@", error);
    }];
    
    [ApplicationDelegate.networkEngine enqueueOperation:op];
//    [self.eventsImageView setImageFromURL:posterURL placeHolderImage:nil usingEngine:ApplicationDelegate.networkEngine animation:YES];
}

@end
