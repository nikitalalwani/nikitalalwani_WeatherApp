//
//  WeatherInformationManager.m
//  WeatherApp
//
//  Created by GlobalLogic on 19/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import "WeatherInformationManager.h"

@interface WeatherInformationManager ()
{
    NSDictionary* cityWeatherDictionary;
    NSMutableArray* listeners;
}
@end

static WeatherInformationManager* sharedInstance = nil;

@implementation WeatherInformationManager


-  (id)init
{
    if (self = [super init])
    {
        listeners = [[NSMutableArray alloc]init];
        cityWeatherDictionary = [[NSDictionary alloc]init];
    }
    return self;
}


+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[WeatherInformationManager alloc] init];
    });
    return sharedInstance;
}

- (void)fetchWeatherInformation:(float)latitude andlongitude:(float)longitude
{
    cityWeatherDictionary = [[NSDictionary alloc]init];
    NSURL* url  = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.worldweatheronline.com/premium/v1/weather.ashx?key=83a45d48524843809a152911161905&q=%f,%f&num_of_days=2&tp=3&format=json",latitude,longitude]];
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* dataTask =[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                     {
                                         
                                         if (error)
                                         {
                                             for (id<CityWeatherInfoDelegate>listener in listeners )
                                             {
                                                 
                                                 [listener cityWeatherInfoReceivedWithError:error];
                                                 
                                             }

                                         }
                                         if (data == nil)
                                         {
                                             NSLog(@"Data parameter is nil");
                                         }
                                         else
                                         {
                                             for (id<CityWeatherInfoDelegate>listener in listeners )
                                             {
                                                 
                                                 cityWeatherDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                 [listener cityWeatherInfoReceived:cityWeatherDictionary];
                                                 
                                             }
                                         }
                                     } ];
    
    [dataTask resume];
    
}
#pragma-mark listener methods

//add listener to array if not present
- (void)addListener:(id<CityWeatherInfoDelegate>)listener
{
    if(![listeners containsObject:listener])
        [listeners addObject:listener];
    
}


//remove listener from array
- (void)removeListener:(id<CityWeatherInfoDelegate>)listener
{
    if([listeners containsObject:listener])
        [listeners removeObject:listener];
}




@end
