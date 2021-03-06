//
//  AppDelegate.m
//  HydrateMe
//
//  Created by Mads Engels on 4/2/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "AppDelegate.h"
#import "LoggingData.h"
#import <IBMBluemix/IBMBluemix.h>
#import <IBMData/IBMData.h>

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // FEEDING THE CORE DATA WITH FAKE DATA FOR PAST WEEK
    //if ([[NSUserDefaults standardUserDefaults] objectForKey:@"beenHereBefore"]==nil)
    //    [self feedTheHorse];
    
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification) {
        application.applicationIconBadgeNumber = 0;
    }
    
    NSString *applicationId = nil;
    NSString *applicationSecret = nil;
    NSString *applicationRoute = nil;
    
    BOOL hasValidConfiguration = YES;
    NSString *errorMessage = @"";
    
    // Read the applicationId from the HydrateMe-Info.plist.
    NSString *configurationPath = [[NSBundle mainBundle] pathForResource:@"bluemix" ofType:@"plist"];
    if(configurationPath){
        NSDictionary *configuration = [[NSDictionary alloc] initWithContentsOfFile:configurationPath];
        applicationId = [configuration objectForKey:@"applicationId"];
        if(!applicationId || [applicationId isEqualToString:@""]){
            hasValidConfiguration = NO;
            errorMessage = @"Open the HydrateMe.plist and set the applicationId to the Bluemix applicationId";
        }
        applicationSecret = [configuration objectForKey:@"applicationSecret"];
        if(!applicationSecret || [applicationSecret isEqualToString:@""]){
            hasValidConfiguration = NO;
            errorMessage = @"Open the HydrateMe.plist and set the applicationSecret with your Bluemix application's secret";
        }
        applicationRoute = [configuration objectForKey:@"applicationRoute"];
        if(!applicationRoute || [applicationRoute isEqualToString:@""]){
            hasValidConfiguration = NO;
            errorMessage = @"Open the HydrateMe.plist and set the applicationRoute to the Bluemix application's route";
        }
    }
    
    if(hasValidConfiguration){
        // Initialize the SDK and Bluemix services
        [IBMBluemix initializeWithApplicationId:applicationId  andApplicationSecret:applicationSecret andApplicationRoute:applicationRoute];
        [IBMData initializeService];
    }else{
        [NSException raise:@"InvalidApplicationConfiguration" format: @"%@", errorMessage];
    }
    
    return YES;
}

-(void)feedTheHorse
{
    
    for (int i = 1; i < 8; i++) {
        
        float rand = ((arc4random() % 11) + 5) * 0.1;
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*i)];
        
        LoggingData *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"LoggingData" inManagedObjectContext:self.managedObjectContext];
        newEntry.date_time = date;
        newEntry.fluit_type = @"water";
        newEntry.fluit_amount = [NSNumber numberWithInt:(3000*rand)];
        newEntry.temp = [NSNumber numberWithInt:20];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Failed to save water intake: %@", [error localizedDescription]);
        }
        
        LoggingData *newEntry1 = [NSEntityDescription insertNewObjectForEntityForName:@"LoggingData" inManagedObjectContext:self.managedObjectContext];
        rand = ((arc4random() % 11) + 3) * 0.1;
        newEntry1.date_time = date;
        newEntry1.fluit_type = @"softdrink";
        newEntry1.fluit_amount = [NSNumber numberWithInt:(300*rand)];
        newEntry1.temp = [NSNumber numberWithInt:20];
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Failed to save water intake: %@", [error localizedDescription]);
        }
        
        LoggingData *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"LoggingData" inManagedObjectContext:self.managedObjectContext];
        rand = ((arc4random() % 12) + 6) * 0.1;
        newEntry2.date_time = date;
        newEntry2.fluit_type = @"coffee";
        newEntry2.fluit_amount = [NSNumber numberWithInt:(500*rand)];
        newEntry2.temp = [NSNumber numberWithInt:20];
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Failed to save water intake: %@", [error localizedDescription]);
        }
        
        
        
    }
    
    
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    application.applicationIconBadgeNumber = 0;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"mom"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end