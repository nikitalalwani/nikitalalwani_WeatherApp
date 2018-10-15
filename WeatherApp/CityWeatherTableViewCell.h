//
//  CityWeatherTableViewCell.h
//  WeatherApp
//
//  Created by GlobalLogic on 23/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityWeatherTableViewCell : UITableViewCell

@property(strong,nonatomic)UILabel* astronomy;
@property(strong,nonatomic)UILabel* hourly;
@property(strong,nonatomic)UILabel* otherParameters;


-(void)configureTableViewCell:(NSString*)value;

@end
