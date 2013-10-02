//
//  AccountTbCell.m
//  GoGoPiao
//
//  Created by yzq on 13-9-28.
//  Copyright (c) 2013年 Cho-Yeung Lam. All rights reserved.
//

#import "AccountTbCell.h"

@implementation AccountTbCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0,0,296,44)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bgView];
        
        UIView *selectedView=[[UIView alloc] initWithFrame:CGRectMake(120,0,180,44)];
        [selectedView setBackgroundColor:[UIColor grayColor]];
        [self setSelectedBackgroundView:selectedView];
        
        _iconView=[[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 20, 20)];
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(44,0, 260, 44)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:_iconView];
        [self addSubview:_titleLabel];
        
        needToLayout=YES;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

-(void) setDataDiction:(NSDictionary *)dataDiction{
    if (_dataDiction!=dataDiction) {
        _dataDiction=dataDiction;
        _iconView.image=[UIImage imageNamed:[NSString stringWithFormat:@"MyIMG.bundle/%@",[_dataDiction objectForKey:kKeyMyIcon]]];
        _titleLabel.text=[_dataDiction objectForKey:kKeyMyTitle];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (needToLayout) {
        needToLayout=NO;
        CGRect rect=self.frame;
        rect.size.width -= 24;
        rect.origin.x += 12;
        self.frame=rect;
    }

}

@end
