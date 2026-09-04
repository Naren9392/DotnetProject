output  "webappname"  {
  value = azurerm_windows_web_app.webapp.name
}

output  "webappurl"  {
  value = azurerm_windows_web_app.webapp.default_hostname
}