//
//  ViewController.m
//  DistanceApp
//
//  Created by Lucas Yang on 2017-06-05.
//  Copyright © 2017 Lucas Yang. All rights reserved.
//

#import "ViewController.h"
#import <DistanceGetter/DGDistanceRequest.h>

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *inputStartingPoint;

@property (weak, nonatomic) IBOutlet UITextField *DestinationA;
@property (weak, nonatomic) IBOutlet UILabel *DistanceA;

@property (weak, nonatomic) IBOutlet UITextField *DestinationB;
@property (weak, nonatomic) IBOutlet UILabel *DistanceB;

@property (weak, nonatomic) IBOutlet UITextField *DestinationC;
@property (weak, nonatomic) IBOutlet UILabel *DistanceC;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectOption;


@end

@implementation ViewController


- (IBAction)CalculateButton:(id)sender {
    
    self.calculateButton.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    
    NSString *start = self.inputStartingPoint.text;
    NSString *destA = self.DestinationA.text;
    NSString *destB = self.DestinationB.text;
    NSString *destC = self.DestinationC.text;
    
    NSArray *dests = @[destA, destB, destC];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void(NSArray *response){
        ViewController *strongSelf = weakSelf;
        if(!strongSelf) return;
        
        NSNull *badResult = [NSNull null];
        
        if(self.selectOption.selectedSegmentIndex == 0 )
        {
            if(response[0] != badResult)
            {
                double num = ([response[0] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km",num];
                strongSelf.DistanceA.text = x;
            }
            else{
                strongSelf.DistanceA.text = @"Error";
            }
            
            
            if(response[1] != badResult)
            {
                double num = ([response[1] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km",num];
                strongSelf.DistanceB.text = x;
            }
            else{
                strongSelf.DistanceB.text = @"Error";
            }
            
            if(response[2] != badResult)
            {
                double num = ([response[2] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km",num];
                strongSelf.DistanceC.text = x;
            }
            else{
                strongSelf.DistanceC.text = @"Error";
            }
        }
        
        else if(self.selectOption.selectedSegmentIndex == 1 )
            {
                if(response[0] != badResult)
                {
                    double num = [response[0] floatValue];
                    NSString *x = [NSString stringWithFormat:@"%.2f meters",num];
                    strongSelf.DistanceA.text = x;
                }
                else{
                    strongSelf.DistanceA.text = @"Error";
                }
                
                
                if(response[1] != badResult)
                {
                    double num = [response[1] floatValue];
                    NSString *x = [NSString stringWithFormat:@"%.2f meters",num];
                    strongSelf.DistanceB.text = x;
                }
                else{
                    strongSelf.DistanceB.text = @"Error";
                }
                
                if(response[2] != badResult)
                {
                    double num = [response[2] floatValue];
                    NSString *x = [NSString stringWithFormat:@"%.2f meters",num];
                    strongSelf.DistanceC.text = x;
                }
                else{
                    strongSelf.DistanceC.text = @"Error";
                }
            }
        
        else if(self.selectOption.selectedSegmentIndex == 2 )
        {
            if(response[0] != badResult)
            {
                double num = ([response[0] floatValue]/1609.0);
                NSString *x = [NSString stringWithFormat:@"%.2f miles",num];
                strongSelf.DistanceA.text = x;
            }
            else{
                strongSelf.DistanceA.text = @"Error";
            }
            
            
            if(response[1] != badResult)
            {
                double num = ([response[1] floatValue]/1609.0);
                NSString *x = [NSString stringWithFormat:@"%.2f miles",num];
                strongSelf.DistanceB.text = x;
            }
            else{
                strongSelf.DistanceB.text = @"Error";
            }
            
            if(response[2] != badResult)
            {
                double num = ([response[2] floatValue]/1609.0);
                NSString *x = [NSString stringWithFormat:@"%.2f miles",num];
                strongSelf.DistanceC.text = x;
            }
            else{
                strongSelf.DistanceC.text = @"Error";
            }
        }
        
        strongSelf.req = nil;
        strongSelf.calculateButton.enabled = YES;
    };
    
    [self.req start];
    
    
}


@end
