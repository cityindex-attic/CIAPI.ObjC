var fs = require("fs");
var vm = require("vm");

exports.Global = { "Schemata" : {} };
exports.Global.generatedFiles = [];

exports.Global.lineSplit = function(len, prefix, source)
{
  allSource = source;
  result = "";

  while (source != "")
  {
    result += prefix + source.substring(0, len) + "\n";
    source = source.substring(len);
  }

  return result;
}

exports.processSingleTemplate = function(templatePath, objName, obj,
                                         targetDir)
{
  try
  {
    var templateScript = this.templateToScript(templatePath);
    var writeStream = fs.createWriteStream("/tmp/templateTmp");
    this.Global.objName = objName;
    this.Global.obj = obj;
    this.Global.code = writeStream;
    this.Global.console = console;

    console.log("Templating object " + objName + " with template " + templatePath); 

    try
    {
      vm.runInNewContext(templateScript, this.Global, templatePath);
    }
    catch (e)
    {
      console.log("Templating script failed: " + e);
    }

    writeStream.end();
    writeStream.destroySoon();

    if (this.Global.fileName != null)
      fs.renameSync("/tmp/templateTmp", targetDir + this.Global.fileName)
    else
      throw "Template did not provide a file name for the result"

    this.Global.generatedFiles.push(this.Global.fileName);

    this.Global.objName = null;
    this.Global.obj = null;
    this.Global.code = null;
    this.Global.fileName = null;
  }
  catch (e)
  {
    console.log("Templating object " + objName + " with template " + templatePath + " into " +
                targetDir + " : Error - " + e); 
                throw e;
  }
};

exports.templateObjects = function(objects, templates, targetDir, filter)
{
  for (obj in objects)
  {
    for (template in templates)
    {
      if (filter && !filter(obj, objects[obj]))
        continue;
      this.processSingleTemplate(templates[template], obj, objects[obj],
                                 targetDir);
    }
  }
};

  /*
    Convert a text file with <% X %> JavaScript blocks to a Script, where text
    blocks become writes to a global "code" variable
  */
exports.templateToScript = function(templatePath)
{
  var jsOpenTag = "<%";
  var jsCloseTag = "%>";
  var resultScript = "";
  var templateText = fs.readFileSync(templatePath, "UTF-8");

  var templateRemaining = templateText;
  while (true)
  {
    var openingJSPos = templateRemaining.indexOf(jsOpenTag);

    if (openingJSPos == -1)
      break;

    var closingJSPos = templateRemaining.indexOf(jsCloseTag, openingJSPos);

    if (closingJSPos == -1)
      throw "Opening JavaScript block not properly closed";

    resultScript += "code.write(\"" +
         templateRemaining.substring(0, openingJSPos).replace(/\n/g, "\\n").replace(/\"/g, "\\\"") + "\");\n";

    var codeStart = openingJSPos + jsOpenTag.length;
    resultScript += templateRemaining.substring(codeStart, closingJSPos) +
                    ";\n";
    newLineSkip = (templateRemaining.indexOf("\n", closingJSPos) - closingJSPos == 2) ? 1 : 0;
    templateRemaining = templateRemaining.substring(closingJSPos +
                                               jsCloseTag.length + newLineSkip);
  }

  // The rest of the text is just a write to the code output
  resultScript += "code.write(\"" + templateRemaining.replace(/\n/g, "\\n").replace(/\"/g, "\\\"") + "\");";

  return resultScript;
};

eval("exports.Global.Schemata.DTO = " + fs.readFileSync("DTOSchema.txt", "UTF-8"));
eval("exports.Global.Schemata.SMD = " + fs.readFileSync("SMDSchema.txt", "UTF-8"));
