//
//  ViewController.h
//  WeatherApp
//
//  Created by GlobalLogic on 19/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherInformationManager.h"
#import "WeatherViewController.h"

@interface ViewController : UIViewController<NSURLSessionDelegate,NSURLSessionTaskDelegate,CityWeatherInfoDelegate>


@end

