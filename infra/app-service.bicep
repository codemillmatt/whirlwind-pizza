// bicep file that creates an app service plan

@minLength(1)
@description('Primary location for all resources. Should specify an Azure region. e.g. `eastus2` ')
param location string

@description('Tags to be applied to all resources')
param tags object

@description('Abbreviations for objects')
param abbrs object

@minLength(1)
@maxLength(64)
@description('Unique token to be used in naming resources')
param resourceToken string

resource webAppServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: '${abbrs.webServerFarms}${resourceToken}'
  location: location
  tags: tags
  sku: {
    name: 'B1'
  }
  properties: {

  }
}

resource frontEnd 'Microsoft.Web/sites@2022-09-01' = {
  name: '${abbrs.webSitesAppService}${resourceToken}-front-end'
  location: location
  tags: union(tags, {
      'azd-service-name': 'front-end'
    })
  properties: {
    serverFarmId: webAppServicePlan.id
    clientAffinityEnabled: false
    siteConfig: {
      alwaysOn: true
    }
    httpsOnly: true
  }
  resource appSettings 'config' = {
    name: 'appsettings'
    properties: {
      ASPNETCORE_ENVIRONMENT: 'DEVELOPMENT'
      //AZURE_CLIENT_ID: managedIdentity.properties.clientId
      //APPLICATIONINSIGHTS_CONNECTION_STRING: webApplicationInsightsResources.outputs.APPLICATIONINSIGHTS_CONNECTION_STRING
      //'App:AppConfig:Uri': appConfigService.properties.endpoint
      //SCM_DO_BUILD_DURING_DEPLOYMENT: 'false'
      // App Insights settings
      // https://learn.microsoft.com/azure/azure-monitor/app/azure-web-apps-net#application-settings-definitions
      //APPINSIGHTS_INSTRUMENTATIONKEY: webApplicationInsightsResources.outputs.APPLICATIONINSIGHTS_INSTRUMENTATION_KEY
      ApplicationInsightsAgent_EXTENSION_VERSION: '~2'
      XDT_MicrosoftApplicationInsights_Mode: 'recommended'
      InstrumentationEngine_EXTENSION_VERSION: '~1'
      XDT_MicrosoftApplicationInsights_BaseExtensions: '~1'
    }
  }
}

resource menuApi 'Microsoft.Web/sites@2022-09-01' = {
  name: '${abbrs.webSitesAppService}${resourceToken}-menu-api'
  location: location
  tags: union(tags, {
      'azd-service-name': 'menu-api'
    })
  properties: {
    serverFarmId: webAppServicePlan.id
    clientAffinityEnabled: false
    siteConfig: {
      alwaysOn: true
    }
    httpsOnly: true
  }
  resource appSettings 'config' = {
    name: 'appsettings'
    properties: {
      ASPNETCORE_ENVIRONMENT: 'DEVELOPMENT'
      //AZURE_CLIENT_ID: managedIdentity.properties.clientId
      //APPLICATIONINSIGHTS_CONNECTION_STRING: webApplicationInsightsResources.outputs.APPLICATIONINSIGHTS_CONNECTION_STRING
      //'App:AppConfig:Uri': appConfigService.properties.endpoint
      //SCM_DO_BUILD_DURING_DEPLOYMENT: 'false'
      // App Insights settings
      // https://learn.microsoft.com/azure/azure-monitor/app/azure-web-apps-net#application-settings-definitions
      //APPINSIGHTS_INSTRUMENTATIONKEY: webApplicationInsightsResources.outputs.APPLICATIONINSIGHTS_INSTRUMENTATION_KEY
      ApplicationInsightsAgent_EXTENSION_VERSION: '~2'
      XDT_MicrosoftApplicationInsights_Mode: 'recommended'
      InstrumentationEngine_EXTENSION_VERSION: '~1'
      XDT_MicrosoftApplicationInsights_BaseExtensions: '~1'
    }
  }
}

resource checkoutApi 'Microsoft.Web/sites@2022-09-01' = {
  name: '${abbrs.webSitesAppService}${resourceToken}-checkout-api'
  location: location
  tags: union(tags, {
      'azd-service-name': 'checkout-api'
    })
  properties: {
    serverFarmId: webAppServicePlan.id
    clientAffinityEnabled: false
    siteConfig: {
      alwaysOn: true
    }
    httpsOnly: true
  }
  resource appSettings 'config' = {
    name: 'appsettings'
    properties: {
      ASPNETCORE_ENVIRONMENT: 'DEVELOPMENT'
      //AZURE_CLIENT_ID: managedIdentity.properties.clientId
      //APPLICATIONINSIGHTS_CONNECTION_STRING: webApplicationInsightsResources.outputs.APPLICATIONINSIGHTS_CONNECTION_STRING
      //'App:AppConfig:Uri': appConfigService.properties.endpoint
      //SCM_DO_BUILD_DURING_DEPLOYMENT: 'false'
      // App Insights settings
      // https://learn.microsoft.com/azure/azure-monitor/app/azure-web-apps-net#application-settings-definitions
      //APPINSIGHTS_INSTRUMENTATIONKEY: webApplicationInsightsResources.outputs.APPLICATIONINSIGHTS_INSTRUMENTATION_KEY
      ApplicationInsightsAgent_EXTENSION_VERSION: '~2'
      XDT_MicrosoftApplicationInsights_Mode: 'recommended'
      InstrumentationEngine_EXTENSION_VERSION: '~1'
      XDT_MicrosoftApplicationInsights_BaseExtensions: '~1'
    }
  }
}
