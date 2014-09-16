//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMGeoAreaTrigger.h
//  IBMLocation iOS SDK

#import "IBMAbstractGeoAreaTrigger.h"

/**
 Predefined types used when defining IBMGeoAreaTrigger objects
 */
typedef NS_ENUM(NSInteger,GeoAreaTriggerType) {
    /** The type used to define a trigger on entering an area */
    GEO_AREA_ENTERING,
    /** The type used to define a trigger on exiting an area */
    GEO_AREA_EXITING
};

/**
 A trigger for entering (or exiting) an area.  Entering or exiting is defined by the GeoAreaTriggerType. The device must first have been outside (or inside) the area and then entered (or exited) the area at the given confidence level in order for the trigger to activate. In order to re-activate the device must first leave (or re-enter) the area.
 
 The IBMGeoAreaTrigger class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMGeoAreaTrigger : IBMAbstractGeoAreaTrigger

/**
 The GeoAreaTriggerType definition for this trigger
 */
@property (nonatomic,readonly) GeoAreaTriggerType triggerType;

/**
 Constructor used to create an IBMGeoAreaTrigger using the provided GeoAreaTriggerType value. You must provide a trigger type when creating an IBMGeoAreaTrigger. Calls to the base constructor init: will fail.
 
 @param type The GeoAreaTriggerType for this trigger
 */
-(id) initTriggerType:(GeoAreaTriggerType)type;

@end
