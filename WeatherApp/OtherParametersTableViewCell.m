//
//  OtherParametersTableViewCell.m
//  WeatherApp
//
//  Created by GlobalLogic on 25/05/16.
//  Copyright © 2016 GlobalLogic. All rights reserved.
//

#import "OtherParametersTableViewCell.h"

@implementation OtherParametersTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell
{
    
    self.layer.borderWidth = 1.0f;
    
    UIColor* green = [UIColor colorWithRed:0.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0];
    [self setBackgroundColor:green];

    [self.otherParameter  setText:self.keyArrayInCell];
    [self.otherParameter setTextColor:[UIColor whiteColor]];
    
    [self.otherParameterValue setTextColor:[UIColor whiteColor]];
    
    
    if ([self.valueArrayInCell  isKindOfClass:[NSArray class]])
        
    {
        [self.otherParameterValue setText:@"NA"];
        
    }
    
    else
        
    {
        [self.otherParameterValue setText:self.valueArrayInCell];
    }

}
@end
