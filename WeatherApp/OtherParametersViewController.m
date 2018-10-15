//
//  OtherParametersViewController.m
//  WeatherApp
//
//  Created by GlobalLogic on 25/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import "OtherParametersViewController.h"
#import "OtherParametersTableViewCell.h"

@interface OtherParametersViewController ()

{
    NSArray* keyArray;
    NSArray* valueArray;
    
}

@end

@implementation OtherParametersViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:175.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
    
    keyArray = [[NSArray alloc]init];
    valueArray = [[NSArray alloc]init];
    
    [self configureUI];
    [self parseData];
}



- (void)configureUI
{
    self.otherParametersTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.otherParametersTableView setBackgroundColor:[UIColor colorWithRed:175.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
}


- (void)parseData
{
    keyArray = [self.weatherInformation allKeys];
    valueArray = [self.weatherInformation allValues];
    [self.otherParametersTableView reloadData];
}


#pragma-mark TableViewMethods
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return keyArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OtherCell";
    
    OtherParametersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[OtherParametersTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.keyArrayInCell = [keyArray objectAtIndex:indexPath.row];
    cell.valueArrayInCell = [valueArray objectAtIndex:indexPath.row];
    [cell configureCell];
    
    return cell;
    
}


@end
