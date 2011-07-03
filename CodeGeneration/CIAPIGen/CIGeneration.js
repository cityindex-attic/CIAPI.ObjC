var fs = require("fs");
var dtoGen = require("../dtoGeneration.js");

var cleanName = function(name)
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

var apiName = function(name)
{
  var cleanName = dtoGen.Global.cleanName(name);

  if (cleanName == "String")
    return "NSString";
  else if (cleanName == "Boolean")
    return "NSNumber";
  else
    return "CIAPI" + cleanName;
};

dtoGen.Global.cleanName = cleanName;
dtoGen.Global.apiName = apiName;

dtoGen.Global.responseSuperclass = function(name)
{
  if (name.substring(0, 4) == "List" && /Response$/.test(name))
    return "CIAPIObjectListResponse";
  else
    return "CIAPIObjectResponse";
}

var safeNameFor = function(name)
{
  if (name == "id")
    return "ident";

  return name;
}
dtoGen.Global.safeNameFor = safeNameFor;

// Convert a schema type name into the closest matching ObjC type name
// This may return a primitive C type
var schemaTypeToObjCType = function(name)
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
dtoGen.Global.schemaTypeToObjCType = schemaTypeToObjCType;

// Convert a schema type name into the cloest Object C object type
// This will only return an ObjC object type
var schemaTypeToObjCClassName = function(name)
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
dtoGen.Global.schemaTypeToObjCClassName = schemaTypeToObjCClassName;

// Determine if a given Objective C type name represents an object
dtoGen.Global.isObjectType = function(name)
{
  return ((name.substring(0, 2) == "NS" && !(name == "NSInteger")) ||
          name.substring(0, 5) == "CIAPI" || name == "id");
}

// First, we're going to copy each service and do some fixups
var services = {};

for (serviceIndex in dtoGen.Global.Schemata.SMD.services)
{
  var smdService = dtoGen.Global.Schemata.SMD.services[serviceIndex];
  var cleanService = {};

  // Copy over service elements that are already OK
  cleanService.target = smdService.target;
  cleanService.uriTemplate = smdService.uriTemplate;
  cleanService.transport = smdService.transport;
  cleanService.description = smdService.description;
  cleanService.throttleScope = smdService.throttleScope;

  // Cache duration
  if (smdService.cacheDuration)
  {
    cleanService.hasCacheDuration = true;
    cleanService.cacheDuration = smdService.cacheDuration;
  }
  else
  {
    cleanService.hasCacheDuration = false;
  }

  // Cleanup the returns item
  if (smdService["returns"]["$ref"])
    cleanService.returns = apiName(smdService["returns"]["$ref"]);
  else
    cleanService.returns = smdService.returns;

  // Parse each parameter, and set up an object for it
  var cleanParams = []
  var cleanArrayParams = []
  for (var paramIndex in smdService.parameters)
  {
    var param = smdService.parameters[paramIndex];
    var cleanParam = {};

    // Copy over OK information
    cleanParam.description = param.description;

    // Fixup the parameter typename
    var typeName = param.type;
    if (typeName == null)
    {
      typeName = apiName(param["$ref"]);
      cleanParam.isRefType = true;
    }
    else
    {
      cleanParam.isRefType = false;
    }

    if (param.type == "array")
    {
      cleanParam.isArray = true;

      var arrTypeName = param.items.type;
      if (arrTypeName == null)
        arrTypeName = apiName(param.items["$ref"]);

      cleanParam.arrayType = schemaTypeToObjCClassName(arrTypeName);
    }
    else
    {
      cleanParam.isArray = false;
    }

    cleanParam.type = schemaTypeToObjCType(typeName);

    // Fixup the name
    cleanParam.name = safeNameFor(param.name);

    // Add default
    if (param.default)
    {
      cleanParam.default = param.default;
      cleanParam.hasDefault = true;
    }
    else
    {
      cleanParam.hasDefault = false;
    }

    cleanParams.push(cleanParam);
    if (cleanParam.isArray)
      cleanArrayParams.push(cleanParam);
  }
  cleanService.parameters = cleanParams;
  cleanService.arrayParameters = cleanArrayParams;


  // Now work out constructor names based on parameters
  var constructorName = "";
  if (cleanParams.length > 0)
  {
    for (var cleanParamIndex in cleanParams)
    {
      cleanParam = cleanParams[cleanParamIndex];

      if (!cleanParam.hasDefault)
      {
        if (constructorName.length == 0)
        {
          constructorName += cleanParam.name.substring(0, 1).toUpperCase() +
                             cleanParam.name.substring(1);
        }
        else
        {
          constructorName += " " + cleanParam.name.substring(0, 1).toLowerCase() +
                             cleanParam.name.substring(1);
        }

        if (cleanParam.isRefType)
          constructorName += ":(" + cleanParam.type + "*)_" + cleanParam.name;
        else
          constructorName += ":(" + cleanParam.type + ")_" + cleanParam.name;
      }
    }
  }

  cleanService.constructorNameSuffix = constructorName;

  services[serviceIndex] = cleanService;
  console.log("Created service " + serviceIndex + "(" + cleanService + ")");
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

dtoGen.templateObjects(services,
                       ["RequestHeaderTemplate.txt", "RequestBodyTemplate.txt"],
                       "../../CIAPI/CIAPI/Requests/");

dtoGen.templateObjects(dtoGen.Global.Schemata.DTO,
                     ["ResponseHeaderTemplate.txt", "ResponseBodyTemplate.txt"],
                       "../../CIAPI/CIAPI/Responses/", function(objName, obj)
                       {
                         return !/Request$/.test(dtoGen.Global.apiName(objName))
                       });

// Output the set of header files we generated into a single file
var headerStream = fs.createWriteStream("../../CIAPI/CIAPI/CIAPIRequestsAndResponses.h");

if (headerStream)
{
  console.log("Generating composite header file includer");

  headerStream.write("// Generated header to include all other generated " +
                     " request and response headers\n\n");
  for (fileIndex in dtoGen.Global.generatedFiles)
  {
    var fileName = dtoGen.Global.generatedFiles[fileIndex];
    if (fileName.match(/.*\.h$/))
    {
      // Determine where the file lives
      // HACKHACK
      
      var fileStat = null;
      
      try
      {
        fileStat = fs.statSync("../../CIAPI/CIAPI/Requests/" + fileName);
      }
      catch (e)
      {
      }

      if (fileStat && fileStat.isFile())
        headerStream.write("#import \"Requests/" + fileName + "\"\n");
      else
        headerStream.write("#import \"Responses/" + fileName + "\"\n");
    }
  }

  headerStream.end();
  headerStream.destroySoon();
}
else
{
  console.log("Could not create composite header file");
}
