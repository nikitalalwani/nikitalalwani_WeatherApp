//
//  WeatherViewController.m
//  WeatherApp
//
//  Created by GlobalLogic on 19/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import "WeatherViewController.h"
#import "CityWeatherCell.h"
#import "CityWeatherTableViewCell.h"
#import "OtherParametersViewController.h"
@interface WeatherViewController ()

@property(strong,nonatomic)UICollectionViewFlowLayout* flowLayout;
@property(strong,nonatomic)UIScrollView* scrollView;
@property(strong,nonatomic) NSArray* monthInfo;
@property(strong,nonatomic)UITableView* tableView;

@end
static NSString* identifier = @"weatherCell";

@implementation WeatherViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureUI];
    [self parseFetchedData];
}


- (void)configureUI
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@,%@",self.cityName,self.countryName];
    [self.view setBackgroundColor:[UIColor colorWithRed:175.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
    
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setItemSize:CGSizeMake(191, 110)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.flowLayout.minimumInteritemSpacing = 0.5f;
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.opaque = NO;
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:175.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
    
    
    self.tableView = [self makeTableView];
    [self.tableView registerClass:[CityWeatherTableViewCell class] forCellReuseIdentifier:@"optionsCell"];
    [self.view addSubview:self.tableView];
}


#pragma-mark ParseData Methods
- (void)parseFetchedData
{
    NSDictionary* data = [self.cityWeatherInformation objectForKey:@"data"];
    NSArray* currentCondition = [data objectForKey:@"current_condition"];
    
    for (NSDictionary* dictionary in currentCondition)
    {
        self.dateAndTime.text = [NSString stringWithFormat:@"Today,%@",[dictionary valueForKey:@"observation_time"]];
        NSArray* weatherIcon = [dictionary valueForKey:@"weatherIconUrl"];
        NSDictionary* iconDict = [weatherIcon objectAtIndex:0];
        NSURL* url =[NSURL URLWithString:[iconDict valueForKey:@"value"]];
        NSData* data = [NSData dataWithContentsOfURL:url];
        UIImage* image = [UIImage imageWithData:data];
        
        self.weatherImage.image = image;
        
        NSArray* weatherDesc = [dictionary valueForKey:@"weatherDesc"];
        for (NSDictionary* value in weatherDesc)
        {
            self.weatherDesc.text = [NSString stringWithFormat:@"%@",[value valueForKey:@"value"]];
        }
        
    }
    
    NSArray* weather = [data objectForKey:@"weather"];
    NSDictionary* weatherDictionary = [weather objectAtIndex:0];
    
    self.todaysTemp.text = [NSString stringWithFormat:@"%@\u00B0 / %@\u00B0",[weatherDictionary valueForKey:@"maxtempC"],[weatherDictionary valueForKey:@"mintempC"]];
}


#pragma-mark CollectionView delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityWeatherCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
    
    
    NSDictionary* data = [self.cityWeatherInformation objectForKey:@"data"];
    
    NSArray* monthlyClimate = [data objectForKey:@"ClimateAverages"];
    
    self.monthInfo =[[monthlyClimate objectAtIndex:0]valueForKey: @"month"];
    
    [cell configureCell:[self.monthInfo objectAtIndex:indexPath.item]];
    
    return cell;
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.height/5);
    
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 60, 0);
}


#pragma-mark TableView delegate methods

- (UITableView *)makeTableView
{
    CGFloat x = 0;
    CGFloat y = self.dateAndTime.frame.size.height + self.dateAndTime.frame.origin.y+50;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 70;
    tableView.opaque = NO;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setBackgroundColor:[UIColor colorWithRed:175.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
    
    return tableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"optionsCell";
    CityWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[CityWeatherTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    if (indexPath.row == 0)
    {
        NSString* string = @"Other Parameters";
        [cell configureTableViewCell:string];
    }
    
    else if (indexPath.row == 1)
    {
        NSString* string = @"astronomy";
        [cell configureTableViewCell:string];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary* data = [self.cityWeatherInformation objectForKey:@"data"];
    NSArray* weather = [data objectForKey:@"weather"];
    NSDictionary* dictionary = [weather objectAtIndex:0];
    NSArray* astronomy = [dictionary objectForKey:@"astronomy"];
    
    NSArray* currentCondition = [data objectForKey:@"current_condition"];
    NSDictionary* dictForOtherParameters = [currentCondition objectAtIndex:0];
    
    if (indexPath.row == 0)
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        OtherParametersViewController* otherParametersViewController = [storyboard instantiateViewControllerWithIdentifier:@"OtherParametersViewController"];
        otherParametersViewController.weatherInformation = dictForOtherParameters;
        [self.navigationController pushViewController:otherParametersViewController animated:true];
    }
    
    else if (indexPath.row == 1)
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        OtherParametersViewController* otherParametersViewController = [storyboard instantiateViewControllerWithIdentifier:@"OtherParametersViewController"];
        otherParametersViewController.weatherInformation = [astronomy lastObject] ;
        [self.navigationController pushViewController:otherParametersViewController animated:true];
    }
    
}


@end
