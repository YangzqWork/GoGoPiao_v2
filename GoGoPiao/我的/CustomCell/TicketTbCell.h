//
//  TicketTbCell.h
//  GoGoPiao
//
//  Created by yzq on 13-10-2.
//  Copyright (c) 2013年 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketTbCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketNumLabel;

@end
