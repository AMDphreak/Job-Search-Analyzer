module config;

import std.file : readText, exists;
import std.string : strip, indexOf, splitLines;
import std.algorithm.searching : startsWith, endsWith;
import std.stdio : stderr, writeln;
import core.stdc.stdlib : exit;

struct AppConfig {
    string emailHost;
    string emailUser;
    string emailPass;
    string geminiApiKey;
}

AppConfig loadConfig() {
    if (!exists(".env.local")) {
        stderr.writeln("Error: .env.local file not found. Please create it with your credentials.");
        exit(1);
    }

    string[string] envVars;
    auto content = readText(".env.local");
    foreach (line; splitLines(content)) {
        auto strippedLine = line.strip();
        if (strippedLine.length == 0 || startsWith(strippedLine, "#")) {
            continue; // Skip empty lines and comments
        }

        auto idx = indexOf(strippedLine, '=');
        if (idx > 0) {
            string key = strip(strippedLine[0 .. idx]);
            string value = strip(strippedLine[idx + 1 .. $]);

            // Handle quoted values
            if (value.length > 1 && startsWith(value, "\"") && endsWith(value, "\"")) {
                value = value[1 .. $-1];
            }
            envVars[key] = value;
        }
    }

    AppConfig config;
    config.emailHost = "EMAIL_HOST" in envVars ? envVars["EMAIL_HOST"] : null;
    config.emailUser = "EMAIL_USER" in envVars ? envVars["EMAIL_USER"] : null;
    config.emailPass = "EMAIL_PASS" in envVars ? envVars["EMAIL_PASS"] : null;
    config.geminiApiKey = "GEMINI_API_KEY" in envVars ? envVars["GEMINI_API_KEY"] : null;

    if (config.emailHost is null || config.emailUser is null || config.emailPass is null || config.geminiApiKey is null) {
        stderr.writeln("Error: One or more required variables are missing from .env.local.");
        stderr.writeln("Please ensure EMAIL_HOST, EMAIL_USER, EMAIL_PASS, and GEMINI_API_KEY are all set.");
        exit(1);
    }

    return config;
}