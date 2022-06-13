#!/usr/bin/env osascript -l JavaScript

// Build the normal argv/argc
const args = $.NSProcessInfo.processInfo.arguments;
const argv = []
const argc = args.count

for (let i = 0; i < argc; i++) {
  argv.push(ObjC.unwrap(args.objectAtIndex(i)))
}

const system = Application("System Events");
const frontApp = system.processes.whose({ frontmost: { '=': true } }).name();

const [_script1, _flagKey, _flagVal, _script2, appName, key, ...modifiers] = argv;

const app = Application(appName);
app.activate();
system.keystroke(key, { using: modifiers });

const nameStr = frontApp.toString()
const backToApp = nameStr[0].toUpperCase() + nameStr.slice(1);
Application(backToApp).activate();
