//
//  GGEventSearchCell.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventSearchCell.h"

@implementation GGEventSearchCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"GGEventSearchCell" bundle:nil];
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

@end
