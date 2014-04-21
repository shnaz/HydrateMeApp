//
//  WeatherSubViewController.m
//  HydrateMe
//
//  Created by Shafi on 15/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "WeatherSubViewController.h"

@interface WeatherSubViewController ()

-(void) loadWeatherDataUsing:(NSString*)latitude :(NSString*)longitude;
-(void) processWeatherData:(NSData*)data;

@end

@implementation WeatherSubViewController

CLLocationManager *locationManager;
NSString *areaTemperature;
NSString *areaName;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //[locationManager startUpdatingLocation];

    areaTemperature = @"-";
    areaName = @"-";
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //Update manOnBar's position
    //[locationManager startUpdatingLocation];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) loadWeatherDataUsing:(NSString*)latitude :(NSString*)longitude
{
    NSString *londonWeatherUrl =[NSString stringWithFormat:
                                 @"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@",latitude,longitude];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:londonWeatherUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                //Process weather data
                [self processWeatherData:data];
                
            }] resume];
}

-(void)processWeatherData:(NSData*)data
{
    NSError *parseJsonError = nil;
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseJsonError];
    
    if (!parseJsonError) {
        areaName = [jsonDict objectForKey:@"name"];
        
        NSDictionary *main =[jsonDict objectForKey:@"main"];
        int temperature = [[main objectForKey:@"temp"] integerValue] - 273;
        areaTemperature = [NSString stringWithFormat:@"%d°C", temperature];
        
        self.areaNameLabel.text = areaName;
        self.areaTempLabel.text = areaTemperature;
        NSLog(@"WeatherSubView: City=%@  Temp=%d", areaName,temperature);

        //Update UILabels async
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.areaNameLabel setNeedsDisplay];
            [self.areaTempLabel setNeedsDisplay];
            
        });
    } else {
        NSLog(@"WeatherSubView: processData error %@", parseJsonError);
    }
    
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        NSString *longitude = [NSString stringWithFormat:@"%.4f", currentLocation.coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%.4f", currentLocation.coordinate.latitude];
        
        [locationManager stopUpdatingLocation];
        
        [self loadWeatherDataUsing:latitude :longitude];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"WeatherSubView: didFailWithError: %@",error);
}


@end

