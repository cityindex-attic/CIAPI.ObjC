#!/usr/bin/ruby

# This is a very hacky script to turn the DTO schema file into 
# Objective C DTO wrappers. It doesn't get it 100% right, but the manual
# fixes are then trivial

# We use the JSON gem to parse the DTO schema
require 'rubygems'
require 'json'

def dtoTypeToNSType(dtoHash)
  objectMap = { "string" => "NSString",
                "integer" => "int",
                "boolean" => "BOOL", 
                "number" => "NSNumber",
                "object" => "NSObject",
                "array" => "NSMutableArray" };

  if (dtoHash.has_key?("extends"))
    return dtoHash["extends"]["$ref"][2..-1]; 
  elsif (dtoHash.has_key?("$ref"))
    return dtoHash["$ref"][2..-1];
  elsif (objectMap.has_key?(dtoHash["type"]))
    return objectMap[dtoHash["type"]];
  end

  raise "Unknown DTO type %s!" % dtoType
end

def isObject(item)
  return !["int", "BOOL"].include?(item);
end

def isNSType(item)
  return item.start_with?("NS");
end

def APIifyName(text)
  if text == nil
    return "";
  end

  if (!isObject(text) || isNSType(text))
    return text;
  end

  if (text.end_with?("DTO"))
    return "CIAPI" + text[0..-4]
  else
    return "CIAPI" + text;
  end
end

def createDTOHeader(directory, dtoHash)
  File.open("%s/%s.h" % [directory, APIifyName(dtoHash["id"])], "w") do |f|
    f.write "// Generated on %s\n" % DateTime.now
    f.write "#import <Foundation/Foundation.h>\n\n";

    myName = APIifyName(dtoHash["id"]);

    if (dtoHash.has_key?("properties"))
      dtoHash["properties"].each do |key, value|
        if (value.has_key?("$ref"))
          importName = APIifyName(value["$ref"][2..-1]);
          if (importName != myName)
            f.write "#import \"%s.h\"\n" % APIifyName(value["$ref"][2..-1]);
          end
        end
      end
    end

    f.write "\n";

    extends = dtoTypeToNSType(dtoHash);

    f.write "//" + dtoHash["description"] + "\n";
    f.write "@interface %s : %s \n" % [myName, extends];
    f.write "{\n";

    if (dtoHash.has_key?("properties"))
      dtoHash["properties"].each do |key, value|
        if (isObject(dtoTypeToNSType(value)))
          formatString = "  %s *%s;\n";
        else
          formatString = "  %s %s;\n";
        end

        f.write formatString % [APIifyName(dtoTypeToNSType(value)), key]; 
      end
    end

    f.write "}\n\n";
    
    if (dtoHash.has_key?("properties"))
      dtoHash["properties"].each do |key, value|
        f.write "// %s\n" % value["description"]; 
        if dtoHash.has_value?("demoValue")
          f.write "// Example: %s\n" % dtoHash["demoValue"];
        end

        if (isObject(dtoTypeToNSType(value)))
          formatString = "@property (retain) %s *%s;\n\n";
        else
          formatString = "@property %s %s;\n\n";
        end

        f.write formatString % [APIifyName(dtoTypeToNSType(value)), key]; 
      end
    end

    f.write "@end\n\n";
  end
end

def createDTOImpl(directory, dtoHash)
  File.open("%s/%s.m" % [directory, APIifyName(dtoHash["id"])], "w") do |f|
    f.write "#import \"%s.h\"\n\n" % APIifyName(dtoHash["id"]);

    f.write "@implementation %s\n\n" % APIifyName(dtoHash["id"]);


    if (dtoHash.has_key?("properties"))
      dtoHash["properties"].each do |key, value|
        f.write "@synthesize %s;\n" % key;
      end
    end

    f.write "\n@end";
  end
end

if (ARGV.count != 2)
  puts "Usage: synthesize.rb INPUT_SCHEMA OUTPUT_DIR"
  exit
end

if (!File.exist?(ARGV[0]))
  puts "Input schema does not exist";
  exit;
end

if (!File.directory?(ARGV[1]))
  puts "Output directory does not exist";
  exit;
end

jsonSource = "";
begin
  File.open(ARGV[0], "r").each_line do |line|
    jsonSource += line;
  end
  json = JSON.parse(jsonSource);
rescue
  puts "Schema JSON was ill-formed";
  exit
end

File.open("%s/CIAPIDataTypeObjects.h" % ARGV[1], "w") do |f|
  f.write "// Generated on %s\n" % DateTime.now
  json.each do |key, value|
    if (value != nil)
      f.write("#import \"%s.h\"\n" % APIifyName(value["id"])); 
      createDTOHeader(ARGV[1], value);
      createDTOImpl(ARGV[1], value);
    end
  end
end
