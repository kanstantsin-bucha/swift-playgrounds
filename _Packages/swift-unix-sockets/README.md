
# swift-bindings
 
## TODO:

- [v] verify that macos-ble can request the bluetooth access and start an advertising
    the process should be run from the program with UserInteraction priviledge otherwise PheripheralManager will hit `TCC_CRASHING_DUE_TO_PRIVACY_VIOLATION` abort 
- [v] update build script to build package into binary and put the binary into `dist` 
- [v] investigate if socket connection better that interprocess exchange
    - [v] verify that server can create local socket connection
    - [v] verify that swift-bindings can create local socket connection
    
    - [x] verify that server can create xpc connection
    - [x] verify that swift-bindings can create local xpc connection
    
- [ ] implement right start sequence for swift-bindings
- [ ] implement command exchange
- [ ] implement commands
- [ ] implement controller that perform commands using pheripheral
- [ ] implement peripheral 
