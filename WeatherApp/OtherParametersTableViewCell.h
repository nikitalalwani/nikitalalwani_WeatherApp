//
//  OtherParametersTableViewCell.h
//  WeatherApp
//
//  Created by GlobalLogic on 25/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherParametersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *otherParameter;
@property (weak, nonatomic) IBOutlet UILabel *otherParameterValue;
@property(strong,nonatomic)NSString* keyArrayInCell;
@property(strong,nonatomic)NSString* valueArrayInCell;
-(void)configureCell;

@end
