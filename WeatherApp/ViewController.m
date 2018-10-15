//
//  ViewController.m
//  WeatherApp
//
//  Created by GlobalLogic on 19/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

{
    NSDictionary* cityWeatherDictionary;
    NSString* currentCity;
    UIButton* viewWeather;
    NSDictionary* cityWeatherData;
    NSString *countryName;
    UITextField* cityNameField;
    UIActivityIndicatorView* spinner;
}

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    self.view.alpha = 1.0;
}


- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:true];
    [[WeatherInformationManager sharedInstance]removeListener:self];
    cityNameField = nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cityWeatherData = [[NSDictionary alloc]init];
    
    [self configureUI];
    [self.view setBackgroundColor:[UIColor colorWithRed:175.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
    
}


- (void)tearDown
{
    [[WeatherInformationManager sharedInstance]removeListener:self];
}


-(void)dealloc
{
    cityNameField = nil;
    cityWeatherDictionary = nil;
    cityWeatherData = nil;
}

#pragma-mark UI Methods

- (void)configureUI
{
    UIColor* green = [UIColor colorWithRed:0.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0];
    cityNameField = [[UITextField alloc]initWithFrame:CGRectMake(60, 260, 300, 50)];
    [cityNameField setBackgroundColor:[UIColor whiteColor]];
    [cityNameField setPlaceholder:NSLocalizedString(@"CITY PLACEHOLDER", nil)];
    [self.view addSubview:cityNameField];
    
    
    viewWeather = [[UIButton alloc]initWithFrame:CGRectMake(cityNameField.frame.origin.x+50,cityNameField.frame.origin.y+70,200,50)];
    [viewWeather setBackgroundColor:green];
    viewWeather.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:20];
    [viewWeather setTitle:NSLocalizedString(@"VIEW WEATHER", nil) forState:UIControlStateNormal];
    [viewWeather setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    viewWeather.layer.cornerRadius = 12;
    [viewWeather addTarget:self action:@selector(viewWeather) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewWeather];
    
    
}

- (void)createSpinnerView
{
    UIView* spinnerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,  self.view.frame.size.height)];
    spinnerView.alpha = 0.3;
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(200, 320);
    spinner.tag = 12;
    spinner.transform = CGAffineTransformMakeScale(3.75, 3.75);
    spinner.layer.cornerRadius = 10;
    [spinnerView addSubview:spinner];
    [self.view addSubview:spinnerView];
    
    [spinner startAnimating];
    [spinner hidesWhenStopped];
    self.view.alpha = 0.8;
}



#pragma-mark Calculate LatLong Methods
- (void)getLatitudeLongitudeForEnteredCity:(NSString *)city
{
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:city completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
             return;
         }
         
         if ([placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks firstObject];
             
             float latitude = placemark.location.coordinate.latitude;
             float longitude = placemark.location.coordinate.longitude;
             countryName = placemark.country;
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self createSpinnerView];
                 [[WeatherInformationManager sharedInstance]fetchWeatherInformation:latitude andlongitude:longitude];
                 
                 
             });
         }
     }];
}



#pragma-mark Receved Data Methods

- (void)cityWeatherInfoReceived:(NSDictionary*)data
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (data)
        {
            cityWeatherData = data;
            [self moveToNextVc];
            
        }
    });
    
}


- (void)cityWeatherInfoReceivedWithError:(NSError*)error
{
    
    NSLog(@"ERROR = %@",error);
    
}


#pragma-mark Button Actions

- (void)viewWeather
{
    [[WeatherInformationManager sharedInstance]addListener:self];
    currentCity = cityNameField.text;
    [self getLatitudeLongitudeForEnteredCity:currentCity];
}


#pragma-mark Navigation Methods

- (void)moveToNextVc
{
    [spinner stopAnimating];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    WeatherViewController* weatherViewController = [storyboard instantiateViewControllerWithIdentifier:@"WeatherViewController"];
    weatherViewController.cityWeatherInformation = cityWeatherData;
    weatherViewController.cityName = currentCity;
    weatherViewController.countryName = countryName;
    [self.navigationController pushViewController:weatherViewController animated:true];
}


@end
