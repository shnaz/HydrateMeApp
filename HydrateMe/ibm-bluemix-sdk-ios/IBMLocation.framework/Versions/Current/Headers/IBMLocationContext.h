//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMLocationContext.h
//  IBMLocation iOS SDK

@class IBMPosition;

/**
 The location context for the device, comprising of the acquired data for each of the sensors.
 The instance available through `[[IBMLocation service] locationContext]` is updated as a result of ongoing acquisition.
 
 The IBMLocationContext class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMLocationContext : NSObject <NSCopying>

/**
 * The latest acquired geo position. Returns `nil` if no geo position has been acquired.
 */
@property (nonatomic,readonly) IBMPosition *geoPosition;
/**
 * A timestamp which matches the timestamp of the geo position. If there is no geo position, then will be `nil`.
 */
@property (nonatomic, readonly) NSDate *lastModified;

/*
 * @return The data formatted as a JSON object. If there was no on-going acquisition for any sensor when
 * this object was created, it will return <code>null</code>.
 *
- (NSDictionary*) getJSON  ;
*/

/*
 * Adds the JSON representation as returned by {@link #getJSON()} to an event.
 * A typical use of this method would be when sending a dynamic
 * event as a result of a trigger being activated (i.e., the event is constructed
 * when the trigger is activated and not when the trigger was created). The IBMLocationContext instance
 * received by {@link IBMTriggerCallback#execute(IBMLocationContext)} would add
 * its data to a dynamic event object which would then be passed to
 * {@link IBMLocationService#transmitEvent(JSONObject, boolean)}.
 * If the JSON representation is <code>null</code>, then {@link JSONObject#NULL} is added.
 * @param event the JSONObject to update
 *
- (void) addToEvent : (NSMutableDictionary*) event ;
*/

@end

