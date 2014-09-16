//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMPolygon+Area.h
//  IBMLocation iOS SDK

#import "IBMArea.h"
#import <IBMData/IBMData.h>

/**
 This class extends IBMPolygon to add functionality that allows an IBMPolygon object to be used when defining an IBMGeoAreaTrigger or IBMGeoDwellTrigger. Only the first (outer) ring is currently supported for area triggers.
 
 The objects in this class are immutable
 
 The IBMPolygon (Area) class extension is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMPolygon (Area) <IBMArea>

@end
