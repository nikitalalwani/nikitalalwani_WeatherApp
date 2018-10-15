//
//  OtherParametersViewController.h
//  WeatherApp
//
//  Created by GlobalLogic on 25/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherParametersViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSDictionary* weatherInformation;
@property(strong,nonatomic)NSArray* weatherInformationArray;

@property (weak, nonatomic) IBOutlet UITableView *otherParametersTableView;

@end
