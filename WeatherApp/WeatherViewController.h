//
//  WeatherViewController.h
//  WeatherApp
//
//  Created by GlobalLogic on 19/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic)NSDictionary* cityWeatherInformation;

@property(strong,nonatomic)NSString* countryName;
@property(strong,nonatomic)NSString* cityName;

@property (weak, nonatomic) IBOutlet UILabel *todaysTemp;
@property (weak, nonatomic) IBOutlet UILabel *dateAndTime;
@property (weak, nonatomic) IBOutlet UILabel *weatherDesc;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
