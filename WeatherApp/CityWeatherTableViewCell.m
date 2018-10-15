//
//  CityWeatherTableViewCell.m
//  WeatherApp
//
//  Created by GlobalLogic on 23/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import "CityWeatherTableViewCell.h"

@implementation CityWeatherTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureTableViewCell:(NSString*)value
{
    UIColor* green = [UIColor colorWithRed:0.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0];
    [self setBackgroundColor:green];
    
    self.layer.borderWidth = 1.0f;
    self.astronomy = [[UILabel alloc]initWithFrame:CGRectMake(90.0, self.bounds.origin.y+20, 220, 25.0)];
    [self.astronomy setText:value];
    [self.astronomy setFont:[UIFont fontWithName:@"AmericanTypewriter" size:24]];
    [self.astronomy setTextColor:[UIColor whiteColor]];
    self.astronomy.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.astronomy];
}
@end
