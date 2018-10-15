//
//  CityWeatherCell.h
//  WeatherApp
//
//  Created by GlobalLogic on 19/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityWeatherCell : UICollectionViewCell

- (void)configureCell : (NSDictionary*)cityWeather;

@property (weak, nonatomic) IBOutlet UILabel *monthName;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@end
