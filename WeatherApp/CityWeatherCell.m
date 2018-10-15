//
//  CityWeatherCell.m
//  WeatherApp
//
//  Created by GlobalLogic on 19/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import "CityWeatherCell.h"

@implementation CityWeatherCell

-(void)awakeFromNib
{
    
}


- (void)configureCell : (NSDictionary*)cityWeather
{
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1.0f;
    UIColor* green = [UIColor colorWithRed:0.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0];
    [self setBackgroundColor:green];
    
    
    [self.monthName setTextColor:[UIColor whiteColor]];
    [self.monthName setText:[NSString stringWithFormat:@"%@",[cityWeather valueForKey:@"name"]]];
    [self addSubview:self.monthName];
    
    [self.temperature setTextColor:[UIColor whiteColor]];
    [self.temperature setText:[NSString stringWithFormat:@"%@ / %@",[cityWeather valueForKey:@"absMaxTemp"],[cityWeather valueForKey:@"avgMinTemp"]]];
}

@end
