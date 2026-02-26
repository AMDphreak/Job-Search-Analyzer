import std.stdio;
import std.string;
import config;

// Placeholder for the email downloading logic
void downloadEmails(AppConfig config) {
    writeln("Connecting to ", config.emailHost, "...");
    writeln("Downloading emails for ", config.emailUser, "...");
    // TODO: Implement IMAP connection and email download
    writeln("Finished downloading emails.");
}

// Placeholder for the RAG query logic
void askQuestion(AppConfig config) {
    write("Enter your question: ");
    string question = readln();
    writeln("Analyzing data to answer: ", question);
    // TODO: Implement RAG database query and AI call
    writeln("AI Response: [Not implemented yet]");
}

void main() {
    auto config = loadConfig();
    writeln("Job Search Analyzer CLI");
    writeln("-----------------------");

    bool running = true;
    while (running) {
        writeln("\nMenu:");
        writeln("1. Download & Process Emails");
        writeln("2. Ask a Question");
        writeln("3. Exit");
        write("Choose an option: ");

        string choice = readln();
        
        switch (strip(choice)) {
            case "1":
                downloadEmails(config);
                break;
            case "2":
                askQuestion(config);
                break;
            case "3":
                running = false;
                break;
            default:
                writeln("Invalid option. Please try again.");
                break;
        }
    }
    writeln("Exiting.");
}