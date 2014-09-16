//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMGeoDwellTrigger.h
//  IBMLocation

#import "IBMAbstractGeoAreaTrigger.h"

/**
 Predefined types used when defining IBMGeoDwellTrigger objects
 */
typedef NS_ENUM(NSInteger,GeoDwellTriggerType) {
    /** The type used to define a trigger for dwelling inside an area */
    GEO_DWELL_INSIDE,
    /** The type used to define a trigger for dwelling outside an area */
    GEO_DWELL_OUTSIDE
};

/**
 A trigger definition for dwelling a period of time inside (or outside) an area.  Whether the dwell trigger is activated by dwelling inside or outside of an area is defined by the GeoDwellTriggerType. In order to re-activate the device must first leave (or re-enter) the area.
 
 The IBMGeoDwellTrigger class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMGeoDwellTrigger : IBMAbstractGeoAreaTrigger

/** 
 A time defined in milliseconds. It defines how long the device must be inside, or outside, the area before the trigger is activated.
 */
@property (nonatomic) long long dwellingTime;
/**
 The GeoDwellTriggerType definition for this trigger
 */
@property (nonatomic,readonly) GeoDwellTriggerType triggerType;


/**
 Constructor used to create an IBMGeoDwellTrigger using the provided GeoDwellTriggerType value. You must provide a trigger type when creating an IBMGeoDwellTrigger. Calls to the base constructor init: will fail.
 
 @param type The GeoDwellTriggerType for this trigger
 */
- (id) initTriggerType:(GeoDwellTriggerType)type;

@end

