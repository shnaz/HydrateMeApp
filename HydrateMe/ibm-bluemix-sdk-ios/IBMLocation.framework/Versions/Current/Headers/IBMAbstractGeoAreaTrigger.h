//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMAbstractGeoAreaTrigger.h
//  IBMLocation iOS SDK

#import "IBMConfidenceLevel.h"
#import "IBMGeoTrigger.h"
@protocol IBMArea;

/**
 Defines parameters for Geo-Triggers with area considerations
 
 The IBMAbstractGeoAreaTrigger class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMAbstractGeoAreaTrigger : IBMGeoTrigger

/**
 The area for which the trigger will activate.
 */
@property (nonatomic) id<IBMArea> area;
/**
 The trigger's buffer zone width. The value indicates in meters how much to change the area.
 It can have either a positive or negative value. If it has a positive value, the area becomes bigger.
 If it has a negative value, the area becomes smaller. All geofence triggers operate on this new area.
 The default value is 0, which leaves the area unchanged.
 */
@property (nonatomic) double bufferZoneWidth;
/** 
 The confidenceLevel indicates how a position's accuracy is to be taken into account.
 */
@property (nonatomic) IBMConfidenceLevel confidenceLevel;

@end
