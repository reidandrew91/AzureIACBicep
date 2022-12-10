param trafficManagerProfiles_container_name string = 'testcontainer'
param publicIPAddresses_gateway_pip_externalid string = '/subscriptions/c9f2c2dc-e9ce-452a-b353-b7c5e5fd04ea/resourceGroups/testandrewreid/providers/Microsoft.Network/publicIPAddresses/testgateway-pip'
param publicIPAddresses_gateway1_pip_externalid string = '/subscriptions/c9f2c2dc-e9ce-452a-b353-b7c5e5fd04ea/resourceGroups/testandrewreid/providers/Microsoft.Network/publicIPAddresses/testgateway1-pip'
param endpointID1 string = '/subscriptions/c9f2c2dc-e9ce-452a-b353-b7c5e5fd04ea/resourceGroups/testandrewreid/providers/Microsoft.Network/trafficManagerProfiles/testcontainer/azureEndpoints/testgateway'
param endpointID2 string = '/subscriptions/c9f2c2dc-e9ce-452a-b353-b7c5e5fd04ea/resourceGroups/testandrewreid/providers/Microsoft.Network/trafficManagerProfiles/testcontainer/azureEndpoints/testgateway1'

resource trafficManagerProfiles_container_name_resource 'Microsoft.Network/trafficManagerProfiles@2018-04-01' = {
  name: trafficManagerProfiles_container_name
  location: 'global'
  properties: {
    profileStatus: 'Enabled'
    trafficRoutingMethod: 'Performance'
    dnsConfig: {
      relativeName: trafficManagerProfiles_container_name
      ttl: 60
    }
    monitorConfig: {
      profileMonitorStatus: 'Online'
      protocol: 'HTTP'
      port: 80
      path: '/'
      intervalInSeconds: 30
      toleratedNumberOfFailures: 3
      timeoutInSeconds: 10
    }
    endpoints: [
      {
        id: endpointID1
        name: 'testgateway'
        type: 'Microsoft.Network/trafficManagerProfiles/azureEndpoints'
        properties: {
          endpointStatus: 'Enabled'
          endpointMonitorStatus: 'Online'
          targetResourceId: publicIPAddresses_gateway_pip_externalid
          target: 'testdeployment${trafficManagerProfiles_container_name}12.canadacentral.cloudapp.azure.com'
          weight: 1
          priority: 1
          endpointLocation: 'Canada Central'
        }
      }
      {
        id: endpointID2
        name: 'testgateway1'
        type: 'Microsoft.Network/trafficManagerProfiles/azureEndpoints'
        properties: {
          endpointStatus: 'Enabled'
          endpointMonitorStatus: 'Online'
          targetResourceId: publicIPAddresses_gateway1_pip_externalid
          target: 'testdeployment${trafficManagerProfiles_container_name}34.canadaeast.cloudapp.azure.com'
          weight: 1
          priority: 2
          endpointLocation: 'Canada East'
        }
      }
    ]
    trafficViewEnrollmentStatus: 'Disabled'
    maxReturn: 0
  }
}
