var dtoGen = require("../dtoGeneration.js");

dtoGen.Global.cleanName = function(name)
{
  clean = name;

  if (clean.substring(0, 2) == "#.")
    clean = clean.substring(2);

  if (clean.substring(0, 3) == "Api")
    clean = clean.substring(3);

  if (clean.substring(clean.length - 3) == "DTO")
    return clean.substring(0, clean.length - 3);

  return clean;
};

dtoGen.Global.apiName = function(name)
{
  var cleanName = dtoGen.Global.cleanName(name);

  if (cleanName == "String")
    return "NSString";
  else if (cleanName == "Boolean")
    return "NSNumber";
  else
    return "CIAPI" + cleanName;
};

dtoGen.Global.responseSuperclass = function(name)
{
  if (name.substring(0, 4) == "List" && /Response$/.test(name))
    return "CIAPIObjectListResponse";
  else
    return "CIAPIObjectResponse";
}

dtoGen.Global.safeNameFor = function(name)
{
  if (name == "id")
    return "ident";

  return name;
}

// Convert a schema type name into the closest matching ObjC type name
// This may return a primitive C type
dtoGen.Global.schemaTypeToObjCType = function(name)
{
  if (name == "string")
    return "NSString*";
  else if (name == "integer")
    return "NSInteger";
  else if (name == "boolean")
    return "BOOL";
  else if (name == "array")
    return "NSArray*";
  else if (name == "number")
    return "double";
  else if (name.substring(0, 5) == "CIAPI")
    return name + "*";

  // If we can't determine a static type, just use a dynamic object type
  return "id";
}

// Convert a schema type name into the cloest Object C object type
// This will only return an ObjC object type
dtoGen.Global.schemaTypeToObjCClassName = function(name)
{
  if (name == "string")
    return "NSString";
  else if (name == "integer" || name == "boolean" || name == "number")
    return "NSNumber";
  else if (name == "array")
    return "NSArray";
  else if (name.substring(0, 5) == "CIAPI")
    return name;

  // If we can't determine a static type, just use the base object type
  return "NSObject";
}

// Determine if a given Objective C type name represents an object
dtoGen.Global.isObjectType = function(name)
{
  return ((name.substring(0, 2) == "NS" && !(name == "NSInteger")) ||
          name.substring(0, 5) == "CIAPI" || name == "id");
}


// OK, this is very hacky. Some request objects appear both in the DTOs *and*
// have the same information repeated in the request schema (i.e. the DTO
// is never used). Sometimes, the request DTO appears inside the parameters
// for the actual schema request description. This is a temporary "fix"
// by spitting out reasonably formatted DTOs first. We need to replace this
// with property choices made on the schema definition
dtoGen.templateObjects(dtoGen.Global.Schemata.DTO,
                       ["ResponseHeaderTemplate.txt", "ResponseBodyTemplate.txt"],
                       "../../CIAPI/CIAPI/Requests/", function(objName, obj)
                       {
                         return /Request$/.test(dtoGen.Global.apiName(objName))
                       });

dtoGen.templateObjects(dtoGen.Global.Schemata.SMD.services,
                       ["RequestHeaderTemplate.txt", "RequestBodyTemplate.txt"],
                       "../../CIAPI/CIAPI/Requests/");

dtoGen.templateObjects(dtoGen.Global.Schemata.DTO,
                     ["ResponseHeaderTemplate.txt", "ResponseBodyTemplate.txt"],
                       "../../CIAPI/CIAPI/Responses/", function(objName, obj)
                       {
                         return !/Request$/.test(dtoGen.Global.apiName(objName))
                       });
