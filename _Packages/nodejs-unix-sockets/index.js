import { exec } from 'node:child_process';
import { join } from 'node:path';
import { IApplicationEventBody } from '../../../../common';
import { AdapterEventBody } from '../../bluetooth/dto/adapterEventBody.dto';
import { LinuxAdvertisementEventBody } from '../../bluetooth/dto/advertisementEventBody.dto';
import { CharacteristicEventBodyDto } from '../../bluetooth/dto/characteristicEventBody.dto';
import { ServiceEventBodyDto } from '../../bluetooth/dto/serviceEventBody.dto';
import { Peripheral } from '../../bluetooth/peripheral.provider';
import { BasePeripheral } from '../base-peripheral';
import ipc from '@achrinza/node-ipc';

enum SwiftBindingsCommands {
  initialize = 'initialize',
  start_advertising = 'start_advertising',
  start_application = 'start_application',
  stop_application = 'stop_application',
}

export class MacOsPeripheral extends BasePeripheral implements Peripheral {
  private readonly swiftBindingsExecutableDir = __dirname;

  constructor() {
    super();
    this.init();
  }

  private runCommand(command: SwiftBindingsCommands): void {
    this.startServer();
    console.log('starting child process');
    const cmd = `cd ${this.swiftBindingsExecutableDir} && ./swift-bindings ${command}`;

    const process = exec(cmd);

    process.stdout?.on('data', (data) => {
      console.log(`swift-bindings STDOUT: ${data}`);
    });

    process.stderr?.on('data', (data: string) => {
      console.log(`swift-bindings STDERR: ${data}`);
      const foundErrorMessage = data.match(/error\:/);
      const isSwiftError =
        foundErrorMessage !== null && foundErrorMessage.length > 0;

      if (isSwiftError) {
        throw new Error(data);
      }
    });
  }

  async startServer(): Promise<void> {
    const socketPath = '/tmp/swift-bindings.socket';

    ipc.config.id = 'unix-socket-server';
    ipc.config.retry = 1500;
    ipc.config.silent = false;
    ipc.config.networkProtocol = 'unix';
    ipc.config.socketRoot = '/tmp/';
    ipc.config.rawBuffer = false;
    ipc.config.delimiter = '\r';

    ipc.serve(socketPath, function () {
      // Uncomment for the Swift-Test-Client
      // ipc.server.on('message', function (data, socket) {
      //   console.log(
      //     'message ----- [Server][ipc] client sent data: ' + data.text
      //   );
      //   ipc.server.emit(
      //     socket,
      //     'message',
      //     data,
      //   );
      // });

      ipc.server.on('data', function (buff, socket) {
        const jsonString = buff.toString();
        const jsonPortionString = jsonString.split(ipc.config.delimiter)[0];
        if (jsonPortionString == 'QUIT') {
          console.log('[Server][ipc] client requested quit');
          return;
        }
        console.log(`[Server][ipc] get JSON: ${jsonPortionString}`);
        const json = JSON.parse(jsonPortionString);
        console.log(
          `[Server][ipc] client sent ${json.type}, data: ${json.data}`,
        );
        json.data = 'EjRWeJASNFZ4kA==';
        const stringToSend = JSON.stringify(json);
        ipc.server.emit(
          socket,
          stringToSend, //this can be anything you want so long as git syour client knows.
          '',
        );
      });

      ipc.server.on(
        'socket.disconnected',
        function (socket, destroyedSocketID) {
          console.log(
            '[Server][ipc] client ' + destroyedSocketID + ' has disconnected!',
          );
        },
      );
      ipc.server.on('connect', function (socket) {
        // ipc.server.emit(
        //   socket,
        //   'message', //this can be anything you want so long as your client knows.
        //   'Hello world!',
        // );
      });
      ipc.server.on('disconnect', function () {
        console.log('[Server][ipc] client has disconnected!');
      });
      ipc.server.on('error', function (error) {
        console.log('error [Server][ipc] has error: ' + error);
      });
      ipc.server.on('destroy', function (error) {
        console.log('[Server][ipc] socket was destroyed');
      });
      // ipc.server.on('message', function (data, socket) {
      //   console.log('[Server][ipc] got a message : ', data);
      //   ipc.server.emit(
      //     socket,
      //     'message', //this can be anything you want so long as
      //     //your client knows.
      //     data + ' world!'
      //   );
      // });
      console.log('[Server][ipc] server has started');
    });
    ipc.server.start();
    console.log('[Server][ipc] server is starting at ' + socketPath);
  }

  async init(): Promise<void> {
    const command = SwiftBindingsCommands.initialize;
    return this.runCommand(command);
  }

  async connectAdapter(props: AdapterEventBody): Promise<string> {
    throw new Error('NOT IMPLEMENTED');
  }

  connectAdvertisingManager(advertisementPath: string): Promise<void> {
    throw new Error('NOT IMPLEMENTED');
  }

  startAdvertisement(props: LinuxAdvertisementEventBody): Promise<string> {
    throw new Error('NOT IMPLEMENTED');
  }

  stopAdvertisement(): Promise<string> {
    throw new Error('NOT IMPLEMENTED');
  }

  emitManagedObjectsData(): Promise<void> {
    throw new Error('NOT IMPLEMENTED');
  }

  emitManagedObjects(): Promise<void> {
    throw new Error('NOT IMPLEMENTED');
  }

  startExampleApplication(): Promise<string> {
    throw new Error('NOT IMPLEMENTED');
  }

  startApplication(props: IApplicationEventBody): Promise<string> {
    throw new Error('NOT IMPLEMENTED');
  }

  addService(props: ServiceEventBodyDto): string {
    throw new Error('NOT IMPLEMENTED');
  }
  updateService(props: ServiceEventBodyDto): Promise<void> {
    throw new Error('NOT IMPLEMENTED');
  }

  addCharacteristic(props: CharacteristicEventBodyDto): string {
    throw new Error('NOT IMPLEMENTED');
  }

  addDescriptor(props): string {
    throw new Error('NOT IMPLEMENTED');
  }
}


