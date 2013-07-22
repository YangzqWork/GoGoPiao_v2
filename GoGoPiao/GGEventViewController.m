//
//  GGEventViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventViewController.h"
#import "GGEventsCell.h"

@interface GGEventViewController ()

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSArray *list;

@end

@implementation GGEventViewController

@synthesize segmentControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.concertTableView.hidden = NO;
        self.title = @"演唱会";
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(test)];
        self.navigationItem.rightBarButtonItem = barButton;
//UISearchBar
        UISearchDisplayController *displaySearch = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        displaySearch.searchResultsDataSource = self;
        displaySearch.searchResultsDelegate = self;
//        displaySearch.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.segmentControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self setUpList];
}

- (void)setUpList
{
    //加载文件
	NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
	//从加载的文件新建一个字典
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
	//把新建的字典分配给disctionary
	self.dictionary = dict;
	//把字典里的数组按照字母顺序排序
	NSArray *array = [[self.dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
	//分配给list
	self.list = array;
	
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setConcertTableView:nil];
//    [self setSportsTableView:nil];
    [self setSegmentControl:nil];
    [self setSearchBar:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
}

//#pragma mark - UITableViewDatasource
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
//                             SimpleTableIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
//    }
//    
//    cell.textLabel.text = @"Test";
//    return cell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"test Header";
//}
//
//#pragma mark - UITableViewDelegate
//- (void)test
//{
//    NSLog(@"test succeed");
//}

#pragma mark - UISegmentControl
- (void)segmentChanged:(UISegmentedControl *)paramSender
{
    if ([paramSender isEqual:self.segmentControl]){
        int selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        NSLog(@"Segment %d with %@ text is selected", selectedSegmentIndex, selectedSegmentText);
        if (selectedSegmentIndex == 0) {
            self.navigationItem.title = @"演唱会";
        }
        else if (selectedSegmentIndex == 1) {
            self.navigationItem.title = @"体育比赛";
        }
        else if (selectedSegmentIndex == 2){
            self.navigationItem.title = @"音乐会/戏剧";
        }
        else if (selectedSegmentIndex == 3){
            self.navigationItem.title = @"其他";
        }
    }
    
}

#pragma mark - UITableViewDataSource
//在tableview中有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//每个数组都有一个分组
	return [self.list count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//获取分组
	NSString *key = [self.list objectAtIndex:section];
	//获取分组里面的数组
	NSArray *array =[self.dictionary objectForKey:key];
	return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//索引路径
	NSInteger section = [indexPath section];
	NSInteger row = [indexPath row];
	//获取分组
	NSString *key = [self.list objectAtIndex:section];
	//获取分组里面的数组
	NSArray *array =[self.dictionary objectForKey:key];
	//建立可重用单元标识
	static NSString *customCell = @"GGEventsCell";
	GGEventsCell *cell = (GGEventsCell *)[tableView dequeueReusableCellWithIdentifier:customCell];
	
	if (cell == nil) {
		//如果没有可重用的单元，我们就从nib里面加载一个
        cell = (GGEventsCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"GGEventsCell" owner:self options:nil]  lastObject];
    }
	
	//在xib里面链接好以后，分别设置textone和texttwo的text值
	NSString *ShowTextTwo = [self.list objectAtIndex:section];
	NSString *newText = [[NSString alloc] initWithFormat:@"数据在“%@”这个分组里",ShowTextTwo];
	cell.eventsTitleLabel.text = [array objectAtIndex:row];
	cell.eventsSubtitleLabel.text = newText;
    cell.eventsImageView.image = [UIImage imageNamed:@"main.png"];
	
    
	return cell;
}

//获取分组标题并显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *key = [self.list objectAtIndex:section];
	return key;
}

//给tableviewcell添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return self.list;
}

@end
