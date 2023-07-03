// APIs
window.addEventListener('DOMContentLoaded', () => {
  const replaceText = (selector, text) => {
    const element = document.getElementById(selector)
    if (element) element.innerText = text
  }

  for (const type of ['chrome', 'node', 'electron']) {
    replaceText(`${type}-version`, process.versions[type])
  }
})

const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("electron", {

  register: () => {
    ipcRenderer.send('user:register', {});
  },
  donate: () => {
    ipcRenderer.send('user:donate', {});
  },
  receive: () => {
    ipcRenderer.send('user:receive', {});
  },
  inventory: () => {
    ipcRenderer.send('user:inventory', {});
  },
  history: () => {
    ipcRenderer.send('user:history', {});
  },
  feedback: () => {
    ipcRenderer.send('user:feedback', {});
  }
});