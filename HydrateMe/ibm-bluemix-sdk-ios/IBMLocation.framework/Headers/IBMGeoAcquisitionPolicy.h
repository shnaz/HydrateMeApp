//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMGeoAcquisitionPolicy.h
//  IBMLocation iOS SDK

/**
 Controls how Geo positions will be acquired.
 
 The IBMGeoAcquisitionPolicy class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMGeoAcquisitionPolicy : NSObject <NSCopying>

/**
 The maximum age of the geo position that is returned, in milliseconds.
 A cached position can be returned from acquisition if the age of that position is less than the specified value.
 
 The default and minimum value is 100 milliseconds.
 */
@property (nonatomic) long long maximumAge;
/**
 The duration, in milliseconds, this geo acquisition policy allows to wait for acquisitions before an IBMGeoError is sent with code IBMGeoErrorCodes#TIMEOUT. The default value is -1 which indicates an infinite timeout.
 
 If no position is acquired since the last position was acquired, or since startAcquisition: was called, then the failure function will be called.
 */
@property (nonatomic) long long timeout;
/**
 A Boolean value that determines whether it is possible to obtain high-accuracy measurements, for example by using GPS. 
 
 When true, the value of `desiredAccuracy` will be taken into account.
 */
@property (nonatomic) BOOL enableHighAccuracy;
/**
 The desired accuracy in meters. This is only taken into account when `enableHighAccuracy` is set to `YES`.
 */
@property (nonatomic) int desiredAccuracy;
/**
 The minimum distance in meters that the position must change by since the last update in order to receive a new updated position.
 Higher values can improve battery life, although the effect is generally less than that of setting `minChangeTime`.
 The default value is 0.
 */
@property (nonatomic) int minChangeDistance;
/**
 The minimum time in milliseconds between position updates. Higher values can improve battery life.
 */
@property (nonatomic) int minChangeTime;

/**
 Used to save power. Accurate location information is not guaranteed. Here are the settings for this geo acquisition profile:
 
 -`enableHighAccuracy = false`
 -`minChangeTime = 300000` (5 minutes)
 -`minChangeDistance = 1000` (1 kilometer)
 -`maximumAge = 300000` (5 minutes)
 
 @return (IBMGeoAcquistionPolicy *) The power saving geo acquistion policy
 */
+ (instancetype) powerSavingProfile  ;
/**
 Used to track location, but at a rough granularity. Here are the settings for this geo acquisition profile:

 -`enableHighAccuracy = true`
 -`desiredAccuracy = 200` (200 meters)
 -`minChangeTime = 30000` (30 seconds)
 -`minChangeDistance = 50` (50 meters)
 -`maximumAge = 60000` (60 seconds)
 
 @return (IBMGeoAcquistionPolicy *) The power saving geo acquistion policy
 */
+ (instancetype) roughTrackingProfile  ;
/**
 * Used to track location, and get the best position information available. Here are the settings for this geo acquisition profile:

 -`enableHighAccuracy = true`
 -`maximumAge = 100` (100 milliseconds)

 @return (IBMGeoAcquistionPolicy *) The power saving geo acquistion policy
 */
+ (instancetype) liveTrackingProfile  ;

@end
