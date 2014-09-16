//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMPointOfInterest.h
//  IBMLocation

#import <IBMData/IBMData.h>
@protocol IBMGeometry;

/**
 IBMPointOfInterest objects are IBMDataObject specializations which describe points of interest using a GeoJSON geometry, a name, and an array of tags.
 
 The IBMPointOfInterest class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMPointOfInterest : IBMDataObject <IBMDataObjectSpecialization>

/**
 The GeoJSON compliant geometry that describes the IBMPointOfInterest object. Must be one of IBMPoint, IBMLineString, or IBMPolygon. Required.
 */
@property (nonatomic) id<IBMGeometry> geometry;
/**
 A user-defined name for the IBMPointOfInterest object. Optional.
 */
@property (nonatomic,copy) NSString *name;
/**
 A user-defined array of tags used to describe the IBMPointOfInterest object. Optional.
 */
@property (nonatomic,copy) NSArray *tags;

/**
 Initialize an IBMPointOfInterest object using a specified geometry and optional name and tags attributes. 
 
 @param geometry The geometry object used to describe the point of interest. Must be an IBMPoint, IBMLineString, or IBMPolygon.
 @param name The name of the point of interest. If you do not want to assign a name, pass in `nil` or `@""`.
 @param tags A user-defined array of tags of type NSString. If you do not want to assign any tags, pass in `nil` or an empty array.
 */
-(id) initWithGeometry:(id<IBMGeometry>)geometry name:(NSString *)name tags:(NSArray *)tags;
/**
Initialize an IBMPointOfInterest object using a JSON definition. This constructor will process geometry, tags, and name attributes only.

@param json The JSON definition to use for building the IBMPointOfInterest object
*/
-(id) initWithJSON:(NSDictionary *)json;

/**
 Returns the JSON representation of this IBMPointOfInterest object.
 
 @return (NSDictionary *) the json represntation of the IBMPointOfInterest object
 */
-(NSDictionary*) json;

/**
 Adds a user-defined tag that describes this location object to the tags attribute.
 
 @param tag The tag to add to the tags array
 */
-(void) addTag:(NSString *)tag;
/**
 Remove a user-defined tag so that is no longer associated with this location object.
 
 @param tag The tag to remove from the tags array
 */
-(NSString*) removeTag:(NSString *)tag;

@end
