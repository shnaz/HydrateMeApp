//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMLocation.h
//  IBMLocation iOS SDK

#import <IBMBluemix/IBMBluemix.h>
@class IBMLocationConfiguration;
@class IBMGeoAcquisitionPolicy;
@class IBMLocationContext;
@class BFTask;

/**
 This is the main class that provides methods to perform location-based operations.
 
 Your app must initialize the Mobile Data service when your application starts.
 The typical place to perform this initialization is in the AppDelegate didFinishLaunchingWithOptions method.
 
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        [IBMLocation initializeService];
    }
 
 The IBMLocation class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMLocation : IBMBluemixService

//@property (nonatomic,getter=isTransmissionEnabled) BOOL transmissionEnabled;

/**
 This method initializes the singleton instance of the Locatoin Service for this application.
 This method MUST be called prior to performing operations using this SDK.

 @return (IBMLocation *) The IBMLocation instance for this application.
*/
+(instancetype) initializeService;
/**
 Returns an instance of the location service if the service has been initialized
 
 @return (IBMLocation *) An instance of the location service
 */
+(instancetype) service;
/**
 Get the current location services configuration for this device.
 
 @return (IBMLocationConfiguration *) The current location services configuration for this device.
 */
- (IBMLocationConfiguration *) locationServicesConfiguration;

/**
 Ongoing acquisition is started for the Geo sensors as provided in the geo acquisition policy. When new sensor information is acquired, the location context is updated, and the specified triggers are evaluated for activation.

 After calling this method, locationServicesConfiguration: will return <code>configuration</code>
 @param configuration the configuration to use, specifying acquisition policy, trigger configuration and failure callbacks. Changes made to it after calling this method will not modify the runtime behavior unless the object is passed again in a new call to this method.
 @return (BFTask *) a BFTask with a BOOL result indicating whether geo acquisition has successfully started.
 */
- (BFTask *) startAcquisitionWithConfiguration:(IBMLocationConfiguration *)configuration;
/**
 Ongoing acquisition is started for the Geo sensors using the power saving profile: IBMGeoAcquisitionPolicy#powerSavingProfile:}.
 
 @return (BFTask *) a BFTask with a BOOL result indicating whether geo acquisition has successfully started.
 */
- (BFTask *) startAcquisition;

/**
 Stops the ongoing acquisition. The stop action is delegated to all relevant sensors, and all trigger states are cleared.
 */
- (void) stopAcquisition;

/**
 Acquires a geographical position.

 The device attempts to acquire a geographical position. If the attempt is successful, the following actions take place:

 - The location context might be updated. This action is dependent on the freshness of the data in the context, and the new position data being at least as accurate as the existing position data.
 - If the location context was updated, triggers might be activated.

 **Note:** Because `acquireGeoPosition` might activate triggers, you should not call `acquireGeoPosition` from a trigger callback. Potentially, this could cause an endless loop of trigger evaluations leading to callbacks leading to `acquireGeoPosition` calls.

 @param geoPolicy The policy that is used to configure the acquisition.
 @return (BFTask *) A BFTask with a result containing an IBMPosition object with the current position data.
 */
- (BFTask *)acquireGeoPositionWithPolicy:(IBMGeoAcquisitionPolicy*)geoPolicy;

/**
 Returns the current location context, containing information about the acquired locations. If startAcquisitionWithConfiguration: or startAcquisition: have not been called since startup or since the latest call to stopAcquisition:, returns <code>nil</code>.
 
 @return (IBMLocationContext *) the current location context of the device or nil if not currently acquiring locations.
 */
- (IBMLocationContext *) locationContext;

/*
 * Configures the time between transmitting device context updates to the server.
 * @param transmissionFrequency The new transmission frequency
 *
-(void) setTransmissionFrequency:(long)transmissionFrequency;
*/
@end
