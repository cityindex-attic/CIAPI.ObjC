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
  return "CIAPI" + dtoGen.Global.cleanName(name);
};

dtoGen.templateObjects(dtoGen.Global.Schemata.SMD.services,
                       ["RequestHeaderTemplate.txt", "RequestBodyTemplate.txt"],
                       "./Requests/");

dtoGen.templateObjects(dtoGen.Global.Schemata.DTO,
                     ["ResponseHeaderTemplate.txt", "ResponseBodyTemplate.txt"],
                       "./Responses/");
