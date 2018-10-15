//
//  WeatherInformationManager.h
//  WeatherApp
//
//  Created by GlobalLogic on 19/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol CityWeatherInfoDelegate <NSObject>

- (void)cityWeatherInfoReceived:(NSDictionary*)data ;
- (void)cityWeatherInfoReceivedWithError:(NSError*)error;
@end

@interface WeatherInformationManager : NSObject

+(instancetype)sharedInstance;

- (void)fetchWeatherInformation:(float)latitude andlongitude:(float)longitude;

- (void)addListener:(id<CityWeatherInfoDelegate>)listener;

- (void)removeListener:(id<CityWeatherInfoDelegate>)listener;


@end
