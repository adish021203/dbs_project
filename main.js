// Modules to control application life and create native browser window
const {app, BrowserWindow} = require('electron');
const { ipcMain } = require("electron");
const { exec } = require("child_process");
const path = require('path')
let mainWindow;
let cmd = "start cmd.exe /k sqlplus scott/tiger @";

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 1080,
    height: 740,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js')
    }
  })
  
}

function openIndex(){
  mainWindow.loadFile('src/html/index.html');
  console.log('path: ' + path.resolve(__dirname, 'register.sql'));
}

ipcMain.on('user:register', (event, data) => {
  exec(cmd+"register.sql", (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
    }
  });
});

ipcMain.on('user:donate', (event, data) => {
  exec(cmd+"donate.sql", (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
    }
  });
});

ipcMain.on('user:receive', (event, data) => {
  exec(cmd+"receive.sql", (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
    }
  });
});

ipcMain.on('user:inventory', (event, data) => {
  exec(cmd+"inventory.sql", (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
    }
  });
});

ipcMain.on('user:history', (event, data) => {
  exec(cmd+"history.sql", (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
    }
  });
});

ipcMain.on('user:feedback', (event, data) => {
  exec(cmd+"feedback.sql", (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
    }
  });
});

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.whenReady().then(() => {
  createWindow();
  openIndex();

  app.on('activate', function () {
    // On macOS it's common to re-create a window in the app when the
    // dock icon is clicked and there are no other windows open.
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
  })
})

// Quit when all windows are closed, except on macOS. There, it's common
// for applications and their menu bar to stay active until the user quits
// explicitly with Cmd + Q.
app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') app.quit()
})

