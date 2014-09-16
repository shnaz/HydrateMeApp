//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMConfidenceLevel.h
//  IBMLocation iOS SDK

/**
 Confidence levels are used for geofence triggers.
 
 The <class>IBMConfidenceLevel</class> class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
typedef NS_ENUM(NSInteger, IBMConfidenceLevel) {
    /**
     For geofences:<br>
     A <code>LOW</code> confidence level is used to indicate that the accuracy of a coordinate is not to be taken into account
     when determining whether the device is inside or outside an area.
     */
	LOW,
	
    /**
     For geofences:<br>
     A <code>MEDIUM</code> confidence level is used to indicate that there is approximately a 70% confidence interval
     that a device is inside or outside an area. The accuracy of the coordinate is taken into account.
     */
	MEDIUM,
	
    /**
     For geofences:<br>
     A <code>HIGH</code> confidence level is used to indicate that there is approximately a 95% confidence interval
     that a coordinate is inside or outside an area. The accuracy of the coordinate is taken into account
     */
	HIGH
};




