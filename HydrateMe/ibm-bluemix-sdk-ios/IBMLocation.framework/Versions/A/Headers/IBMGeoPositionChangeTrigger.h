//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMGeoPositionChangeTrigger.h
//  IBMLocation

#import "IBMGeoTrigger.h"

/**
 A trigger for tracking changes in the device's position. It is possible to specify a minimum distance that must be moved before the trigger will activate.
 
 The IBMGeoPositionChangeTrigger class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMGeoPositionChangeTrigger : IBMGeoTrigger

/**
 The minimum distance in meters which the position must change by in order for this trigger object to be activated.
 
 After the first acquisition,  this trigger will be activated only when the reported position has changed by at least `minChangeDistance` amount. This is different from setting the property IBMGeoAcquisitionPolicy#minChangeDistance as other triggers may still activate due to changes in the device's position, and no power will be saved by using this method.
 
 The value should be greater than that of the parameter set in IBMGeoAcquisitionPolicy#minChangeDistance, otherwise it will have no effect.
 */
@property (nonatomic) double minChangeDistance;

@end

