//
//  GGAccountViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGAccountViewController.h"
#import "AccountTbCell.h"
#import "GGTicketViewController.h"
#import "GGLoginViewController.h"
#import "MKNetworkOperation.h"
#import "AppDelegate.h"
#import "NSString+Encryption.h"

@interface GGAccountViewController (){
    NSArray *_headerTextArray;
    NSArray *_orderCellArray;
    NSArray *_personCellArray;
    NSArray *_helpCellArray;
}

@end

@implementation GGAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的";
    [self setUpTable];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table setup
-(void) setUpTable{
    [self setUpTableDataSource];
    
    CGRect tgRect=[[UIDevice currentDevice] systemVersion].floatValue>=7.0 ? CGRectMake(0, 0, kScreenBoundsSize.width, kScreenBoundsSize.height):CGRectMake(0, 0, kScreenBoundsSize.width, kScreenBoundsSize.height-44-49-22);
    
    self.accounTable = [[UITableView alloc] initWithFrame:tgRect];
    
    _accounTable.delegate=self;
    _accounTable.dataSource=self;
    [_accounTable setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]];
    [_accounTable setSeparatorColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]];
    
    [self.view addSubview:_accounTable];

}
-(void) setUpTableDataSource{
    _orderCellArray=@[@{kKeyMyTitle: @"有效订单",kKeyMyIcon: @"yx"},
                      @{kKeyMyTitle: @"过期订单",kKeyMyIcon: @"gq"},
                      @{kKeyMyTitle: @"我的转让",kKeyMyIcon: @"zr"}
                      ];
    
    _personCellArray=@[@{kKeyMyTitle: @"默认收货地址",kKeyMyIcon: @"dz"},
                      @{kKeyMyTitle: @"修改密码",kKeyMyIcon: @"mm"}
                      ];
    
    _helpCellArray=@[@{kKeyMyTitle: @"帮助中心",kKeyMyIcon: @"bz"},
                      @{kKeyMyTitle: @"给客服留言",kKeyMyIcon: @"ly"},
                      @{kKeyMyTitle: @"给我们打分",kKeyMyIcon: @"df"}
                      ];
    _headerTextArray=@[@"订单列表",@"个人信息",@"帮助        "];
}


#pragma mark - UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRows=0;
    switch (section) {
        case 0:
            numberOfRows=1;
            break;
        case 1:
            numberOfRows=_orderCellArray.count;
            break;
        case 2:
            numberOfRows=_personCellArray.count;
            break;
        case 3:
            numberOfRows=_helpCellArray.count;
            break;
            
        default:
            break;
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *CoverCellIdentifier=@"CoverCell";
        UITableViewCell *coverCell=[tableView dequeueReusableCellWithIdentifier:CoverCellIdentifier];
        if (!coverCell) {
            coverCell=[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 320, 108)];
            [coverCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            

            UIImageView *coverImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 108)];
            coverImgView.image=[UIImage imageNamed:@"MyIMG.bundle/pCover"];
            [coverCell setBackgroundView:coverImgView];

            UIButton *userNameBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [userNameBtn setFrame:CGRectMake((320-96)/2, (108-40)/1.5, 96, 40)];
            [userNameBtn setTitle:@"未登陆" forState:UIControlStateNormal];
            [userNameBtn setTitleColor:[UIColor colorWithWhite:.1 alpha:.8] forState:UIControlStateNormal];
            [userNameBtn addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
            
            [userNameBtn setBackgroundImage:[UIImage imageNamed:@"MyIMG.bundle/nameBg"] forState:UIControlStateNormal];
            userNameBtn.tag=101;
            [coverCell.contentView addSubview:userNameBtn];
        }
        
        return coverCell;
    }
    
    static NSString *CellIdentifier=@"AccountCell";
    AccountTbCell *cell=(AccountTbCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell=[[AccountTbCell alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
    }
    switch (indexPath.section) {
        case 1:
            cell.dataDiction=_orderCellArray[indexPath.row];
            break;
        case 2:
            cell.dataDiction=_personCellArray[indexPath.row];
            break;
        case 3:
            cell.dataDiction=_helpCellArray[indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        GGTicketViewController *ticketVC=[GGTicketViewController new];
        ticketVC.title=[(AccountTbCell *)[tableView cellForRowAtIndexPath:indexPath] titleLabel].text;
        [self.navigationController pushViewController:ticketVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==0 ? 108 :44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0 ? 0 :32;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0)
        return nil;
    UIButton *titleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setFrame:CGRectMake(12, 0, kScreenBoundsSize.width, 22)];
    [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [titleBtn setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]];
    [titleBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [titleBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -240, 0, 0)];
    [titleBtn setTitle:_headerTextArray[--section] forState:UIControlStateNormal];
    
    return titleBtn;
}

#pragma mark - other
-(void) userLogin{
    GGLoginViewController *loginPage=[GGLoginViewController new];
    [self.navigationController pushViewController:loginPage animated:YES];
}


@end










